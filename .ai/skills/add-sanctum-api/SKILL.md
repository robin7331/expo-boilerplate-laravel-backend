---
name: add-sanctum-api
description: >
  Add Sanctum API token authentication for the companion mobile app.
  Creates AuthController with login/register/logout/user endpoints,
  API routes under /api/v1/auth/, access gate for test user, and
  runs migrate:fresh --seed. Use when adding mobile auth to this backend.
---

# Add Sanctum API Auth

Adds Sanctum API token authentication endpoints for the companion mobile app.

## What It Does

1. Installs Sanctum API scaffolding (`php artisan install:api`)
2. Creates `AuthController` with login, register, logout, and user endpoints
3. Adds versioned API routes under `/api/v1/auth/`
4. Adds access gate so only `test@example.com` can view Pulse/Telescope (if installed)
5. Runs `php artisan migrate:fresh --seed` to set up the database with the test user

## How to Run

Run the script from the project root:

```bash
bash scripts/add-sanctum-api.sh
```

Then the agent should generate `docs/api-specs.md` by introspecting the actual routes:

1. Run `php artisan route:list --json` to get all registered routes
2. Read the AuthController code
3. Generate `docs/api-specs.md` documenting every `/api/*` route with:
   - HTTP method and URL
   - Authentication requirements
   - Request body / query parameters (with types and validation rules from the controller)
   - Response format (with example JSON)
   - Error responses

Use this header for the file:

```markdown
# API Specification

> Auto-generated from the Laravel backend. This file is the single source of truth
> for the API contract between the backend and the mobile app.

Base URL: `http://{APP_URL}` (development — see .env)

## Authentication

Endpoints marked with `Auth: required` need a Sanctum Bearer token:

    Authorization: Bearer {token}

Obtain a token via `POST /api/v1/auth/login` or `POST /api/v1/auth/register`.
```
