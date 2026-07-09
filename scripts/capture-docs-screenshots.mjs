/**
 * Docs screenshot capture — run via Playwright MCP browser_run_code_unsafe.
 * Uses ?docs=1 to hide Platform > Admin and applies fictional US campaign mock text.
 *
 * Paste the exported async function body into browser_run_code_unsafe, or import
 * from an authenticated Playwright session pointed at localhost:5173.
 */

export const MOCK_REPLACEMENTS = [
  ['2_AES2025_CSV_100279_general', 'Q3 Tracking poll'],
  ['Cost-of-Living — TV Spot A/B', 'Cost-of-Living — :30 TV Spot A/B'],
  ['Hero asset A/B', 'Cost-of-Living — :30 TV Spot A/B'],
  ['Healthcare Message — Digital Video', 'Healthcare Message — Digital Video'],
  ['Albo approval', 'Healthcare Message — Digital Video'],
  ['Education Plan — Social Cutdown', 'Education Plan — Social Cutdown'],
  ['Larissa', 'Education Plan — Social Cutdown'],
  ['Tax Relief — Mailer Copy', 'Tax Relief — Mailer Copy'],
  ['Hanson', 'Tax Relief — Mailer Copy'],
  ['Closing Argument — 30s TV Spot', 'Closing Argument — 30s TV Spot'],
  ['AJP', 'Closing Argument — 30s TV Spot'],
  ['Voting intention', 'Ballot test — General'],
  ['Melbourne renters', 'Suburban Swing Voters'],
  ['Melbourne', 'Detroit metro'],
  ['Australian adults', 'American adults'],
  ['Australian', 'American'],
  ['Australia', 'United States'],
  ['Greens', 'Reyes for Senate'],
  ['Reyes for Senate for Senate', 'Reyes for Senate'],
  ['Dataset', 'Voter file'],
  ['NC', 'CS'],
];

export function applyMockContent() {
  const replacements = MOCK_REPLACEMENTS;
  const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
  const nodes = [];
  while (walker.nextNode()) nodes.push(walker.currentNode);
  for (const node of nodes) {
    let t = node.textContent ?? '';
    if (!t.trim()) continue;
    for (const [from, to] of replacements) {
      if (t.includes(from)) t = t.split(from).join(to);
    }
    if (t !== node.textContent) node.textContent = t;
  }
  // Workspace avatar letter
  document.querySelectorAll('button').forEach((btn) => {
    if (btn.textContent?.includes('Reyes for Senate')) {
      const badge = btn.querySelector(':scope > div > div');
      if (badge?.textContent?.trim().length === 1) badge.textContent = 'R';
    }
  });
  // Hide noisy dev rows
  document.querySelectorAll('table tbody tr').forEach((tr) => {
    const t = tr.textContent ?? '';
    if (
      (t.includes('Untitled') && !t.includes('Cost-of-Living')) ||
      t.includes('AES2025') ||
      /^Test\s+1 test\s+—\s+Running/.test(t.replace(/\s+/g, ' '))
    ) {
      tr.style.display = 'none';
    }
  });
  // Hide setup guide card
  const guide = document.querySelector('[class*="setup"]') ?? document.querySelector('a[href*="settings?section=members"]')?.closest('div[class]');
  document.querySelectorAll('aside a').forEach((a) => {
    if (a.textContent?.includes('Invite your team') || a.textContent?.includes('Add a dataset')) {
      let el = a.closest('div');
      for (let i = 0; i < 5 && el; i++) {
        if (el.querySelector('.label-mono')?.textContent?.includes('Get started')) {
          el.style.display = 'none';
          break;
        }
        el = el.parentElement;
      }
    }
  });
}
