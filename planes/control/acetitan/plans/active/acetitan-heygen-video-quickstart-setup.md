# Plan: AceTitan HeyGen Video Quickstart Setup

> **Canonical plan location:** store active plans in the library control plane, not session workspace. Default paths:
> - **Active (in-progress):** `agent-library/<inner-library>/planes/control/<project>/plans/active/<plan-slug>.md`
> - **Completed:** `agent-library/<inner-library>/planes/control/<project>/plans/complete/<plan-slug>.md`
>
> For AceTitan, canonical planning/design paths now use **`private-library`**. Legacy `work-library` copies are superseded and should not be updated further.

| Status | Current Step | Last Updated | Complexity | Lifecycle Phase | Priority |
|--------|-------------|--------------|------------|-----------------|----------|
| NOT STARTED | Awaiting owner approval of revised Phase-0 design + plan | 2026-04-09 | **2** (ENABLEMENT) | **Phase-0 Feasibility** | **P1** (High) |

## Configuration

| Setting | Value |
|---------|-------|
| Step Timeout | 5 min |
| Max Retries | 1 |

## Tools & Permissions

> List all tools and permission-gated actions the plan will need, so the user can approve them upfront in batch instead of waiting at each step. Include the step(s) that need each tool.

| Tool / Permission | Steps | Purpose |
|-------------------|-------|---------|
| Read current AceTitan/project/library markdown and reference materials | 0.1, 0.2 | Select one topic and align the brief/script with existing AceTitan context and the HeyGen quickstart |
| planner / GPT-5.4 authoring | 0.1 | Create a short brief for one AceTitan topic |
| builder / Claude Sonnet 4.6 authoring | 0.2 | Produce the 60-90 second instructional script |
| OWNER HeyGen access | 0.3 | Render the approved script into a HeyGen avatar video |
| OWNER YouTube access | 0.4 | Prepare a YouTube draft upload from the rendered MP4 |
| Deferred Phase-1 private-library/project filesystem writes | 1, 2, 3, 4, 5, N-2, N-4, N | Reserved only if the work later migrates to Phase-1 institutionalization |

> **Phase-0 note:** audit-plane requirements, execution packets, and `shell.agent` filesystem commands are disabled for this feasibility run.

## AI Execution Protocol

This revised plan uses a minimal feasibility execution model:

- **`planner` / `GPT-5.4` = Brief framing**
  - selects one AceTitan topic
  - creates the short feasibility brief
  - defines acceptance boundaries for the single-video run
- **`builder` / `Claude Sonnet 4.6` = Script authoring**
  - produces one 60-90 second instructional script from the approved brief
- **`OWNER` = External execution**
  - renders the HeyGen video
  - exports the MP4
  - prepares the YouTube draft upload
- **`shell.agent` / `GPT-5.4` = Deferred**
  - not active in Phase-0
  - reserved for future Phase-1 filesystem/validation/git work only if institutionalization is approved

> **Phase-0 Override:**
> For feasibility runs, disable audit-plane requirements, execution packets, shell.agent filesystem commands, and GPT↔Claude human handoff gates. Use planner/builder only for brief→script authoring. External render is owner-performed in HeyGen.

**Completion gate:**
1. `>= 1` HeyGen-rendered AceTitan instructional video (MP4)
2. `>= 1` YouTube draft upload prepared from the render

**Audit status:** no audit report is required in Phase-0.
**Deferred Phase-1 audit path:** `C:\tiansrealm\agent-library\private-library\planes\audit\acetitan\reports\2026-04-09-heygen-video-quickstart-setup.md`

**Migration criteria to Phase-1:**
- `>= 3` HeyGen instructional videos produced from AceTitan topics
- at least one video approved for public or internal distribution

Upon meeting those criteria:
- re-enable Step 2 (scaffolding)
- re-enable Step N-2 (knowledge-plane refs)
- re-enable Step N-4 (audit report)
- restore completion gate: `report-written`

## Progress

### Phase-0 — Feasibility Run

