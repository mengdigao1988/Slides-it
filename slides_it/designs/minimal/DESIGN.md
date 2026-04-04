---
name: minimal
description: Warm off-white light theme — frosted-glass cards, typographic, distraction-free
author: slides-it
version: 1.0.0
preview: bundled
---

## Visual Style — Minimal Theme

Apply this visual style when generating all slides in this session.

This theme pairs a warm, off-white background with frosted-glass cards and subtle geometric depth. Think: a well-designed printed magazine with a modern glass layer — warm paper feel, elevated with translucency.

### Color Palette (Unchanged)

```css
:root {
    --bg-primary:    #FAF9F6;   /* warm off-white — main background */
    --bg-secondary:  #F0EEE8;   /* slightly darker warm grey */
    --bg-card:       rgba(255, 255, 255, 0.55); /* frosted glass white */
    --text-primary:  #1A1916;   /* near-black warm ink */
    --text-secondary:#6B6560;   /* warm mid-grey */
    --text-muted:    #A09890;   /* subtle captions */
    --accent:        #1A1916;   /* same as text — monochrome accent */
    --accent-2:      #6B6560;   /* secondary accent — warm grey */
    --border:        rgba(226, 222, 213, 0.6);  /* soft warm border, semi-transparent */
    --border-strong: #C9C4B8;   /* stronger divider */
}
```

### Typography

- **Display font**: `DM Serif Display` (headings) — load from Google Fonts
- **Body font**: `DM Sans` (body, captions) — load from Google Fonts
- Font link tag:
  ```html
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,300&display=swap" rel="stylesheet">
  ```
- Title size (h1): `64px`, weight 400
- Section heading (h2): `42px`, weight 400
- Subtitle size: `22px`, weight 300
- Body size: `18px`
- Label: `13px`, letter-spacing `0.1em`, uppercase
- Card title: `24px` (DM Serif Display)
- Card body: `17px`
- Stat number: `64px`, weight 400
- Stat label: `15px`, uppercase
- Line height: `1.75` for body, `1.15` for h1, `1.2` for h2
- Letter spacing: `-0.02em` for large headings
- Card title: weight 400 (DM Serif Display)
- Card body / body-text: weight 400
- Stat label: weight 400

All sizes are fixed `px` — designed for the 1920×1080 canvas. JS `transform: scale()`
handles viewport adaptation. **Never use `clamp()` or viewport-relative units.**

### Background Layers (Subtle Geometric Depth)

**Layer 1 — Base gradient (subtle warmth):**
```css
body::before {
    content: '';
    position: fixed;
    inset: 0;
    background: linear-gradient(180deg, #FAF9F6 0%, #F5F3EE 50%, #FAF9F6 100%);
    z-index: -3;
}
```

**Layer 2 — Geometric circles (blurred, warm amber tones):**
```css
.geo-shape-1, .geo-shape-2, .geo-shape-3 {
    position: fixed;
    border-radius: 50%;
    filter: blur(60px);
    opacity: 0.20;
    z-index: -2;
    pointer-events: none;
}
.geo-shape-1 {
    width: 600px;
    height: 600px;
    background: #FFB347;
    top: -200px;
    right: -100px;
}
.geo-shape-2 {
    width: 400px;
    height: 400px;
    background: #FFA633;
    bottom: -100px;
    left: -100px;
}
.geo-shape-3 {
    width: 300px;
    height: 300px;
    background: #EE9526;
    top: 50%;
    left: 30%;
    opacity: 0.15;
}
```

**Layer 3 — Subtle diagonal lines (paper texture):**
```css
body::after {
    content: '';
    position: fixed;
    inset: 0;
    background: repeating-linear-gradient(
        45deg,
        transparent,
        transparent 3px,
        rgba(0, 0, 0, 0.008) 3px,
        rgba(0, 0, 0, 0.008) 6px
    );
    z-index: -1;
    pointer-events: none;
}
```

### Slide Layout

- **1920×1080 fixed canvas** — each slide uses a `.slide-canvas` (1920×1080px),
  scaled to fit the viewport via JS `transform: scale()`. See SKILL.md CSS Rules.
- Content width tiers (inside canvas, via `max-width` + `margin: 0 auto`):
  - Default (`1200px`): Cover, Quote, Closing
  - Wide (`1600px`): content-heavy slides (grids, multi-column, process flows)
