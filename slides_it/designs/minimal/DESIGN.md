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
- Title size: `clamp(2.2rem, 5vw, 4rem)`
- Subtitle size: `clamp(1rem, 1.8vw, 1.35rem)`
- Body size: `clamp(0.85rem, 1.2vw, 1rem)`
- Line height: `1.75` for body, `1.15` for h1, `1.2` for h2
- Letter spacing: `-0.02em` for large headings

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

- Full-viewport slides (`height: 100dvh`, `scroll-snap-align: start`)
- 16:9 aspect ratio enforced via `.slide-inner`:
  - Default: `max-width: min(1060px, calc(100dvh * 16 / 9))` — for Cover, Quote, Closing
  - Wide: `max-width: min(1200px, calc(100dvh * 16 / 9))` — for Feature Cards, Stats Row, Two-Column, Step Flow (add `.wide` class)
- Comfortable padding: `clamp(1.5rem, 3vw, 3rem)`
- Title slide: large serif heading left-aligned + thin `1px` rule beneath + muted subtitle
- Content slides: heading top with `border-bottom: 1px solid var(--border)` separator, content below

### Cards & Containers

```css
.card {
    background: var(--bg-card);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: clamp(1rem, 2vw, 1.5rem);
    box-shadow: 0 2px 12px rgba(0,0,0,0.06);
    transition: transform 0.25s ease, box-shadow 0.25s ease;
}

.card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(0,0,0,0.10);
}
```

Cards have a frosted-glass feel — semi-transparent white with backdrop blur, resting gently on the warm background layers beneath.

### Accent Elements

- Left border on callouts: `border-left: 2px solid var(--border-strong)` (no color, no glow)
- Key numbers / stats: larger font size (`clamp(2.5rem, 5vw, 4rem)`) in `var(--text-primary)`, `font-weight: 400` (DM Serif Display optical weight — no bold)
- Section labels: `0.7rem`, `letter-spacing: 0.1em`, `text-transform: uppercase`, `var(--text-muted)`
- Dividers: `1px solid var(--border)` — thin and quiet

### Animations

- **Entrance (subtle)**: `opacity: 0 → 1` only (no translateY) — duration `0.4s`, easing `ease`
- **Stagger delay**: `0.06s` per child element
- **Card hover**: subtle `translateY(-2px)` + shadow increase (0.25s)
- **Progress bar**: `2px` line at top, `var(--border-strong)` color (not accent-colored)
- Trigger via `.visible` class added via `IntersectionObserver`
- Keep all motion extremely subtle — this theme is about stillness and warmth
- Numeric data: numbers appear statically with fade-in — no counter animation

These animation rules override any defaults in the core skill. This theme intentionally
avoids directional motion (translateY/translateX) for entrance — opacity-only transitions
preserve the calm, paper-like feel.

### Icons & Graphic Elements

- Load Lucide icons via CDN: `<script src="https://cdn.jsdelivr.net/npm/lucide@latest/dist/umd/lucide.js"></script>`
- Icon color: `var(--accent-2)` (warm grey), size: `1.75rem`, hover: `scale(1.05)`
- Icons are optional — this theme can rely purely on typography and whitespace for visual hierarchy
- Decorative elements: thin `1px` rules, subtle left borders in `var(--border-strong)` — never heavy stripes or geometric shapes
- No glow effects, no colored borders, no SVG background shapes

### Slide Layout Variants

Use these layout patterns based on content type. All use frosted-glass cards
(`backdrop-filter: blur(16px)`, semi-transparent `rgba(255,255,255,0.55)`) with
thin warm borders and minimal shadow.

**Stats Row** — 3-column grid of frosted-glass stat cards, large numbers in `var(--text-primary)`
(`font-weight: 400`, not colored), thin bottom border. Numbers appear statically with fade-in.

**Two-Column** — left: DM Serif Display heading + body text, right: frosted-glass card with
thin border. Clean typographic contrast does the visual work.

**Step Flow** — horizontal steps with numbered circles in `var(--text-primary)`
(filled dark, white number), `1px` connector lines in `var(--border)`.

**Feature Cards** — 2–3 column grid of frosted-glass cards, no accent top border (use only thin
`var(--border)`). Optional Lucide icon in `var(--accent-2)`.

**Quote Block** — large DM Serif Display italic text, `border-left: 2px solid
var(--border-strong)`, no color accent. Let the serif typography be the visual element.

### Code Blocks (if any)

```css
pre, code {
    background: #F0EEE8;
    border: 1px solid var(--border);
    border-radius: 6px;
    font-family: 'DM Mono', 'Söhne Mono', ui-monospace, monospace;
    font-size: clamp(0.7rem, 1vw, 0.875rem);
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