| Step | Description | Agent (AI Model) | Status | Parallel | Review | Governance | Notes |
|------|-------------|------------------|--------|----------|--------|------------|-------|
| 0.1 | Select one AceTitan topic and create a short brief | planner/GPT-5.4 | TODO | — | HUMAN GATE | Minimal Resource; skills: Topic Framing | Topic must stay to one concept |
| 0.2 | Produce a 60-90s instructional script using HeyGen template shape | builder/Claude Sonnet 4.6 | TODO | — | HUMAN GATE | Competent; skills: Script Authoring | Uses approved brief from 0.1 |
| 0.3 | Render HeyGen avatar video from script | OWNER | TODO | — | — | External Action | External HeyGen access; owner-performed |
| 0.4 | Export MP4 and prepare YouTube draft upload | OWNER | TODO | — | — | External Action | 16:9 recommended; owner-performed |

### Phase-1 — Discover and prepare (deferred until migration criteria are met)

| Step | Description | Agent (AI Model) | Status | Parallel | Review | Governance | Notes |
|------|-------------|------------------|--------|----------|--------|------------|-------|
| 1 | Baseline discovery of AceTitan content pipeline, current docs, and institutionalization gaps | planner/GPT-5.4 | DEFERRED TO PHASE-1 | — | GATE | Core First | Not an active Phase-0 gate |
| 2 | Establish canonical directory scaffolding for control/knowledge/audit plus project docs/workflow/template paths | planner/GPT-5.4 → builder/Claude Sonnet 4.6 → shell.agent/GPT-5.4 | **DEFERRED TO PHASE-1** | — | HUMAN GATE + GATE | Minimal Resource | Explicitly deferred by patch |

### Phase-1 — Author workflow and reusable assets (deferred)

| Step | Description | Agent (AI Model) | Status | Parallel | Review | Governance | Notes |
|------|-------------|------------------|--------|----------|--------|------------|-------|
| 3 | Author the AceTitan HeyGen workflow and reusable template/checklist asset pack in the project repo | planner/GPT-5.4 → builder/Claude Sonnet 4.6 | DEFERRED TO PHASE-1 | — | HUMAN GATE | Competent, Lifelike, Safe | Parked until feasibility proves worth institutionalizing |
| 4 | Update project docs and navigation inside `C:\tiansrealm\projects\acetitan` | planner/GPT-5.4 → builder/Claude Sonnet 4.6 → supervisor.agent/GPT-5.4 | DEFERRED TO PHASE-1 | — | HUMAN GATE + GATE | Resilient | Parked until feasibility proves worth institutionalizing |

### Phase-1 — Validate, document, and close (deferred)

| Step | Description | Agent (AI Model) | Status | Parallel | Review | Governance | Notes |
|------|-------------|------------------|--------|----------|--------|------------|-------|
| 5 | Prepare validation evidence, acceptance checklist, and final artifact manifest for institutionalized workflow/docs | planner/GPT-5.4 → builder/Claude Sonnet 4.6 → supervisor.agent/GPT-5.4 | **DEFERRED TO PHASE-1** | — | HUMAN GATE + GATE | Resilient | Explicitly deferred by patch |
| N-4 | Test Changes — Phase-1 validation, knowledge/audit confirmation, and audit report delivery | shell.agent/GPT-5.4 | **DEFERRED TO PHASE-1** | — | GATE | Validation Execution; Audit Reporting | Explicitly deferred; `report-written` restored only in Phase-1 |
| N-3 | Sync Agent Docs — only if execution changes agent capabilities or routing expectations | builder/Claude Sonnet 4.6 | DEFERRED TO PHASE-1 | — | — | Minimal Resource | Expected SKIP unless Phase-1 changes agent behavior |
| N-2 | Update Library Docs — create/update AceTitan canonical reference docs in private-library knowledge plane | builder/Claude Sonnet 4.6 | **DEFERRED TO PHASE-1** | N-3 | GATE | Documentation First | Explicitly deferred by patch |
| N-1 | End of Plan — verify expected artifacts exist at canonical paths | supervisor.agent/GPT-5.4 | DEFERRED TO PHASE-1 | — | GATE | Artifact Review | Phase-1 closeout only |
| N | Finalize — mark plan COMPLETE, move file to `plans/complete/`, git commit approved results | shell.agent/GPT-5.4 | **DEFERRED TO PHASE-1** | — | — | Git Hygiene | Explicitly deferred by patch |

