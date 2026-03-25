# Contributing Back to the Boilerplate

This project was cloned from `robin7331/expo-boilerplate-laravel-backend`. When the user explicitly asks to **"add this to the boilerplate"** or **"add this to the boilerplates"**, they want the feature contributed back as a reusable skill so future projects get it too.

This does NOT apply when the user just wants to create a skill for this project only. Only act on this when the user specifically mentions "the boilerplate" or "the boilerplates".

## Boilerplate Repos

| Repo | Purpose | Skills location |
|------|---------|----------------|
| `robin7331/expo-boilerplate-laravel-backend` | Laravel backend boilerplate | `.ai/skills/{name}/SKILL.md` |
| `robin7331/expo-boilerplate` | Expo mobile app boilerplate | `.claude/skills/{name}/SKILL.md` |
| `robin7331/create-expo-app` | Orchestrator skill that scaffolds both | `create-expo-app/SKILL.md` |

## Steps

1. **Implement the feature in the current project first.** Get it working and tested.

2. **Separate deterministic from intelligent work:**
   - **Deterministic** (shell scripts): package installs, file copies, config changes, artisan commands → `scripts/{skill-name}.sh`
   - **Intelligent** (agent instructions): generating content, reading existing code → stays in `SKILL.md`
   - **Static files**: template files in `templates/{skill-name}/` mirroring the project directory structure

3. **Add the skill to the correct boilerplate repo:**
   - Clone the repo locally (e.g. into `/tmp/`)
   - Create the skill, script, and templates
   - Commit and push (or create a PR)
   - If the feature spans both app and backend, add to both repos

4. **Update the orchestrator (`robin7331/create-expo-app`) if the new skill should be offered as an option during project creation.** Add a question to Step 1 and an auto-invoke step to Step 3 (Expo) or Step 4 (Laravel) in `create-expo-app/SKILL.md`.