- Canvas padding: `60px 80px`
- **Canvas utilization** — Elements should fill approximately 70–80% of the
  1920×1080 canvas area. Even in a minimal design, slides should not feel empty.
  Use larger serif headings, more generous card heights, wider grids, and
  comfortable padding to occupy the space. The calm feeling comes from typography
  and whitespace *rhythm*, not from leaving the canvas half-empty.
  - **Content slides** (Feature Cards, Stats, Two-Column, Step Flow): grid/flex
    containers should stretch toward the canvas edges. Frosted-glass cards should
    have ample internal padding and body text so they feel substantial.
  - **Sparse slides** (Cover, Quote, Closing): add decorative fills — thin geometric
    rules, positioned warm-amber circles (low opacity), large typographic ornaments
    (e.g. oversized `"` for quotes in `var(--border)` color), or horizontal `1px`
    dividers that span most of the canvas width. These anchor the composition
    without breaking the calm, paper-like feel.
  - **Never** leave more than ~20% of the canvas visually empty on any slide.
- Title slide: large serif heading left-aligned + thin `1px` rule beneath + muted subtitle
- Content slides: heading top with `border-bottom: 1px solid var(--border)` separator, content below

### Component Library

These are independent, composable building blocks. Mix them freely on any slide —
they are not locked to specific layouts.

#### Reveal Animation (.reveal)

Add `.reveal` to any element that should animate on scroll. JS adds `.visible`
via IntersectionObserver. This theme uses opacity-only transitions — no
directional motion (translateY/translateX) — to preserve the calm, paper-like feel.

```css
.reveal {
    opacity: 0;
    transition: opacity 0.4s ease;
}
.reveal.visible {
    opacity: 1;
}
/* Stagger children */
.reveal:nth-child(1) { transition-delay: 0s; }
.reveal:nth-child(2) { transition-delay: 0.06s; }
.reveal:nth-child(3) { transition-delay: 0.12s; }
.reveal:nth-child(4) { transition-delay: 0.18s; }
.reveal:nth-child(5) { transition-delay: 0.24s; }
.reveal:nth-child(6) { transition-delay: 0.30s; }
.reveal:nth-child(7) { transition-delay: 0.36s; }
.reveal:nth-child(8) { transition-delay: 0.42s; }
```

No `.title-reveal` in this theme — cover headings use the same `.reveal` fade.

#### Card (.card)

Frosted-glass container for any grouped content — features, evidence, info blocks.

```html
<div class="card">
    <i data-lucide="circle-dashed" class="card-icon"></i>
    <p class="card-label">01</p>
    <p class="card-title">Title</p>
    <p class="card-body">Body text describing the item.</p>
</div>
```

All inner elements are optional — use only what the content needs.

```css
.card {
    background: var(--bg-card);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 28px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
    display: flex;
    flex-direction: column;
    transition: transform 0.25s ease, box-shadow 0.25s ease;
}
.card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.10);
}
.card-icon        { width: 28px; height: 28px; color: var(--accent-2); margin-bottom: 12px; transition: transform 0.2s ease; }
.card:hover .card-icon { transform: scale(1.05); }
.card-label       { font-size: 13px; letter-spacing: 0.08em; text-transform: uppercase; color: var(--text-muted); margin-bottom: 10px; }
.card-title       { font-family: 'DM Serif Display', serif; font-size: 24px; margin-bottom: 12px; }
.card-body        { font-size: 17px; color: var(--text-secondary); line-height: 1.7; flex: 1; }
```

#### Stat Card (.stat-card)

Large metric display. Numbers appear statically with fade-in — no counter animation.

```html
<div class="stat-card">
    <div class="stat-number">85%</div>
    <div class="stat-label">Growth Rate</div>
    <div class="stat-desc">Year over year revenue increase</div>
</div>
```

```css
.stat-card {
    background: var(--bg-card);
    backdrop-filter: blur(16px);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 48px 40px;
    text-align: center;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
    border-bottom: 2px solid var(--border-strong);
}
.stat-number { font-family: 'DM Serif Display', serif; font-size: 64px; font-weight: 400; color: var(--text-primary); line-height: 1; letter-spacing: -0.03em; margin-bottom: 12px; }
.stat-label  { font-size: 15px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 12px; }
.stat-desc   { font-size: 15px; color: var(--text-secondary); line-height: 1.5; opacity: 0.8; }
```

