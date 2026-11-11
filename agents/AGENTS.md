# Agent rules

Rules for every agent session. A project's own AGENTS.md or CLAUDE.md wins where it differs.

## Writing

- Write short, simple, casual plain English. No fluff, jargon or AI-sounding phrasing. No em dashes.
- Prefer prose over bullets, headings and tables. Management updates read as casual proposals, big picture first.
- Keep replies short. Explain with concrete examples. If I don't follow, explain it differently.
- Write atemporally: state the current design as fact, with no history, past plans or "now/previously". This applies to docs, comments and commits.
- Keep terms consistent with the glossary, the code and my settled wording.
- After changes, update every affected doc. Rewrite docs as a whole rather than appending patches.
- Write plans, research and hand-offs cleanly to a place I'll find. If there's no obvious one, ask where. Never commit plan files.
- In-repo docs define things once and link relatively. Docs for readers outside the repo stand alone.
- Headings and titles: short, technical, parallel, not playful. UI copy: short, plain, friendly.
- Messages for other people: short, casual, at their level, printed in chat ready to paste.

## Commits & PRs

- Title says WHAT, body says WHY in a few casual sentences. Never the HOW; the diff shows it. For big changes, a broad title plus one short WHAT paragraph.
- Imperative, third person. Prose; a short list only for discrete items. Run /unslop before showing a message.
- No Co-Authored-By trailer. Keep my `[f:...]` time tags when rewriting; don't invent new ones.
- Fold follow-up fixes into the commit they belong to. Before shipping, condense into a few atomic commits that each run.
- One concern per change. Unrelated fixes, or anything spanning repos, get their own branch and PR.
- Never overwrite commit messages or edits I made. Fetch upstream before rewriting history.
- Branch names: prefix plus one or two words.

## Code comments

- Default to none. A comment states WHY, never what or how, and never cites tickets, specs or chats.
- Keep my existing comments and JSDoc when moving code.

## Code

- Simplest thing that works: small diffs, fewest concepts, no unrequested options or incidental refactors. Simplifying means less code, not moved code.
- Inline by default. Extract only for real repetition across files. Shared config and constants can live in one module.
- Colocate until a file gets hard to follow, then split by concern, with tests mirroring the split.
- Reuse existing utils, types and libraries, and follow the repo's conventions.
- Short, clear names. When a term changes, rename everything that uses it.
- Boolean options default to false.
- Precise types: discriminated unions, branded types, no `any`, casts last. ESM-only, strict TypeScript, `erasableSyntaxOnly`, `#private` over `private`.
- Never swallow errors. User-facing error copy lives on the error, short and friendly.
- Remove debug code and noisy logs before committing. Never log secrets or tokens.
- Test meaningful behavior only, with a few thorough workflow tests. No TDD by default. Assert on codes, not message strings.
- Toolchain: pnpm and pnpx (never npm or npx), oxlint and oxfmt, vitest, valibot. Use latest versions: exact versions for app dependencies, `^` ranges for library dependencies. Run missing CLIs with pkgx or pnpx instead of installing them or asking.
- UI: build on the existing design, flat and minimal. CSS nesting always starts with `&`; Grid, gap and padding over margins; fluid units.
- Mobile-first and touch-friendly, no layout shift, one primary action per state.
- Target Baseline Newly Available with progressive enhancement. Respect reduced motion.

## Architecture

- Seek the fewest moving parts. No speculative machinery: every addition needs a clear purpose, and the platform or existing code may already handle it.
- One source of truth, one code path. Derive instead of storing copies. Dependencies point one way.
- Keep product behavior and data intact when simplifying.
- Start with the smallest fix. Go broader if the code is patchy. Suggest a refactor for a fundamental issue instead of doing it.
- Unreleased projects get no backwards compat. With real deployed clients, expand and contract: deprecate as cheap no-ops, delete once clients have moved.
- Match security and robustness effort to what's at stake. Hardcode before making things configurable.
- Small public APIs with good defaults and an escape hatch. Fail loudly instead of hiding missing capabilities.
- Generate build artifacts at build time instead of committing them.
- Reset migrations freely before the first deploy, forward-only after.

## Working with me

- When I say discuss, investigate, review or plan, change nothing until I say go.
- For non-trivial work, research and propose a plan before coding. Once it's approved, work through it and stop only for real blockers.
- Ask decisions directly, one at a time: context first, then options, trade-offs and your recommendation. Check the code before asking.
- Do exactly what I asked. No unrelated changes.
- Research official docs and changelogs instead of answering from memory.
- Verify claims against code, logs or the running system. Measure before drawing performance or architecture conclusions, and say what's measured versus assumed. Treat my reports as facts.
- Reproduce bugs and run diagnostics yourself instead of asking me.
- Run format, lint, typecheck and relevant tests before calling work done. Skip only when I say CI covers it.
- When a dev server is available, check UI changes with agent-browser. Never start or restart it to do so.
- Delegate research, QA and bulk work to sub-agents to keep context small.
- Run implement/review loops only when I ask. Sol runs through opencode with the `openai/` provider. Check review findings against the code and push back on the rest.
- When I must act, give exact copyable steps.
- After long tasks, say what's done, blocked or left and suggest next steps. Never list changed files.
- Clean up temp files and worktrees when done.

## Safety

- Commit a unit of work once it's clean and clearly ready. If it still needs QA or review, only stage it.
- Never push, tag, open PRs, deploy or post comments unless I asked for that exact action.
- Stay on the current branch unless told; ask if it looks unrelated. Never amend commits that may already be pushed.
- Check git status first. Unexplained changes may be mine: ask, and never touch or sweep them into commits.
- For irreversible deletions, report findings first and act only on my explicit go.
- Never mutate prod data. Try risky scripts and migrations locally or in dev first.
- Don't stop or restart running jobs, dev servers or my apps.
- Keep secrets out of commits, config and logs. Never write persistent git config.
