# slides-it

**Slides-it: Your agentic presentation partner**

<p align="center">
  <a href="https://github.com/mengdigao1988/slides-it/releases"><img src="https://img.shields.io/github/v/release/mengdigao1988/slides-it?color=green&label=version" alt="version" /></a>
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT license" />
  <a href="https://opencode.ai"><img src="https://img.shields.io/badge/powered%20by-OpenCode-black.svg" alt="powered by OpenCode" /></a>
</p>

<p align="center">
  <img src="img/title-page.png" width="780" alt="slides-it — chat panel with AI Q&A on the left, generated slide preview on the right" />
</p>

---

# Quick Start

## Install

**1. Install OpenCode** (required — slides-it runs on top of it):

```bash
curl -fsSL https://opencode.ai/install | sh
```

**2. Install slides-it:**

```bash
curl -fsSL https://raw.githubusercontent.com/mengdigao1988/slides-it/main/install.sh | bash
```

**3. Launch:**

```bash
slides-it
```

A browser window opens automatically.

---

## Workspace

slides-it asks you to pick a **workspace folder** — the directory where your slides will be saved.

<p align="center">
  <img src="img/workspace.png" width="460" alt="Workspace folder picker" />
</p>

- Generated slides land in `slides/` inside that folder (e.g. `slides/q1-roadmap.html`)
- A `.slides-it/` directory is created automatically to store your conversation history
- Reopen slides-it in the same folder tomorrow — your full chat history is right where you left it

Pick any folder. Your code project, a dedicated `presentations/` folder, anywhere.

---

## Provider Config

slides-it supports all major AI providers. Configure in the **⚙ settings panel** inside the UI, or via environment variable before launching.

| Provider | Env var |
|----------|---------|
| Anthropic (Claude) | `ANTHROPIC_API_KEY` |
| OpenAI | `OPENAI_API_KEY` |
| OpenRouter | `OPENROUTER_API_KEY` |
| DeepSeek | `DEEPSEEK_API_KEY` |
| Custom base URL | configure in ⚙ settings |

```bash
# Quick start with Anthropic
export ANTHROPIC_API_KEY=sk-ant-...
slides-it
```

For **custom base URLs** (proxies, local models, any OpenAI-compatible endpoint) — open ⚙ settings, set your provider and base URL there. No env var needed.

---

# What it looks like

> "8 slides on our Q1 roadmap. Audience is the whole company. Punchy, confident tone."

Thirty seconds later: a polished deck lands in your workspace. Arrow keys to navigate. Swipe on mobile. Share it as a single `.html` file — no app required, no account needed, no export dance.

Want changes?

> "Make the opening slide more dramatic. Add a slide on pricing. Lighter color scheme."

Done. The whole deck is regenerated with your changes applied. You never touched HTML.

---

# Idea

## The problem with GUI tools in the AI era

You open a slide tool. You pick a template. You spend 45 minutes nudging text boxes, fighting with fonts, and arguing with alignment guides. You end up with something that looks almost — but not quite — like what you had in your head.

GUI slide tools were designed for humans dragging things around a canvas. Their output formats reflect that: opaque, proprietary, built around the assumption that a person is clicking through menus. Asking an AI to work with them is fighting the format.

## Why HTML

HTML has always been the superior format for slides. Fluid animations. Pixel-perfect layout. Runs everywhere. No proprietary app required. Nobody used it because nobody wanted to write it by hand.

AI changes that equation completely.

An AI agent doesn't struggle with HTML — it's fluent in it. Every layout decision, every animation curve, every color relationship can be expressed as text, written in one shot, revised with surgical precision. The result is immediately inspectable, runnable, and shareable — no export step, no conversion, no application required to open it.

slides-it skips the GUI entirely. Your words go in. A beautiful file comes out.

