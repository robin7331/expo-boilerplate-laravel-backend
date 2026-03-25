#!/bin/bash
#
# add-pulse-telescope.sh — Install Pulse and/or Telescope with sidebar navigation
#
# Usage:
#   bash scripts/add-pulse-telescope.sh --pulse --telescope
#   bash scripts/add-pulse-telescope.sh --pulse
#   bash scripts/add-pulse-telescope.sh --telescope

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

PULSE=false
TELESCOPE=false

for arg in "$@"; do
  case "$arg" in
    --pulse) PULSE=true ;;
    --telescope) TELESCOPE=true ;;
  esac
done

if ! $PULSE && ! $TELESCOPE; then
  echo "Usage: bash scripts/add-pulse-telescope.sh [--pulse] [--telescope]"
  echo "At least one of --pulse or --telescope is required."
  exit 1
fi

# ── Install Pulse ────────────────────────────────────────────────────────────

if $PULSE; then
  echo "Installing Laravel Pulse..."
  composer require laravel/pulse
  php artisan vendor:publish --provider="Laravel\Pulse\PulseServiceProvider" --no-interaction
fi

# ── Install Telescope ────────────────────────────────────────────────────────

if $TELESCOPE; then
  echo "Installing Laravel Telescope..."
  composer require laravel/telescope
  php artisan telescope:install --no-interaction
fi

# ── Migrate ──────────────────────────────────────────────────────────────────

echo "Running migrations..."
php artisan migrate --no-interaction

# ── Add access gates ─────────────────────────────────────────────────────────

if $PULSE && ! grep -q "viewPulse" app/Providers/AppServiceProvider.php; then
  echo "Adding Pulse access gate to AppServiceProvider..."
fi

if $TELESCOPE; then
  # Telescope has its own service provider with a gate method
  TELESCOPE_SP="app/Providers/TelescopeServiceProvider.php"
  if [ -f "$TELESCOPE_SP" ] && ! grep -q "test@example.com" "$TELESCOPE_SP"; then
    echo "Updating Telescope access gate..."
    sed -i '' 's/return in_array(\$user->email, \[/return in_array($user->email, [/' "$TELESCOPE_SP" 2>/dev/null || true
  fi
fi

# ── Wire sidebar navigation ─────────────────────────────────────────────────

SIDEBAR="resources/js/components/app-sidebar.tsx"

if [ -f "$SIDEBAR" ]; then
  # Add icon imports if missing
  if $PULSE && ! grep -q "Activity" "$SIDEBAR"; then
    echo "Adding Pulse to sidebar..."
    sed -i '' 's/import { BookOpen, FolderGit2, LayoutGrid }/import { Activity, BookOpen, FolderGit2, LayoutGrid }/' "$SIDEBAR" 2>/dev/null || true
    # Also handle case where icons are on separate lines
    if ! grep -q "Activity" "$SIDEBAR"; then
      sed -i '' '/^import.*lucide-react/s/{ /{ Activity, /' "$SIDEBAR" 2>/dev/null || true
    fi
  fi

  if $TELESCOPE && ! grep -q "'Telescope'" "$SIDEBAR"; then
    echo "Adding Telescope to sidebar..."
    # Import Telescope icon if not present
    if ! grep -q "Telescope" "$SIDEBAR"; then
      sed -i '' 's/import { Activity,/import { Activity, Telescope as TelescopeIcon,/' "$SIDEBAR" 2>/dev/null || true
      # Fallback if Activity wasn't added
      if ! grep -q "TelescopeIcon" "$SIDEBAR"; then
        sed -i '' '/^import.*lucide-react/s/{ /{ Telescope as TelescopeIcon, /' "$SIDEBAR" 2>/dev/null || true
      fi
    fi
  fi

  # Add nav items to footerNavItems array
  # Insert Pulse and Telescope items before the Repository link using perl
  # (macOS sed doesn't handle multi-line inserts reliably)
  if $PULSE && ! grep -q "'Pulse'" "$SIDEBAR"; then
    perl -i -0pe "s/(const footerNavItems: NavItem\[\] = \[\n)/\$1    {\n        title: 'Pulse',\n        href: '\/pulse',\n        icon: Activity,\n    },\n/" "$SIDEBAR"
  fi
  if $TELESCOPE && ! grep -q "'Telescope'" "$SIDEBAR"; then
    perl -i -0pe "s/(title: 'Pulse',\n    },\n)/\$1    {\n        title: 'Telescope',\n        href: '\/telescope',\n        icon: TelescopeIcon,\n    },\n/" "$SIDEBAR"
    # Fallback if Pulse wasn't added (Telescope-only)
    if ! grep -q "'Telescope'" "$SIDEBAR"; then
      perl -i -0pe "s/(const footerNavItems: NavItem\[\] = \[\n)/\$1    {\n        title: 'Telescope',\n        href: '\/telescope',\n        icon: TelescopeIcon,\n    },\n/" "$SIDEBAR"
    fi
  fi
fi

# ── Format ───────────────────────────────────────────────────────────────────

echo "Running Pint..."
vendor/bin/pint --quiet 2>/dev/null || true

echo "Running Prettier on sidebar..."
npx prettier --write "$SIDEBAR" 2>/dev/null || true

# ── Done ─────────────────────────────────────────────────────────────────────

echo ""
echo "Monitoring tools installed!"
$PULSE && echo "  - Pulse: /pulse"
$TELESCOPE && echo "  - Telescope: /telescope"
echo ""
echo "  Access restricted to: test@example.com"
echo "  NOTE: Update the email before going to production."
