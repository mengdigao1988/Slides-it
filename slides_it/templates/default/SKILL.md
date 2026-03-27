## Visual Style — Default Theme

Apply this visual style when generating all slides in this session.

### Color Palette

```css
:root {
    --bg-primary:    #0a0f1c;
    --bg-secondary:  #111827;
    --bg-card:       #1a2235;
    --text-primary:  #f9fafb;
    --text-secondary:#9ca3af;
    --accent:        #6366f1;        /* indigo */
    --accent-glow:   rgba(99, 102, 241, 0.25);
    --accent-2:      #06b6d4;        /* cyan highlight */
    --border:        rgba(99, 102, 241, 0.2);
}
```

### Typography

- **Display font**: `Clash Display` (headings) — load from Fontshare
- **Body font**: `Satoshi` (body, captions) — load from Fontshare
- Font link tag:
  ```html
  <link rel="stylesheet" href="https://api.fontshare.com/v2/css?f[]=clash-display@600,700&f[]=satoshi@400,500&display=swap">
  ```
- Title size: `clamp(2.2rem, 5.5vw, 4.5rem)`
- Subtitle size: `clamp(1rem, 2vw, 1.4rem)`
- Body size: `clamp(0.8rem, 1.2vw, 1rem)`

### Slide Layout

- Full-viewport slides (`height: 100vh`, `scroll-snap-align: start`)
- Generous padding: `clamp(2rem, 5vw, 5rem)`
- Content centered with `max-width: 960px; margin: 0 auto`
- Title slide: large centered heading + subtle animated accent line beneath it
- Content slides: heading top-left, content below with card-style groupings

### Cards & Containers

```css
.card {
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: clamp(1rem, 2vw, 1.75rem);
    box-shadow: 0 4px 24px rgba(0,0,0,0.3);
}
```

### Accent Elements

- Left border accent on callouts: `border-left: 3px solid var(--accent)`
- Gradient text for key phrases:
  ```css
  background: linear-gradient(135deg, var(--accent), var(--accent-2));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  ```
- Section dividers: thin `1px` horizontal rule with `var(--border)` color

### Animations

- Entrance: `opacity: 0 → 1` + `translateY(24px → 0)`, duration `0.55s`, easing `cubic-bezier(0.16, 1, 0.3, 1)`
- Stagger delay: `0.08s` per child element
- Triggered by `.visible` class added via `IntersectionObserver`
- Progress bar: thin `3px` line at top, color `var(--accent)`, updates on scroll

### Code Blocks (if any)

```css
pre, code {
    background: #0d1117;
    border: 1px solid var(--border);
    border-radius: 8px;
    font-family: 'JetBrains Mono', 'Fira Code', monospace;
    font-size: clamp(0.7rem, 1vw, 0.875rem);
}
```

### Do & Don't

- **Do** use dark backgrounds with light text throughout
- **Do** use `var(--accent)` sparingly — for 1-2 key highlights per slide only
- **Do** keep slides uncluttered — max 5 bullet points per slide
- **Don't** use white or light backgrounds
- **Don't** mix more than 2 accent colors on one slide
