## Visual Style — Minimal Theme

Apply this visual style when generating all slides in this session.

This theme is inspired by the slides-it application UI itself: warm off-white paper tones,
restrained typography, and zero decorative chrome. Think printed essays, not tech demos.

### Color Palette

```css
:root {
    --bg-primary:    #FAF9F6;   /* warm off-white — main background */
    --bg-secondary:  #F0EEE8;   /* slightly darker warm grey */
    --bg-card:       #FFFFFF;   /* pure white cards */
    --text-primary:  #1A1916;   /* near-black warm ink */
    --text-secondary:#6B6560;   /* warm mid-grey */
    --text-muted:    #A09890;   /* subtle captions */
    --accent:        #1A1916;   /* same as text — monochrome accent */
    --accent-2:      #6B6560;   /* secondary accent — warm grey */
    --border:        #E2DED5;   /* soft warm border */
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
- Title size: `clamp(2rem, 5vw, 4rem)`
- Subtitle size: `clamp(1rem, 1.8vw, 1.35rem)`
- Body size: `clamp(0.85rem, 1.2vw, 1rem)`
- Line height: `1.75` for body, `1.2` for headings
- Letter spacing: `0.01em` for body; `-0.02em` for large headings

### Slide Layout

- Full-viewport slides (`height: 100vh`, `scroll-snap-align: start`)
- Comfortable padding: `clamp(2.5rem, 6vw, 6rem)`
- Content constrained to `max-width: 880px; margin: 0 auto`
- Title slide: large serif heading left-aligned + thin `1px` rule beneath + muted subtitle
- Content slides: heading top with `border-bottom: 1px solid var(--border)` separator, content below

### Cards & Containers

```css
.card {
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 8px;
    padding: clamp(1rem, 2vw, 1.75rem);
    box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}
```

No heavy shadows. Cards feel like sheets of paper resting on the page.

### Accent Elements

- Left border on callouts: `border-left: 2px solid var(--border-strong)` (no color, no glow)
- Key numbers / stats: larger font size (`clamp(2.5rem, 5vw, 4rem)`) in `var(--text-primary)`, bold
- Section labels: `0.7rem`, `letter-spacing: 0.1em`, `text-transform: uppercase`, `var(--text-muted)`
- Dividers: `1px solid var(--border)` — thin and quiet

### Animations

- Entrance: `opacity: 0 → 1` only (no translateY) — duration `0.4s`, easing `ease`
- Stagger delay: `0.06s` per child element
- Triggered by `.visible` class added via `IntersectionObserver`
- Progress bar: `2px` line at top, `var(--border-strong)` color (not accent-colored)
- Keep all motion extremely subtle — this theme is about stillness

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
- **Do** let whitespace breathe — fewer elements per slide is always better
- **Do** use serif headings (`DM Serif Display`) contrasted with sans-serif body (`DM Sans`)
- **Do** keep the accent monochrome — no indigo, cyan, or neon colors
- **Don't** use gradients, glows, or colored borders
- **Don't** add decorative geometric shapes or patterns
- **Don't** use more than 4 bullet points per slide
