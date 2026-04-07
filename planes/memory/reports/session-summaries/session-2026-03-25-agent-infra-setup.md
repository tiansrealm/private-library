---
DocType: Plane-Targeted Guide
IntentType: Reflective
TargetPlane: memory
InPlaneCategory: Reports
AuthorityImpact: ObservabilityOnly
MutationBinding: NonBinding
CrossPlaneEffect: None
DocLifecycle: Record
DelegationSafe: true
Version: 1.0
---
---
date: 2026-03-25
topic: Agent Infrastructure Setup & Skills
importance: 0.9
---

# Session: Agent Infrastructure Setup & Skills

## What Was Learned

- OpenClaw workspace convention: each agent gets `AGENTS.md`, `SOUL.md`, `IDENTITY.md` (no `USER.md` — we use `agent-library/private-library/planes/identity/contracts/tian.md` instead)
- Dashboard reads agents from `agents.list[]` in `~/.openclaw/openclaw.json` + auto-discovers from `~/.openclaw/state/agents/` on disk
- Agent workspace file changes (AGENTS.md, SOUL.md) picked up on next session without rebuild. Config changes (`agents.list[]`) require gateway restart.
- Gateway watch mode: `pnpm gateway:watch` (watches source, not config)
- Dashboard watch mode: `pnpm ui:dev` (Vite on localhost:5173)
- Discord replies to bot trigger same flow as @mentions (implicit mention detection)
- Sessions already capture both user + agent messages in real-time (JSONL), no need for separate chat-logger hook
- Heartbeat IS per-agent (`heartbeat` field on each agent in `agents.list[]`), not just default agent
- Cron vs heartbeat: heartbeat = main session periodic checklist, cron = exact-time isolated tasks
- Skills: three-tier storage (workspace > managed > bundled), shared via `~/.openclaw/skills/` or `skills.load.extraDirs`
- 51 bundled skills in agent-infra
- Old library docs (sessions.md, channels.md, claude-cli-backend.md, dev-workflow.md) were outdated — referenced SQLite, bridge, classifyIntent() from pre-fork era

## What Changed

### New files
- `agents/` — 11 agent folders with AGENTS.md, SOUL.md, IDENTITY.md following OpenClaw conventions
- `agent-library/general-library/execution/skills/` — 6 shared skills: memory-recall, agent-identity, routing-and-delegation, competent-behavior, lifelike-behavior, safe-boundaries
- `library/general/tiansagent-guide/cron-vs-heartbeat.md` — when to use each
- `library/general/tiansagent-guide/skills.md` — skill system guide

### Modified files
- `newinfra/` → `agent-infra/` — directory rename + all references updated across workspace
- `.gitignore` — added `USER.md`, `agent-infra/dist-runtime/`
- `CLAUDE.md` — updated workspace layout description
- `SOUL.md` — trimmed redundancy with shared skills, added agent creation capability
- `library/general/agent-registry.md` — added Status column (Active/Planned), path reference
- `agents/librarian/AGENTS.md` — session-based profile maintenance + library cleanup responsibility
- `~/.openclaw/openclaw.json` — added all 11 agents to `agents.list[]`, added `skills.load.extraDirs`

### Moved to outdated
- `library/general/tiansagent-guide/outdated/sessions.md` — old SQLite session store
- `library/general/tiansagent-guide/outdated/claude-cli-backend.md` — old queue-based routing
- `library/general/tiansagent-guide/outdated/channels.md` — old classifyMessage() system
- `library/general/tiansagent-guide/outdated/dev-workflow.md` — old core/gateway package split

### Deleted
- `USER.md` — empty template, gitignored to prevent reappearing

### Key decisions
- Shared skills live in `agent-library/general-library/execution/skills/` (git-tracked) rather than `~/.openclaw/skills/` (untracked), referenced via `skills.load.extraDirs`
- No chat-logger hook needed — existing session transcripts capture everything
- Librarian agent owns library cleanup: moves outdated content to `outdated/` folders, never deletes directly
- Alpha can create new agents — full workflow documented in SOUL.md

## What's Unfinished

- Librarian cron job not yet created (`openclaw cron add` — requires running gateway)
- `library/general/tiansagent-guide/overview.md` needs directory path corrections (still references some old paths)
- 4 outdated files in `tiansagent-guide/outdated/` awaiting owner review for deletion
- 9 planned agents have stub definitions only — need full operating instructions when activated
- `pnpm install` in agent-infra needed before gateway can start
- Tiansagent-guide docs could use rewrites for sessions, channels, CLI backend using agent-infra's actual architecture