No `.gradient-text` on numbers — minimal stays monochrome.

#### Quote Block (.quote-block)

```html
<div class="quote-deco">&ldquo;</div>
<div class="quote-block">
    <blockquote>&ldquo;The quote text goes here.&rdquo;</blockquote>
    <cite>Attribution</cite>
</div>
```

```css
.quote-block            { border-left: 2px solid var(--border-strong); padding-left: 32px; max-width: 1200px; }
.quote-block blockquote { font-family: 'DM Serif Display', serif; font-size: 40px; font-style: italic; line-height: 1.4; margin-bottom: 20px; }
.quote-block cite       { font-size: 14px; color: var(--text-muted); letter-spacing: 0.05em; text-transform: uppercase; font-style: normal; font-family: 'DM Sans', sans-serif; }
.quote-deco             { position: absolute; font-family: 'DM Serif Display', serif; font-size: 280px; line-height: 1; color: var(--border); opacity: 0.3; pointer-events: none; z-index: 0; }
```

No background color on `.quote-block` — let the typography speak.

#### Step Flow (.step-flow)

Horizontal process with numbered circles and connectors. Alternate `.step`
and `.step-connector` as siblings inside `.step-flow`.

```html
<div class="step-flow">
    <div class="step">
        <div class="step-circle">1</div>
        <div class="step-title">Describe</div>
        <div class="step-desc">Tell us your topic and audience.</div>
    </div>
    <div class="step-connector"></div>
    <div class="step">
        <div class="step-circle">2</div>
        <div class="step-title">Generate</div>
        <div class="step-desc">AI creates your slides.</div>
    </div>
    <!-- more steps + connectors as needed -->
</div>
```

```css
.step-flow      { display: flex; align-items: flex-start; max-width: 1600px; margin: 0 auto; }
.step           { flex: 1; display: flex; flex-direction: column; align-items: center; text-align: center; gap: 16px; }
.step-circle    { width: 64px; height: 64px; border-radius: 50%; background: var(--text-primary); color: var(--bg-primary); font-family: 'DM Serif Display', serif; font-size: 24px; font-weight: 400; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
.step-connector { flex: 0 0 32px; height: 1px; background: var(--border); margin-top: 32px; align-self: flex-start; }
.step-title     { font-family: 'DM Serif Display', serif; font-size: 20px; }
.step-desc      { font-size: 16px; color: var(--text-secondary); line-height: 1.6; max-width: 200px; }
```

Circles are solid fill — no gradient, no glow, no shadow.

#### Evidence List (.evidence-list)

Styled bullet list with em-dash markers. Use inside `.card`, `.two-col-main`, or any container.

```html
<ul class="evidence-list">
    <li>First piece of evidence or supporting point</li>
    <li>Second supporting point</li>
</ul>
```

```css
.evidence-list    { list-style: none; padding: 0; display: flex; flex-direction: column; gap: 12px; }
.evidence-list li { padding-left: 18px; position: relative; font-size: 18px; color: var(--text-primary); line-height: 1.5; }
.evidence-list li::before { content: '\2014'; position: absolute; left: 0; top: 0; color: var(--border-strong); font-family: 'DM Serif Display', serif; }
```

#### Chart Container (.chart-container)

Wrapper for any ECharts visualization. Can appear on any slide, in any layout.
See §Data Visualization for chart type selection and theme-specific styling.

```html
<div class="chart-container" id="chart-{purpose}"
     style="width:{w}px; height:{h}px"></div>
```

```css
.chart-container { position: relative; flex-shrink: 0; }
```

Common sizing by context:
- Inside a column (`.two-col-main`, `.two-col-aside`): `width:100%; height:320–400px`
- Full-width standalone: `max-width:1400px; height:500px; margin:0 auto`
- Inside a `.card` (sparkline/mini): `width:100%; height:140–200px`
- Below a stats row: `max-width:1200px; height:300px; margin:24px auto 0`

JS init pattern (inside `window.addEventListener('load', ...)`):
```javascript
if (typeof echarts !== 'undefined') {
    const el = document.getElementById('chart-{purpose}');
    if (el) {
        const chart = echarts.init(el, null, { renderer: 'canvas' });
        chart.setOption({ /* see §Data Visualization for theme options */ });
    }
}
```

