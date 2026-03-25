# Design System Enforcement

[DESIGN.md](../../DESIGN.md) is the **single source of truth** for all visual design decisions in this project.

## When Building UI or Creating Views

- Read `DESIGN.md` first to understand the color palette, typography, spacing, component variants, and brand voice.
- Use the defined tokens — don't hardcode colors or introduce new ones without updating DESIGN.md.
- Use existing shadcn/ui components from `resources/js/components/ui/` before creating custom ones.
- Follow CVA variant patterns when adding new component variants.
- Use `cn()` from `@/lib/utils` for conditional class merging.
- Use Lucide React icons at `size-4` default.

## When Changing the Design (Colors, Typography, Spacing)

1. Update `DESIGN.md` first with the new values.
2. Then update `resources/css/app.css` to match — the `:root` and `.dark` blocks must stay in sync with DESIGN.md.
3. Never update `app.css` without also updating `DESIGN.md`, and vice versa.

## Component Conventions

- All reusable UI components live in `resources/js/components/ui/`.
- App-specific components live in `resources/js/components/`.
- Pages live in `resources/js/pages/`.
- Layouts live in `resources/js/layouts/`.
- Check sibling components for naming, structure, and styling patterns before creating new ones.

## Styling Rules

- Use Tailwind utility classes via `className`, never inline styles.
- Use semantic color tokens (`bg-primary`, `text-muted-foreground`, `border-border`) — never raw OKLCH values in components.
- Use the defined radius tokens (`rounded-md`, `rounded-lg`) — never arbitrary radius values.
- Focus states must use the `ring` token with 3px ring width.
- Dark mode is handled by the `.dark` class on the root element — use `dark:` variants for any custom dark mode styling.
