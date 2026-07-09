/**
 * Capture docs screenshots from the Reyes for Senate demo workspace.
 * Uses Chrome CDP Page.captureScreenshot to avoid Playwright font/WebGL hangs.
 *
 * Usage: node scripts/capture-reyes-screenshots.mjs
 */

import { createRequire } from 'module';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const require = createRequire(path.join('/Users/nicholascarlton/app', 'package.json'));
const { chromium } = require('playwright');
const OUT = path.join(__dirname, '../images/app');
const BASE = 'http://localhost:5173';
const WS = 'a1111111-1111-4111-8111-111111111111';
const AUTH = path.join(__dirname, '.auth-state.json');
const ids = {
  flowCol: 'a5555555-5555-4555-8555-555555555551',
  swing: 'a3333333-3333-4333-8333-333333333331',
};

const jobs = [
  ['dashboard.png', '/simulations?docs=1'],
  ['tests-list.png', '/simulations?docs=1'],
  ['focus-groups-list.png', '/simulations?docs=1'],
  ['cohorts-list.png', '/cohorts?docs=1'],
  ['datasets.png', '/datasets?docs=1'],
  ['creatives.png', '/creatives?docs=1'],
  ['reports.png', '/reports?docs=1'],
  ['memos.png', '/memos?docs=1'],
  ['agent.png', '/agent?docs=1'],
  ['settings-workspace.png', '/settings?section=workspace&docs=1'],
  ['settings-members.png', '/settings?section=members&docs=1'],
  ['settings-billing.png', '/settings?section=billing&docs=1'],
  ['test-builder.png', `/simulations/${ids.flowCol}?tab=model&docs=1`, 2800],
  ['focus-group-builder.png', `/simulations/${ids.flowCol}?tab=model&docs=1`, 2200],
  ['test-results.png', `/simulations/${ids.flowCol}?tab=results&docs=1`, 2800],
  ['focus-group-room.png', `/simulations/${ids.flowCol}?tab=results&docs=1`, 2800],
  ['test-themes.png', `/simulations/${ids.flowCol}?tab=results&docs=1`, 2200],
  ['cohort-builder.png', `/cohorts/${ids.swing}?tab=respondents&docs=1`, 2800],
  ['cohort-report.png', `/cohorts/${ids.swing}?tab=report&docs=1`, 2800],
  ['insights.png', '/reports?docs=1'],
  ['compare.png', '/reports?docs=1'],
];

async function hideNoise(page) {
  await page.evaluate(() => {
    for (const el of document.querySelectorAll('div')) {
      const t = el.textContent || '';
      if (t.includes('Get started') && t.includes('Invite your team') && t.length < 500) {
        el.style.display = 'none';
      }
    }
    document.querySelectorAll('canvas').forEach((c) => {
      if (c.width > 200 || c.height > 200) c.style.visibility = 'hidden';
    });
  });
}

async function shot(page, client, name, urlPath, waitMs = 1600) {
  await page.goto(`${BASE}${urlPath}`, { waitUntil: 'domcontentloaded', timeout: 60000 });
  await page.evaluate((id) => localStorage.setItem('simulant.activeWorkspaceId', id), WS);
  await page.waitForTimeout(waitMs);
  // Wait until authenticated workspace chrome is present
  try {
    await page.waitForFunction(
      () => /Reyes for Senate|Cost-of-Living|Suburban Swing|Morning brief|Week 12 message/.test(document.body?.innerText || ''),
      null,
      { timeout: 15000 },
    );
  } catch {
    // one reload retry
    await page.evaluate((id) => localStorage.setItem('simulant.activeWorkspaceId', id), WS);
    await page.reload({ waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(waitMs);
  }
  await hideNoise(page);
  await page.waitForTimeout(300);
  // Ensure sidebar is painted
  await page.evaluate(() => window.scrollTo(0, 0));
  const { data } = await client.send('Page.captureScreenshot', {
    format: 'png',
    fromSurface: true,
    captureBeyondViewport: false,
  });
  const outPath = path.join(OUT, name);
  fs.writeFileSync(outPath, Buffer.from(data, 'base64'));
  const body = await page.locator('body').innerText();
  return {
    name,
    bytes: fs.statSync(outPath).size,
    hasReyes: /Reyes|Cost-of-Living|Suburban Swing|Morning brief|Week 12/.test(body),
    hasGreens: /Greens|Albo|Hanson|Melbourne|AES2025/.test(body),
    hasAdmin: /\bAdmin\b/.test(body),
    snippet: body.replace(/\s+/g, ' ').slice(0, 140),
  };
}

if (!fs.existsSync(AUTH)) {
  console.error('Missing auth state at', AUTH);
  process.exit(1);
}

fs.mkdirSync(OUT, { recursive: true });

const browser = await chromium.launch({
  headless: true,
  channel: 'chrome',
  args: ['--disable-gpu', '--disable-dev-shm-usage'],
});
const context = await browser.newContext({
  storageState: AUTH,
  viewport: { width: 1440, height: 900 },
});
const page = await context.newPage();

await page.goto(`${BASE}/simulations?docs=1`, { waitUntil: 'domcontentloaded', timeout: 60000 });
await page.evaluate((id) => localStorage.setItem('simulant.activeWorkspaceId', id), WS);
await page.reload({ waitUntil: 'domcontentloaded' });
await page.waitForTimeout(2500);

const url = page.url();
const body = await page.locator('body').innerText();
if (url.includes('/login') || url.includes('/auth') || !body.includes('Reyes')) {
  console.error('Auth/workspace failed.');
  console.error('URL:', url);
  console.error(body.slice(0, 1000));
  await browser.close();
  process.exit(1);
}

const client = await context.newCDPSession(page);
const results = [];
for (const [name, urlPath, wait] of jobs) {
  try {
    const r = await shot(page, client, name, urlPath, wait ?? 1600);
    console.log('ok', r.name, r.bytes, `reyes=${r.hasReyes}`, `greens=${r.hasGreens}`, `admin=${r.hasAdmin}`);
    results.push(r);
  } catch (e) {
    console.error('fail', name, String(e).slice(0, 300));
    results.push({ name, error: String(e).slice(0, 300) });
  }
}

await browser.close();
const failed = results.filter((r) => r.error || r.hasGreens || !r.hasReyes);
console.log(JSON.stringify({ total: results.length, failed: failed.length, failedNames: failed.map((f) => f.name) }, null, 2));
process.exit(failed.length ? 2 : 0);