#### Text Helpers

```css
h1             { font-family: 'DM Serif Display', serif; font-size: 64px; font-weight: 400; line-height: 1.15; letter-spacing: -0.02em; }
h2             { font-family: 'DM Serif Display', serif; font-size: 42px; font-weight: 400; line-height: 1.2; letter-spacing: -0.01em; }
.label         { font-size: 13px; letter-spacing: 0.1em; text-transform: uppercase; color: var(--text-muted); font-weight: 400; }
.subtitle      { font-size: 22px; color: var(--text-secondary); font-weight: 300; line-height: 1.6; }
.body-text     { font-size: 18px; color: var(--text-secondary); line-height: 1.75; }
```

Use `<em>` (italic) on the single most important phrase in a heading — never bold,
never color, never gradient. Max one emphasized phrase per slide.

#### Dividers and Rules

```css
.divider       { border: none; border-top: 1px solid var(--border); margin: 24px 0; }
.divider-wide  { border: none; border-top: 1px solid var(--border); width: 300px; }
.heading-rule  { border: none; border-bottom: 1px solid var(--border); padding-bottom: 16px; margin-bottom: 24px; }
```

- `.divider` (full-width, `1px`): structural — separate heading from content
- `.divider-wide` (`300px`): decorative anchor — bottom of sparse slides
- `.heading-rule` (border-bottom on heading): separate title from body on content slides
- Never use gradient lines, colored borders, or thick rules

#### Icons (Lucide)

Load via CDN: `<script src="https://cdn.jsdelivr.net/npm/lucide@latest/dist/umd/lucide.js"></script>`
Use `<i data-lucide="icon-name" class="card-icon"></i>` and call `lucide.createIcons()` in JS.

- Icons are **optional** in this theme — typography and whitespace provide the hierarchy
- Icon color: `var(--accent-2)` (warm grey), size: `1.75rem`, hover: `scale(1.05)`
- When used, pick simple stroke-style icons: `circle-dashed` → restraint, `eye` → clarity,
  `text` → typography, `book-open` → research, `target` → precision
- Cards may include icons, but omitting them often feels more "minimal"
- Stats, quotes, step flow: never add icons

#### Decorative Fills (.deco-circle, .deco-rule)

Positioned-absolute background elements behind content.

```css
.deco-circle { position: absolute; border-radius: 50%; pointer-events: none; z-index: 0; }
.deco-rule   { position: absolute; pointer-events: none; z-index: 0; }

/* Ensure content stacks above decorative fills */
.slide-canvas > *:not(.deco-circle):not(.deco-rule):not(.quote-deco) { position: relative; z-index: 1; }
```

Set size, color, opacity, and position via inline styles:
- Typical `.deco-circle`: `width:200–400px; height:same; background:rgba(255,179,71,0.04–0.06); filter:blur(30–40px)`
- Typical `.deco-rule`: `width:120–200px; height:1px; background:linear-gradient(90deg, transparent, var(--border-strong), transparent); opacity:0.3–0.5`
- Sparse slides (cover, quote, closing): 2–3 deco elements
- Dense slides (grids, multi-column): 0 deco elements — content is the fill
- Never exceed 3 per slide

### Layout Primitives

Components can be placed in any of these layout arrangements.
Mix layouts and components freely — these are tools, not templates.

#### Centered Stack

`.slide-canvas` default behavior — `flex-direction: column; justify-content: center`.
Use for: cover, closing, quote-focused, single-statement slides.

#### Top-Aligned Stack

Override `.slide-canvas` with `style="justify-content: flex-start; padding-top: 80px"`.
Use for: content-heavy slides where vertical space matters.

#### Two-Column Grid (.two-col)

```html
<div class="two-col">
    <div class="two-col-main"><!-- primary content --></div>
    <div class="two-col-aside"><!-- secondary content --></div>
</div>
```

```css
.two-col       { display: grid; grid-template-columns: 1fr 1fr; gap: 64px; align-items: stretch; max-width: 1600px; margin: 0 auto; flex: 1; }
.two-col-main  { display: flex; flex-direction: column; justify-content: center; }
.two-col-main h2 { font-size: 36px; margin-bottom: 16px; }
.two-col-main p  { font-size: 18px; color: var(--text-secondary); line-height: 1.75; }
.two-col-aside { display: flex; flex-direction: column; }
.two-col-aside .card { flex: 1; }
```

