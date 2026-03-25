# Companion Mobile App

This Laravel backend serves a React Native (Expo) mobile app.

## Location

The companion app project is located at `../__APP_SLUG__/`.

## Cross-Project Workflows

- When asked to "check the app", "look at the app code", or "see how the app does X", navigate to `../__APP_SLUG__/`.
- When asked to "create a GitHub issue in the app" or "create an issue for the app", run `gh issue create` from within the `../__APP_SLUG__/` directory.
- When asked about "the frontend" or "the mobile app", this refers to the Expo project at `../__APP_SLUG__/`.

## API Contract

The file `docs/api-specs.md` in this repository is the **single source of truth** for the API contract between this backend and the mobile app.

When adding or modifying API endpoints:
1. Implement the endpoint in Laravel
2. Update `docs/api-specs.md` with the endpoint documentation
3. The mobile app will reference this file to implement corresponding API calls

When asked about "api specs" or "the API contract", this refers to `docs/api-specs.md`.

## App Tech Stack

- React Native with Expo SDK
- TypeScript with strict mode
- Expo Router (file-based routing)
- TailwindCSS v4 via Uniwind
- React Query for server state / data fetching
- Zustand for global state
- MMKV for encrypted local storage
- Sanctum API tokens for authentication (Bearer token in Authorization header)
