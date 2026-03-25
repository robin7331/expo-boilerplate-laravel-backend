---
name: add-pulse-telescope
description: >
  Install Laravel Pulse (monitoring) and/or Telescope (debugging).
  Publishes service providers, adds access gates, wires sidebar navigation links,
  and runs migrations. Use when adding monitoring/debugging tools to this backend.
---

# Add Pulse & Telescope

Installs Laravel Pulse and/or Telescope with access gates and sidebar navigation.

## How to Run

Run the script from the project root with flags for what to install:

```bash
# Both (default)
bash scripts/add-pulse-telescope.sh --pulse --telescope

# Pulse only
bash scripts/add-pulse-telescope.sh --pulse

# Telescope only
bash scripts/add-pulse-telescope.sh --telescope
```

## What It Does

1. Installs the selected packages via Composer
2. Publishes service providers
3. Runs migrations
4. Adds access gates so only `test@example.com` can view Pulse/Telescope
5. Adds sidebar navigation links (Activity icon for Pulse, Telescope icon for Telescope)
