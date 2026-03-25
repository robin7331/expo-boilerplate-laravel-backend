#!/bin/bash
#
# add-sanctum-api.sh — Add Sanctum API token auth for the companion mobile app
#
# Run from the project root:
#   bash scripts/add-sanctum-api.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

# ── Install Sanctum API scaffolding ──────────────────────────────────────────

echo "Installing Sanctum API scaffolding..."
php artisan install:api --no-interaction

# ── Copy AuthController ──────────────────────────────────────────────────────

echo "Adding AuthController..."
mkdir -p app/Http/Controllers/Api/V1
cp templates/sanctum-api/app/Http/Controllers/Api/V1/AuthController.php \
   app/Http/Controllers/Api/V1/AuthController.php

# ── Copy API routes ──────────────────────────────────────────────────────────

echo "Adding API routes..."
cp templates/sanctum-api/routes/api.php routes/api.php

# ── Add HasApiTokens trait to User model ─────────────────────────────────────

USER_MODEL="app/Models/User.php"
if ! grep -q "HasApiTokens" "$USER_MODEL"; then
  echo "Adding HasApiTokens trait to User model..."
  perl -i -pe 's/^(use Illuminate\\Foundation\\Auth\\User as Authenticatable;)/$1\nuse Laravel\\Sanctum\\HasApiTokens;/' "$USER_MODEL"
  perl -i -pe 's/(use HasFactory, Notifiable)/use HasApiTokens, HasFactory, Notifiable/' "$USER_MODEL"
fi

# ── Add access gate for Pulse/Telescope ──────────────────────────────────────

# Only add the gate if it doesn't already exist
if ! grep -q "viewPulse" app/Providers/AppServiceProvider.php; then
  echo "Adding Pulse access gate..."
  # Insert gate import and definition into AppServiceProvider boot method
  php artisan tinker --execute="
    \$file = base_path('app/Providers/AppServiceProvider.php');
    \$content = file_get_contents(\$file);

    // Add Gate import if missing
    if (strpos(\$content, 'use Illuminate\Support\Facades\Gate;') === false) {
        \$content = str_replace(
            'use Illuminate\Support\ServiceProvider;',
            \"use Illuminate\Support\Facades\Gate;\nuse Illuminate\Support\ServiceProvider;\",
            \$content
        );
    }

    // Add gate definition to configureDefaults method
    \$gate = \"\\n        // TODO: Replace test@example.com with your email before going to production\\n        Gate::define('viewPulse', function (\\\$user) {\\n            return \\\$user->email === 'test@example.com';\\n        });\\n\";

    \$content = str_replace(
        'DB::prohibitDestructiveCommands(',
        trim(\$gate) . \"\\n\\n        DB::prohibitDestructiveCommands(\",
        \$content
    );

    file_put_contents(\$file, \$content);
    echo 'Gate added.';
  " 2>/dev/null || echo "Warning: Could not auto-add gate. Add viewPulse gate manually to AppServiceProvider."
fi

# ── Migrate and seed ─────────────────────────────────────────────────────────

echo "Running migrate:fresh --seed..."
php artisan migrate:fresh --seed --no-interaction

# ── Format ───────────────────────────────────────────────────────────────────

echo "Running Pint..."
vendor/bin/pint --quiet 2>/dev/null || true

# ── Validate ─────────────────────────────────────────────────────────────────

echo "Validating Sanctum setup..."
VALID=true

if ! grep -q "HasApiTokens" "$USER_MODEL"; then
  echo "  ✗ HasApiTokens trait missing from User model"
  VALID=false
fi

if ! php artisan route:list --path=api/v1/auth/login --json 2>/dev/null | grep -q "login"; then
  echo "  ✗ Login route not registered"
  VALID=false
fi

if [ "$VALID" = false ]; then
  echo ""
  echo "ERROR: Sanctum validation failed. Check the errors above."
  exit 1
fi

echo "  ✓ All checks passed"

# ── Done ─────────────────────────────────────────────────────────────────────

echo ""
echo "Sanctum API auth installed!"
echo ""
echo "  Endpoints:"
echo "    POST /api/v1/auth/login"
echo "    POST /api/v1/auth/register"
echo "    POST /api/v1/auth/logout    (auth required)"
echo "    GET  /api/v1/auth/user      (auth required)"
echo ""
echo "  Test credentials:"
echo "    Email:    test@example.com"
echo "    Password: password"
echo ""
echo "  Next: The agent should generate docs/api-specs.md"
