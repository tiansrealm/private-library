---
DocType: Plane-Targeted Guide
IntentType: Normative
TargetPlane: governance
InPlaneCategory: Contracts
AuthorityImpact: RestrictsMutation
MutationBinding: RuntimeEnforced
CrossPlaneEffect: BootIdentity
DocLifecycle: Active
DelegationSafe: false
Version: 1.0
---
---
title: Role-Based Authority System
type: reference
scope: owner-only
note: This is the source of truth for all agent authority. Agents can read but CANNOT write. Only owner sessions can modify this file.
---

# Role-Based Authority System

Agents are granted authority through roles. Roles are additive — an agent can hold multiple roles, and permissions stack. Every agent gets `default`.

**This file is the canonical source of truth.** Agent AGENTS.md `## Authority` sections are mirrors/caches. If they conflict, this file wins.

## Roles

### default
Base role — all agents receive this automatically.

| Permission | Details |
|---|---|
| Report | File reports, urgency cap: **50** |
| Growth | Update skill frequency, promote skills (mutable fields only — see [growth protocol](../../general/growth/growth-protocol.md#growth-boundaries)) |
| Library read | Read any `library/` content |
| Memory recall | Cascading memory lookup |

### elite
Elevated trust — agents that orchestrate others or manage shared systems.

| Permission | Details |
|---|---|
| Report | Urgency cap raised to **95** |
| Orchestrate | Spawn and delegate to other agents |
| Shared writes | Write to shared resources (library sections, reports) |
| Cross-agent modify | Modify other agents' files within domain scope (never authority sections) |

### admin
Full authority — reserved for primary agent (Alpha). Other agents can act at admin level with owner approval.

| Permission | Details |
|---|---|
| Report | Urgency cap: **100** |
| Deploy/merge | Merge PRs, trigger deploys (owner-gated) |
| Root MEMORY.md | Write access to root `MEMORY.md` |
| All permissions | No restrictions within tiansrealm |

## Role Assignments

| Agent | Roles | Domain Scope |
|---|---|---|
| Alpha | admin | All |
| Daedalus | elite | Agent lifecycle — `agents/`, registry, awareness graph |
| Kongming | default | Plans — `plans/` |
| Shiori | default | Library — `library/` |
| Ashe | default | Conversation only |
| ADO | default | Work — ADO work items |
| Code | default | Work — source code |
| Code-Analyst | default | Work — code analysis (read-only) |
| Code-Review | default | Work — PR review |
| ICM | default | Work — incident investigation |
| Impact-Tracker | default | Work — contribution ledger |
| Perf-Analyst | default | Work — performance investigation |
| Telemetry | default | Work — KQL/Kusto analysis |
| Wiki-Manager | default | Work — wiki documentation |
| Sensei | default | Advisory — agent training, growth evaluation |

## External Users

External users (Discord, Telegram, etc.) have **no roles and no authority by default**. They can only interact through gateway-exposed channels. Any privileged action requires explicit owner grant. This applies to all non-owner humans — the role system is for agents only.

## Design Principles

- **Roles are cross-cutting** — they handle shared permissions (report caps, orchestration, memory access)
- **Domain scope is per-agent** — what the agent works on stays in its `AGENTS.md` Authority section
- **Additive only** — roles grant permissions, never revoke. No "deny" rules
- **Owner override** — any agent can perform any action with explicit owner approval, regardless of role
- **Report cap formula** — `urgency = min(agent_assessment, role_cap)` where role_cap is the highest cap from the agent's assigned roles
- **No self-escalation** — agents cannot modify this file or grant themselves new roles. Authority flows from owner only.
