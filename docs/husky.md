# Husky Pre-commit Hooks

This project uses [Husky](https://typicode.github.io/husky/) to run pre-commit hooks that ensure code quality.

## Pre-commit Hook

The pre-commit hook runs [lint-staged](https://github.com/lint-staged/lint-staged) to automatically fix and lint code before commits.

### What it does

- **JavaScript/TypeScript files** (`*.{js,jsx,ts,tsx}`):
  - Runs ESLint with `--fix` to auto-fix issues
  - Runs Prettier to format code

- **YAML files** (`*.yml`):
  - Runs `yaml-lint` to check YAML syntax and formatting

### Setup

Husky is installed as a dev dependency and initialized with `npm run prepare`.

The hook is configured in `.husky/pre-commit`.

### Skipping hooks

To skip the pre-commit hook for a commit:

```bash
git commit --no-verify
```

Or disable temporarily:

```bash
HUSKY_SKIP_HOOKS=1 git commit
```

## Commit-msg Hook

The commit-msg hook validates commit messages to ensure they follow conventional commit format.

### What it does

- Enforces lowercase, ≤40 characters first line
- Requires starting with type: like `feat:`, `fix:`, etc.
- Uses `lib/commit-msg-enforcer.mjs` for validation

### Setup

Husky is installed as a dev dependency and initialized with `npm run prepare`.

To activate the commit-msg hook:

```bash
cp hooks/commit-msg .husky/
```

(Deprecated: `npx husky add .husky/commit-msg "node hooks/commit-msg"` - no longer recommended. Manually copying/creating hook files in `.husky/` is preferred for better control.)

The hook is configured in `.husky/commit-msg`.

### Skipping hooks

To skip the commit-msg hook for a commit:

```bash
git commit --no-verify
```

Or disable temporarily:

```bash
HUSKY_SKIP_HOOKS=1 git commit
```

### Configuration

- Lint-staged config: `package.json` under `"lint-staged"`
- Prettier config: `package.json` under `"prettier"`
- ESLint config: `eslint.config.js`
- YAML lint config: `.yaml-lint.json`
- Commit-msg enforcer: `lib/commit-msg-enforcer.mjs`