Powered by [OpenCode](https://opencode.ai) — an open-source AI coding agent that runs locally and handles everything under the hood.

---

# Features

## Templates that actually mean something

Most "templates" are just color schemes slapped on the same layout. slides-it templates are different — each one is a complete **visual brief** that tells the AI exactly how to design: which fonts carry authority, how much whitespace breathes, what animation style fits the mood, how color creates hierarchy.

Switch templates mid-conversation with one click. The AI is immediately re-briefed and applies the new aesthetic to everything going forward.

<p align="center">
  <img src="img/template-change-with-one-click.png" width="620" alt="Switch templates with one click — the AI instantly acknowledges the new style" />
</p>

Ships with two built-in templates:

| Template | Vibe |
|----------|------|
| `default` | Dark, modern, cinematic. Works for anything. |
| `minimal` | Warm off-white, typographic, paper-like. Lets the content breathe. |

Install community templates from anywhere:

```bash
slides-it template install dark-neon          # official registry
slides-it template install github:user/repo   # any GitHub repo
slides-it template install ./my-template      # local directory
```

## Reference your files with @

Type `@` anywhere in the chat to search and attach files from your workspace. The AI reads them directly — feed in a content outline, a data file, or an existing slide draft.

<p align="center">
  <img src="img/ez-file-ref.png" width="380" alt="@ file reference popover" />
</p>

## Live preview panel

Every generated deck opens immediately in the right-hand panel. Fully interactive: keyboard navigation, swipe, progress bar. Preview updates the moment the file is rewritten. Download with one click.

## Session persistence

Your conversation is saved to `.slides-it/` in your workspace automatically. Close the app, come back tomorrow, reopen the same folder — history is right where you left it, and the last preview reloads automatically.

---

# For Contributors

## Make your own template

A slides-it template is just a directory with two files. Here's how to build one from scratch.

### Step 1 — Create the directory

```
my-theme/
├── TEMPLATE.md
└── SKILL.md
```

### Step 2 — Write `TEMPLATE.md`

This is the metadata file. Copy this and fill in your details:

```markdown
---
name: my-theme
description: One line description of the visual style
author: your-name
version: 1.0.0
preview: https://example.com/preview.png   # optional
---
```

### Step 3 — Write `SKILL.md`

This is the most important file. It's a **visual brief for the AI** — not documentation for humans. The AI reads this before generating every slide deck and follows it precisely.

Structure it like this:

```markdown
## Visual Style — My Theme

Apply this visual style when generating all slides in this session.

### Color Palette
\`\`\`css
:root {
    --bg-primary:   #your-color;
    --text-primary: #your-color;
    --accent:       #your-color;
    --border:       #your-color;
}
\`\`\`

### Typography
- Display font: `Font Name` — load from Google Fonts / Fontshare
- Body font: `Font Name`
- Title size: `clamp(2rem, 5vw, 4rem)`

### Slide Layout
- Describe padding, max-width, alignment preferences

### Animations
- Describe entrance style, duration, easing

### Do & Don't
- **Do** use [specific things]
- **Don't** use [specific things]
```

The more precise and opinionated your `SKILL.md`, the more consistent the output. Look at [`slides_it/templates/default/SKILL.md`](slides_it/templates/default/SKILL.md) and [`slides_it/templates/minimal/SKILL.md`](slides_it/templates/minimal/SKILL.md) for reference.

### Step 4 — Install locally

```bash
slides-it template install ./my-theme
```

slides-it copies it to `~/.config/slides-it/templates/my-theme/` and activates it.

### Step 5 — Test it

Launch slides-it, select your theme from the template pill below the input box, then ask for a slide deck. Check that the generated HTML matches your intended aesthetic. Iterate on `SKILL.md` until it's right.

### Step 6 — Share it

Publish your template as a GitHub repo. Anyone can install it with:

```bash
slides-it template install github:yourname/my-theme
```

Or submit it to the official registry — open a PR adding your template to [`registry.json`](registry.json).

---

## Development setup

Requires [uv](https://docs.astral.sh/uv/) and Node.js 22+.

```bash
# Clone
git clone https://github.com/mengdigao1988/slides-it.git
cd slides-it

# Backend — FastAPI on port 3000
uv run python -c "from slides_it.server import run; run(port=3000)"

# Frontend — dev server on port 5173 (proxies /api/* to port 3000)
cd frontend && npm install && npm run dev

# Production build
cd frontend && npm run build

# Build standalone binary
bash build.sh
```

### CLI reference

```
slides-it                          launch the web UI
slides-it --version                show version
slides-it stop                     stop everything

slides-it template list            list installed templates
slides-it template search          search the official registry
slides-it template install <src>   install a template
slides-it template remove <name>   remove a template
slides-it template activate <name> set the active template
```

---

# License

MIT