Either side can contain any components — cards, charts, text, evidence lists, stat cards.

#### Three-Column Grid

```css
.card-grid  { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; max-width: 1600px; margin: 0 auto; flex: 1; align-content: stretch; }
.stats-row  { display: grid; grid-template-columns: repeat(3, 1fr); gap: 32px; max-width: 1600px; margin: 0 auto; }
```

Use `.card-grid` for cards, `.stats-row` for stat cards, or create a custom grid.
For 2 items: `repeat(2, 1fr)`. For 4: `repeat(2, 1fr)` (2×2 grid).
The grid container can hold any mix of components.

#### Horizontal Flow

Used by `.step-flow` — `display: flex; align-items: flex-start; max-width: 1600px`.
Also works for timelines, comparison strips, or any horizontal sequence.

### Data Visualization (ECharts)

When a slide includes charts or data visualization, use [ECharts](https://echarts.apache.org/)
loaded via CDN:

```html
<script src="https://cdn.jsdelivr.net/npm/echarts@5/dist/echarts.min.js"></script>
```

#### Chart Type Selection

Choose the chart type based on the data, not by habit. Different data patterns
demand different visualizations:

| Data Pattern | Chart Type | Common Placements |
|---|---|---|
| Proportions / composition (parts of a whole) | Pie / Donut | Any layout — pair with narrative or standalone |
| Trends over time (growth, decline, cycles) | Line or Area | Full-width for detail, two-col for trend + commentary |
| Category comparisons (A vs B vs C) | Vertical Bar | Full-width or two-col |
| Rankings / sorted magnitudes | Horizontal Bar | Full-width (labels need room) |
| Distribution / histogram | Vertical Bar (binned) | Full-width |
| KPIs with sparkline context | Stats Row + small Line chart below | Custom composite |

Layout is not fixed — pick the layout that serves the narrative. A chart can
occupy one column of Two-Column, span full-width on its own slide, or sit
inside a Feature Card as a small sparkline. Let the data and story decide.

#### Shared monochrome chart styles

All chart types share these minimal theme defaults:

- **Color palette**: `['#1A1916', '#6B6560', '#C9C4B8']` (monochrome warm — ink, mid-grey, border).
  For >3 series, extend with `#A09890` (muted) and `#D5D0C8` (light warm).
- **Background**: `'transparent'`
- **Axis labels / legend text**: `var(--text-muted)` (`#A09890`), `14px` DM Sans font
- **Grid lines**: `var(--border)` (`#C9C4B8`) at 30% opacity — barely visible
- **Animation**: `false` or very subtle fade-in only (consistent with minimal's stillness)
- **Tooltip**: light background (`var(--bg-card)`), `var(--text-primary)` text, thin `var(--border)` border

#### Pie / Donut

- Inner radius `55-65%` for donut; `0` for full pie
- `borderRadius: 6`, `borderColor: var(--bg-primary)`, `borderWidth: 3` for segment gaps
- Center label: large text in `var(--text-primary)`, DM Serif Display font
- Legend: bottom-aligned, `itemWidth: 12`, `itemGap: 20`
- Container: `280–360px` square is typical

#### Bar (vertical & horizontal)

- No rounded caps — flat bar ends for a cleaner, more structural look
- Bar width: `40-60%` of category gap — never touch adjacent bars
- Solid fills only — no gradient fills (gradients break the monochrome discipline)
- For ≤5 categories: one shade per bar from monochrome warm. For single-series: solid `var(--text-primary)`
- Axis line: `1px` `var(--border)`. Tick marks: hidden

#### Line / Area

- Line width: `1.5-2px`, smooth curves (`smooth: true`) — thinner than aurora to feel quieter
- No glow or shadow effects
- Area fill: solid color at 6-10% opacity — no gradients
- Data points: show on hover only (`symbol: 'none'`, `emphasis: { symbol: 'circle' }`)
- For multiple series: distinguish with solid vs dashed lines, all within monochrome warm palette

#### Integration rules

- Initialize charts inside a `window.addEventListener('load', ...)` or after DOM ready
- Use `echarts.init(container, null, { renderer: 'canvas' })` — canvas renderer for performance
- Charts must use the monochrome warm palette — never default ECharts colors or colored accents
- Responsive: charts are inside the 1920×1080 canvas, scaled by JS `transform: scale()` —
  no need for ECharts `resize()` handling

### Composition Guide

#### Common Recipes

These are starting points — not constraints. Combine any components with any
layout primitive as the content demands.

| Content Pattern | Suggested Recipe | Minimal Notes |
|---|---|---|
| 3–4 parallel features | 3-col grid + card ×3 | Number labels (`01`, `02`). Icon optional. |
| Key metrics (2–4 KPIs) | 3-col grid + stat-card ×3 | Static numbers, no counter animation. DM Serif Display. |
| Narrative + evidence | two-col + serif heading in main, frosted card with evidence-list in aside | Em-dash bullets |
| Sequential process (3–5 steps) | horizontal flow + step-flow | Filled dark circles, `1px` connectors. Quiet. |
| Memorable quote | centered stack + quote-block + quote-deco | DM Serif Display italic, `border-left: 2px`. |
| Single powerful statement | centered stack + large italic heading + deco fills | `<em>` on key phrase. No gradient-text. |
| Data visualization | any layout + chart-container | Chart type per data — see §Data Visualization. Monochrome warm. |
| KPIs with trend context | 3-col grid + stat-cards, then chart below | Static numbers + supporting chart |
| Team / people (3–4) | 3-col grid + card ×3 (no icons) | card-title → name (serif), card-body → role |
| Before vs After | two-col + content per side | Serif heading + em-dash evidence-list each column |
| 6+ items on one topic | Split across 2 slides | Max 4 items per slide (stricter than other themes) |

#### Element Usage Rules

**Emphasis (`<em>`):** Use italic on the single most important phrase in a heading —
never bold, never color, never gradient. Typical: core concept (`clear presentation`),
key insight (`nothing left to take away`). Max one per slide.

**Dividers:** `.divider` (full-width) for structural separation. `.divider-wide` (`300px`)
as decorative anchor at bottom of sparse slides. `.heading-rule` on content slide headings.
Never gradient lines, colored borders, or thick rules.

**Icons (Lucide):** Optional. Typography and whitespace provide the hierarchy.
When used: simple stroke-style in `var(--accent-2)`. Cards may include icons,
but omitting often feels more "minimal." Stats, quotes, step flow: never add icons.

**Card labels:** Sequential numbers (`01`, `02`, `03`) preferred — orderly and typographic.
Short category words acceptable when items are unordered. Omit when the title is clear.

**Decorative fills:** Sparse slides: 2–3 deco elements (warm-amber circles, thin rules).
Dense slides: 0 — content is the fill. Never exceed 3 per slide.

#### Common Mistakes

- Using colored accents, gradients, or glows → stay monochrome warm.
- Adding icons to every card when the heading is already clear → less is more.
- Using counter animations on numbers → minimal uses static numbers with fade-in.
- Using more than 4 items per slide → split across slides.
- Adding decorative fills to dense content slides → content is the fill.
- Always using donut charts for data → match chart type to data pattern (see §Data Visualization).
- Leaving more than ~20% of canvas visually empty → expand content or add thin rules.

### Code Blocks (if any)

```css
pre, code {
    background: #F0EEE8;
    border: 1px solid var(--border);
    border-radius: 6px;
    font-family: 'DM Mono', 'Söhne Mono', ui-monospace, monospace;
    font-size: 14px;
    color: var(--text-primary);
}
```

### Do & Don't

- **Do** use light backgrounds throughout — never dark
- **Do** let the subtle geometric shapes add depth without overwhelming
- **Do** use serif headings (`DM Serif Display`) contrasted with sans-serif body (`DM Sans`)
- **Do** keep the accent monochrome — no colored accents
- **Do** use frosted-glass cards with `backdrop-filter: blur(16px)` and `rgba(255,255,255,0.55)` background
- **Do** use minimal animations — this theme values stillness
- **Don't** use gradients, glows, or colored borders
- **Don't** add too many geometric shapes — 2-3 is enough
- **Don't** use more than 4 bullet points per slide

### Reduced Motion

```css
@media (prefers-reduced-motion: reduce) {
    .reveal {
        transition: opacity 0.3s ease;
        opacity: 1;
    }
}
```