## Owner Note

- Project: `C:\tiansrealm\projects\acetitan`
- Base the work on: `C:\tiansrealm\agent-library\general-library\planes\knowledge\distilled\patterns\heygen-youtube-teaching-quickstart.md`
- Current scope is **Phase-0 feasibility only**
- Goal is one minimal render-and-draft proof, not documentation completeness
- Canonical planning/design/audit/knowledge references must use **`private-library`**, not `work-library`
- The design is intentionally retained as a slim planning contract because the owner explicitly requested both design + plan
- Old work-library plan/design files are superseded by the new private-library targets
- No execution starts until human approval is given

## Goal

Create and validate a minimal HeyGen instructional-video production flow for AceTitan topics that converts a brief into a 60-90 second talking-head video suitable for YouTube upload, using the fewest tools possible.

Success is defined by producing HeyGen-rendered MP4s from AceTitan topics and preparing at least one YouTube draft upload, not by documentation completeness.

## Design

> This enablement-phase plan still preserves a design document because the owner explicitly requested design + plan. It is a slim planning contract, not a Complexity-4 architecture gate.

**Design path**
`C:\tiansrealm\agent-library\private-library\planes\control\acetitan\contracts\design-acetitan-heygen-video-quickstart-setup.md`

**Design status**
Drafted in planning; execution blocked pending owner approval.

**Phase-1 directories to create if migration criteria are later met**
- `C:\tiansrealm\agent-library\private-library\planes\control\acetitan\plans\active\`
- `C:\tiansrealm\agent-library\private-library\planes\control\acetitan\plans\complete\`
- `C:\tiansrealm\agent-library\private-library\planes\control\acetitan\contracts\`
- `C:\tiansrealm\agent-library\private-library\planes\knowledge\acetitan\notes\`
- `C:\tiansrealm\agent-library\private-library\planes\knowledge\acetitan\catalogs\`
- `C:\tiansrealm\agent-library\private-library\planes\audit\acetitan\reports\`
- `C:\tiansrealm\projects\acetitan\docs\video-production\`
- `C:\tiansrealm\projects\acetitan\workflows\video-production\`
- `C:\tiansrealm\projects\acetitan\templates\heygen\`

**Phase-0 note**
These scaffolding paths are not active requirements for the current feasibility run.

## Steps

### Step 0.1 — Select one topic and create a short brief

Choose one AceTitan topic that can be taught as a single concept. Produce a compact brief that is sufficient to author one 60-90 second video script.

Deliverables for this step:
- one topic selection
- one short feasibility brief
- owner approval to proceed to script authoring

### Step 0.2 — Produce the instructional script

Turn the approved brief into one concise instructional script aligned to a HeyGen talking-head format.

Deliverables for this step:
- one 60-90 second script
- script structure suitable for direct HeyGen narration
- owner approval to proceed to external render

### Step 0.3 — Render HeyGen avatar video

OWNER uses HeyGen to render the approved script into a video.

Deliverables for this step:
- at least one rendered video output

### Step 0.4 — Export MP4 and prepare YouTube draft upload

OWNER exports the rendered video and prepares at least one YouTube draft upload from it.

Deliverables for this step:
- at least one MP4
- at least one prepared YouTube draft

### Step 1 — Baseline discovery and target structure confirmation (deferred)

This remains available as future institutionalization work, but it is not part of Phase-0 feasibility.

### Step 2 — Establish canonical scaffolding (**DEFERRED TO PHASE-1**)

Re-enable only after migration criteria are met. This includes private-library control/knowledge/audit scaffolding and project doc/workflow/template paths.

### Step 3 — Author workflow and reusable asset pack (deferred)

This becomes relevant only if feasibility is proven and the team wants reusable documentation/templates.

### Step 4 — Update project docs and navigation (deferred)

This becomes relevant only if the workflow is promoted into project-operational use.

### Step 5 — Prepare validation evidence and artifact manifest (**DEFERRED TO PHASE-1**)

The doc-first validation package is intentionally removed from active Phase-0 work.

### Step N-4 — Test Changes (**DEFERRED TO PHASE-1**)

Phase-0 verification is feasibility-based, not audit-based.

Deferred Phase-1 audit path:
`C:\tiansrealm\agent-library\private-library\planes\audit\acetitan\reports\2026-04-09-heygen-video-quickstart-setup.md`

### Step N-3 — Sync Agent Docs (deferred)

Only revisit if a future Phase-1 institutionalization run changes routing/capabilities.

### Step N-2 — Update Library Docs (**DEFERRED TO PHASE-1**)

Deferred private-library knowledge references:
- `C:\tiansrealm\agent-library\private-library\planes\knowledge\acetitan\notes\heygen-video-production-reference.md`
- `C:\tiansrealm\agent-library\private-library\planes\knowledge\acetitan\catalogs\content-asset-map.md`

### Step N-1 — End of Plan (deferred)

Phase-1 closeout only.

### Step N — Finalize (**DEFERRED TO PHASE-1**)

Do not perform git closeout or plan-file move during the current Phase-0 feasibility run.

## Diagrams

```text
HeyGen Quickstart Guide
        |
        v
