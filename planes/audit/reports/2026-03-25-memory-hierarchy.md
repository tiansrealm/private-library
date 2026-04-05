---
DocType: Plane-Targeted Guide
IntentType: Reflective
TargetPlane: audit
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
topic: Memory Hierarchy Implementation
importance: 0.9
---

# Session: Memory Hierarchy Implementation

## What Was Learned

- Agent-infra's memory system (`agent-infra/src/memory/`) is mature: SQLite + FTS5, multi-provider embeddings (Voyage, Gemini, OpenAI, Ollama), hybrid BM25+vector search, MMR re-ranking, temporal decay
- The cron system exists and is ready to use for consolidation jobs
- USER.md was an empty template never connected to anything — deleted
- User profile data was duplicated across 3 locations — consolidated into single source of truth

## What Changed

### New files
- `agent-infra/src/memory/archive.ts` — L4 archive storage (SQLite at ~/.tiansrealm/archive/, FTS5 keyword search)
- `agent-infra/src/memory/cascading-recall.ts` — Confidence-driven L1→L2→L3→L4→Explore→Online cascade, importance promotion on deep recall
- `agent-infra/src/memory/consolidation.ts` — Periodic job: demote old low-importance to L4, dedupe, decay importance
- `library/general/_manifest.json`, `agent-library/private-library/_manifest.json`, `library/work/_manifest.json` — access scope manifests

### Modified files
- `agent-infra/src/memory/memory-schema.ts` — Added `importance` and `scope` columns to chunks table
- `agent-infra/src/memory/manager-search.ts` — Search results now weighted by importance (vector, keyword, and fallback paths)
- `library/general/agent-principles/memory-hierarchy.md` — Added cascading recall, confidence model, library access control sections
- `SOUL.md` — Added Session Protocol (mandatory session logging), updated library paths
- `library/catalog.md` — Updated for new general/private/work structure
- `plans/active/plan-memory-hierarchy.md` — Fully rewritten: fixed paths, added cascading recall, library restructure, user profile cleanup steps

### Restructured
- `library/` split into `general/` (any agent), `private/` (owner only), `work/` (work agents)
- `USER.md` deleted, `library/user-profile/profile.md` deleted
- `agent-library/private-library/planes/identity/contracts/tian.md` is now the canonical user profile (merged from 3 sources)

### Key decisions
- **Cascading recall model**: Agent searches top-down with confidence self-rating, only escalates when confidence < 0.7. Memories found deep get importance bumped.
- **Explore before guessing**: After exhausting all memory layers, agent deep-reads accessible library sections, then searches online. Never gives low-confidence answer without trying.
- **Library access control via directory structure**: general/private/work subdirectories with _manifest.json, not metadata-only enforcement.
- **Session logs are mandatory**: Added to SOUL.md as Alpha's protocol. Every session saves to agent-library/private-library/planes/memory/reports/session-summaries/.

## What's Unfinished

- Consolidation cron job not wired into the cron system yet (code exists, needs scheduling config)
- L2→L3 promotion in consolidation is placeholder (marked `promoted: 0` — agent writes directly for now)
- `library/work/` is empty — needs symlink to work library when ready
- No tests written for new modules (archive.ts, cascading-recall.ts, consolidation.ts)
- Scope filtering in cascading recall not fully wired (column exists, query filtering TBD)
