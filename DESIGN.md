# Design System

> Neutral defaults using shadcn/ui + Tailwind CSS v4. Customize these tokens to match your brand.

## Color Palette

All colors use OKLCH for perceptual uniformity. These values are wired directly into `resources/css/app.css`.

### Core Colors (Light)

| Token | OKLCH | Usage |
|-------|-------|-------|
| `primary` | `oklch(0.205 0 0)` | Main brand, buttons, active states |
| `primary-foreground` | `oklch(0.985 0 0)` | Text/icons on primary backgrounds |
| `secondary` | `oklch(0.97 0 0)` | Secondary actions, subtle fills |
| `secondary-foreground` | `oklch(0.205 0 0)` | Text on secondary backgrounds |
| `accent` | `oklch(0.97 0 0)` | Highlights, hover states |
| `accent-foreground` | `oklch(0.205 0 0)` | Text on accent backgrounds |
| `destructive` | `oklch(0.577 0.245 27.325)` | Errors, delete actions |

### Surface Colors (Light)

| Token | OKLCH | Usage |
|-------|-------|-------|
| `background` | `oklch(1 0 0)` | Page background (white) |
| `foreground` | `oklch(0.145 0 0)` | Primary text |
| `card` | `oklch(1 0 0)` | Card backgrounds |
| `card-foreground` | `oklch(0.145 0 0)` | Text inside cards |
| `muted` | `oklch(0.97 0 0)` | Disabled backgrounds, subtle fills |
| `muted-foreground` | `oklch(0.556 0 0)` | Placeholder text, secondary labels |

### Borders & Inputs (Light)

| Token | OKLCH | Usage |
|-------|-------|-------|
| `border` | `oklch(0.922 0 0)` | Default borders |
| `input` | `oklch(0.922 0 0)` | Input borders |
| `ring` | `oklch(0.87 0 0)` | Focus rings |

### Sidebar (Light)

| Token | OKLCH | Usage |
|-------|-------|-------|
| `sidebar` | `oklch(0.985 0 0)` | Sidebar background |
| `sidebar-foreground` | `oklch(0.145 0 0)` | Sidebar text |
| `sidebar-primary` | `oklch(0.205 0 0)` | Active sidebar item |
| `sidebar-accent` | `oklch(0.97 0 0)` | Sidebar hover |
| `sidebar-border` | `oklch(0.922 0 0)` | Sidebar dividers |

### Chart Colors

| Token | OKLCH | Usage |
|-------|-------|-------|
| `chart-1` | `oklch(0.646 0.222 41.116)` | Orange |
| `chart-2` | `oklch(0.6 0.118 184.704)` | Teal |
| `chart-3` | `oklch(0.398 0.07 227.392)` | Dark blue |
| `chart-4` | `oklch(0.828 0.189 84.429)` | Yellow |
| `chart-5` | `oklch(0.769 0.188 70.08)` | Amber |

### Dark Mode Overrides

Dark mode activates via the `.dark` class on the root element. All tokens are inverted:
- Backgrounds become dark (`oklch(0.145 0 0)`)
- Foregrounds become light (`oklch(0.985 0 0)`)
- Borders and inputs shift to `oklch(0.269 0 0)`
- Sidebar darkens to `oklch(0.205 0 0)`

Full dark mode values are defined in `.dark { ... }` in `resources/css/app.css`.

## Typography

| Element | Font | Size | Weight |
|---------|------|------|--------|
| Body | Instrument Sans | 16px | Regular (400) |
| Labels | Instrument Sans | 14px | Medium (500) |
| Headings | Instrument Sans | 20-32px | Semibold (600) |

**Font source:** Bunny Fonts (privacy-focused CDN), loaded in `resources/views/app.blade.php`.

**Font stack fallback:** `ui-sans-serif, system-ui, sans-serif`

## Spacing & Radius

| Token | Value | Usage |
|-------|-------|-------|
| `radius` | `0.625rem` (10px) | Default border radius |
| `radius-lg` | `0.625rem` (10px) | Large elements (cards, dialogs) |
| `radius-md` | `0.375rem` (6px) | Medium elements (inputs, buttons) |
| `radius-sm` | `0.25rem` (4px) | Small elements (badges, chips) |

**Spacing scale:** Tailwind's default 4px grid (`p-1` = 4px, `p-2` = 8px, `p-4` = 16px, etc.)

## Component Library

**shadcn/ui** (New York style) — located in `resources/js/components/ui/`.

Components use:
- **CVA** (class-variance-authority) for variant-based styling
- **Radix UI** primitives for accessible headless behavior
- **Lucide React** for icons (`size-4` default)
- **cn()** from `@/lib/utils` for conditional class merging (clsx + tailwind-merge)

### Available Components

Button, Card, Input, Label, Badge, Alert, Dialog, Select, Checkbox, Toggle, Separator, Skeleton, Spinner, Sidebar, Sheet, Breadcrumb, Avatar, Dropdown Menu, Navigation Menu, Tooltip, Collapsible

### Component Variants

Buttons: `default`, `destructive`, `outline`, `secondary`, `ghost`, `link`
Badges: `default`, `secondary`, `destructive`, `outline`
Alerts: `default`, `destructive`

### Component Sizing

| Size | Height | Usage |
|------|--------|-------|
| `sm` | `h-8` | Compact contexts |
| `default` | `h-9` | Standard |
| `lg` | `h-10` | Prominent actions |
| `icon` | `h-9 w-9` | Icon-only buttons |

## Layouts

| Layout | Usage |
|--------|-------|
| `app-sidebar-layout` | Main app shell — sidebar + content area |
| `app-header-layout` | Alternative with top header |
| `auth-simple-layout` | Centered card for login/register |
| `auth-card-layout` | Card variant for auth |
| `auth-split-layout` | Two-column auth (form + visual) |
| `settings/layout` | Two-column settings with nav sidebar |

## Brand Voice

> Neutral and professional — update this section to reflect your product's personality.

**Guidelines:**
- Lead with clarity over cleverness
- Use active, direct language
- Keep microcopy concise

**Examples:**
| Context | Instead of | Write |
|---------|-----------|-------|
| Empty state | "No items found" | "Nothing here yet" |
| CTA button | "Submit" | "Continue" |
| Error | "Error occurred" | "Something went wrong — try again" |

## Token → CSS Mapping

These tokens are defined in `resources/css/app.css`:

```css
/* Light mode — :root */
--background: oklch(1 0 0);
--foreground: oklch(0.145 0 0);
--primary: oklch(0.205 0 0);
--primary-foreground: oklch(0.985 0 0);
--secondary: oklch(0.97 0 0);
--accent: oklch(0.97 0 0);
--muted: oklch(0.97 0 0);
--muted-foreground: oklch(0.556 0 0);
--destructive: oklch(0.577 0.245 27.325);
--border: oklch(0.922 0 0);
--ring: oklch(0.87 0 0);
--radius: 0.625rem;

/* Dark mode — .dark */
--background: oklch(0.145 0 0);
--foreground: oklch(0.985 0 0);
--primary: oklch(0.985 0 0);
--primary-foreground: oklch(0.205 0 0);
--secondary: oklch(0.269 0 0);
--border: oklch(0.269 0 0);
```