+-------------------------------+
| Revised Planning Artifacts    |
| slim design + phase-0 plan    |
+---------------+---------------+
                |
                v
+---------------+---------------+
| Phase-0 Feasibility           |
| topic brief -> script         |
+---------------+---------------+
                |
                v
+---------------+---------------+
| OWNER External Actions        |
| HeyGen render -> MP4 ->       |
| YouTube draft                 |
+---------------+---------------+
                |
                v
+---------------+---------------+
| Migration Check               |
| >= 3 videos + 1 approved      |
+---------------+---------------+
                |
                v
+-------------------------------+
| Phase-1 Later                 |
| scaffolding + knowledge +     |
| audit + report-written        |
+-------------------------------+
```

## Verification

### Phase-0 feasibility checks
- Approved revised design targets `C:\tiansrealm\agent-library\private-library\planes\control\acetitan\contracts\design-acetitan-heygen-video-quickstart-setup.md`
- Approved revised plan targets `C:\tiansrealm\agent-library\private-library\planes\control\acetitan\plans\active\acetitan-heygen-video-quickstart-setup.md`
- One HeyGen-rendered MP4 exists for an AceTitan topic
- A YouTube draft is prepared from that render
- Completion gate is satisfied only when both feasibility outputs exist

### Phase-1 verification (deferred)
- Private-library knowledge-plane docs exist and mirror the operational workflow at reference level
- Durable audit report exists at `C:\tiansrealm\agent-library\private-library\planes\audit\acetitan\reports\2026-04-09-heygen-video-quickstart-setup.md`
- Completion gate is restored to **`report-written`** only after migration criteria are met and Phase-1 is activated

## Decisions

- **Use private-library for AceTitan planning/design/audit/knowledge references** — owner explicitly directed that AceTitan files should live in `private-library`, not `work-library`.
- **Keep a slim design contract** — preserved because the owner explicitly requested both design + plan, even though the work is now enablement-tier.
- **Re-scope to feasibility-first** — Phase-0 is for proving the instructional-video workflow is useful before institutionalizing documentation/governance.
- **Disable HARD-only operational gates in Phase-0** — no active audit-plane requirement, execution packets, shell commands, or `report-written` gate.
- **Assign external actions to OWNER** — HeyGen rendering and YouTube draft preparation are external-owner steps, not AI execution steps.
- **Treat old work-library artifacts as superseded** — they remain legacy references until a separate approved maintenance task moves/archives/removes them.
