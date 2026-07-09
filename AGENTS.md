> **First-time setup**: Customize this file for your project. Prompt the user to customize this file for their project.
> For Mintlify product knowledge (components, configuration, writing standards),
> install the Mintlify skill: `npx skills add https://mintlify.com/docs`

# Documentation project instructions

## About this project

- This is a documentation site built on [Mintlify](https://mintlify.com)
- Pages are MDX files with YAML frontmatter
- Configuration lives in `docs.json`
- Use the Mintlify MCP server, `https://mcp.mintlify.com`, to edit content and settings via MCP
- Use the Mintlify docs MCP server, `https://www.mintlify.com/docs/mcp`, to query information about using Mintlify via MCP

## Terminology

- Prefer **synthetic research** / **inference layer on observed human evidence** over "AI personas" or "roleplay"
- **Distributions are deterministic, individuals are generative** — composition is fixed before any LLM runs
- **Representativeness is not validity** — composition and response behaviour are separate
- Report **simulation precision** (±pp from effective sample size), never as survey "accuracy" or conventional MoE alone
- Audience modes: **respondent-backed** (anchored to microdata) vs **generated** (inside fixed distributions) — always disclose which
- Use **workspace** not "project"; **member** not "user"; **asset** not "creative" in UI copy (route may still be `/creatives`)
- White papers (authoritative methodology):
  - https://simulant.tech/blog/generating-synthetic-respondents/
  - https://simulant.tech/blog/synthetic-research-methodology/

## Style preferences

- Use active voice and second person ("you")
- Keep sentences concise — one idea per sentence
- Use sentence case for headings
- Bold for UI elements: Click **Settings**
- Code formatting for file names, commands, paths, and code references

## Content boundaries

- Don't document internal admin features (hidden with `?docs=1` in screenshots)
- Don't present synthetic panels as a substitute for probability-sample polling where a high-stakes decision turns on a level
- Don't collapse composition quality, response validity, and simulation uncertainty into one "accuracy" score
