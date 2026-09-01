# WI-6247112 Homepage ZQ Mapping — Session Summary (2026-04-15)

<!--
Complexity: medium
Type: mixed
Agent: alpha
-->

## Status

Partial. UCI DAB click is live-validated and dashboard-ready; homepage ZQ ownership and telemetry family are materially narrowed, but the exact homepage card-click contract in `copilot_events` is still unresolved.

> **Durable report rule:** MEDIUM/HARD execution sessions are not complete until the markdown report artifact exists at the path assigned in the execution contract. For general/system work: `C:\tiansrealm\agent-library\general-library\planes\audit\reports\YYYY-MM-DD-<task-slug>.md`. For work-related/org-delivery work (keywords `catalyst` or `bizchat` → Catalyst/BizChat): `C:\tiansrealm\agent-library\work-library\planes\audit\catalyst\reports\YYYY-MM-DD-<task-slug>.md`. Path is resolved at planning time. Do not duplicate in both libraries.
>
> **Boundary rule:** Behavioral trace → Audit. Outcome observation / learning signal → Memory.
>
> **Reflection read rule:** Reflection may read Audit for validation/constraint checks only. Reflection may read Memory for learning/improvement only.
>
> Use this template for factual execution evidence. If the session produced retrospectives, lessons learned, retry/tool effectiveness observations, or other improvement signals, store those in `C:\tiansrealm\agent-library\general-library\planes\memory\reports\`.

## Context

This session continued WI-6247112 (`[Catalyst] DAB - BizChat ZQ / DAB click telemetry Dashboard`) from initial query drafting into ownership clarification and live telemetry validation. The core question became: which click signals are real, which telemetry environment they live in, and whether local CRM/PPUX repos contain the actual homepage-ZQ emitter or only the integration boundary.

## What Changed

1. **Confirmed there was no prior 6247112-specific query artifact** — checked work item history, session artifacts, and prior reports; found only adjacent work from WI-6238690 and then created the first durable WI-6247112 note set.
2. **Created the initial WI-6247112 query note** — wrote `C:\tiansrealm\agent-library\work-library\planes\knowledge\catalyst\notes\wi-6247112.md` with UCI DAB queries plus BizChat discovery queries and a paired audit report.
3. **Investigated the screenshot-backed homepage ZQ UI** — traced CRM DAB prompt generation and PPUX BizChat handoff, confirmed the visible homepage prompt-card strings were absent from local CRM/PPUX repos, and documented that local code only owned the handoff boundary.
4. **Ingested the homepage architecture guide into library** — added a dedicated note showing homepage ZQ prompts are remote Substrate suggestions rendered by Copilot Shell, controlled by `enableHomepageFallbackPrompts`, and conceptually mapped to `SOTItemClicked`, `HOME_CARD_EXTERNAL`, and `QuerySubmit` under `PowerApps.Web.Copilot_Drawer`.
5. **Live-validated the DAB side in Kusto** — proved `CopilotUserGesture` + `DABButtonClick` exists in `userx.kusto.windows.net` / `0b14a44360bf4cae8e1e090ac91a04e5` / `uci_monitor_success` with 7 rows over the last 30 days.
6. **Disproved the homepage-ZQ markers in BizChat Prod** — searched `immersive_bizchat_web` and `immersive_bizchat` and confirmed `SOTItemClicked`, `HOME_CARD_EXTERNAL`, and `PowerApps.Web.Copilot_Drawer` were absent there, despite generic `QuerySubmit` volume being high.
7. **Validated a teammate-provided alternate Kusto environment** — confirmed `cluster('bizchat.eastus2.kusto.windows.net').database('91e6bb9f0cc74e2d8c7f29478edfb940').copilot_events` exists and contains PowerApps drawer/homepage telemetry.
8. **Mapped `copilot_events` to code ownership** — found `MetaData.scenario="PowerApps.Web.Copilot_Drawer"` and semantic homepage/query/Sydney events in `copilot_events`, but no exact local code matches for those emitter names; concluded local CRM/PPUX code is the correct integration boundary, not the actual homepage/drawer emitter.
9. **Used the updated Catalyst catalogs to refine repo search** — the new `cai-feature-repo-map.md` narrowed the best local candidate to `power-platform-ux\packages\powerapps-fpi\src\AppCopilot\` and `...\CopilotCardBot\`, but exact homepage/drawer event markers still were not present locally.

## Decisions & Rationale

- **[key] Treat homepage ZQ and UCI DAB as separate telemetry pipelines** — The session preserved the distinction between local CRM-owned DAB prompt telemetry and upstream homepage-ZQ prompt telemetry. Rejected: forcing both sides into the BizChat Prod tables — that had already produced false negatives for the homepage side.
- **[key] Accept upstream/non-local emission as a valid verification outcome** — Once `copilot_events` showed PowerApps drawer telemetry but local repo search still lacked exact emitter names, the run was allowed to conclude that local repos are bridges, not emitters. Rejected: continuing to hunt indefinitely for an exact local string match — that would have ignored the architecture and telemetry evidence.
- **Promote the teammate ADX pointer into the active hypothesis** — The new `copilot_events` database was treated as the likely homepage telemetry family because it contained `PowerApps.Web.Copilot_Drawer` and adjacent homepage/query/Sydney semantics. Rejected: keeping BizChat Prod as the homepage validation target after repeated zero-row results.
- **Use work-library notes as the living execution plan for WI-6247112** — The query note and related architecture notes were updated in place as understanding improved. Rejected: creating a separate ad hoc plan outside the existing WI note set — that would have split the source of truth.

## Resume

1. Start with `C:\tiansrealm\agent-library\work-library\planes\knowledge\catalyst\notes\wi-6247112.md` and `...\wi-6247112-homepage-bizchat-zq-architecture.md` to restore the current comparison model.
2. Re-open `C:\tiansrealm\agent-library\work-library\planes\audit\catalyst\reports\2026-04-10-wi-6247112-copilot-events-code-surface-mapping.md` and use its event-mapping table as the launch point.
3. In `copilot_events`, focus on the homepage/drawer family around:
   - `MetaData.scenario = "PowerApps.Web.Copilot_Drawer"`
   - `EventScope='Home'`
   - `HomeQuery`
   - `GetUserPrompts`
   - `QuerySubmit`
   - `Sending request to Sydney...`
   - `SydneyClient` success rows
4. Get the **exact homepage card-click contract** for `copilot_events` from the producer owners before building the homepage click tile:
   - likely owner path: Copilot Shell / BrainSDK / external 1JS surface
   - team hints now in library: `gp.m365-copilot-prompts`, `O365Core/searchservices`
5. If more local code search is needed, start with:
   - `C:\DevRepos\power-platform-ux\packages\powerapps-fpi\src\AppCopilot\`
   - `C:\DevRepos\power-platform-ux\packages\powerapps-fpi\src\CopilotCardBot\`
   and only then fall back to CRM/PPUX BizChat bridge files.

## Issues & Risks

- **Homepage click contract still unresolved** — `copilot_events` looks like the right telemetry family, but the exact click event/field equivalent to `SOTItemClicked` + `HOME_CARD_EXTERNAL` was not identified.
- **Architecture doc and live producer differ in naming** — The guide names `SOTItemClicked` / `QuerySubmit`, while `copilot_events` exposed semantically related but differently named rows. That mismatch could mislead future searches if treated as a strict schema guarantee.
- **Local repo coverage is incomplete** — the new catalog points to repos/surfaces not cloned locally (`CRM.Client.PowerAppsExtensions`, PowerApps repo / RP, external 1JS/Catalyst SDK ownership lane), so some producer code may remain inaccessible from this workspace.

## Friction Log

- BizChat Prod was the first homepage-ZQ validation target → returned 0 rows for homepage-specific markers, which forced the search away from BizChat-native tables.
- The architecture guide suggested exact event names → the newly found `copilot_events` table showed the right scenario family but not those exact names.
- Initial local repo searches focused on CRM/PPUX BizChat surfaces → the updated catalog shifted the best local seam toward `AppCopilot` / `CopilotCardBot`, but still did not expose the emitter.

## Corrections & Redirects

- **Homepage prompts are not local BizChat UI code** — Before: the investigation only knew the strings were not in CRM/PPUX and attributed them loosely to an external runtime. After: the ingested guide resolved them to remote Substrate suggestions rendered by Copilot Shell. Why it matters: repo search should target ownership and telemetry boundaries, not just visible strings.
- **BizChat Prod is not the homepage prompt telemetry source of truth** — Before: homepage click/execution validation started in `immersive_bizchat_web` / `immersive_bizchat`. After: the absence there was treated as an environment mismatch, not missing instrumentation, and `copilot_events` became the primary homepage candidate. Why it matters: prevents repeating zero-result searches in the wrong telemetry family.
- **Local code can be correct even when it is not the emitter** — Before: not finding exact event names locally risked looking like the wrong code had been inspected. After: the session established that CRM/PPUX are the right handoff surfaces but not the homepage/drawer emitters. Why it matters: preserves confidence in the integration-boundary code while escalating producer lookup to the right owner lane.

## Open Items

- [ ] Identify the exact homepage card-click event/field contract in `copilot_events` for the PowerApps drawer flow.
- [ ] Confirm whether `QuerySubmit` in `copilot_events` can be constrained to the homepage card flow strongly enough for a click→submit comparison.
- [ ] Determine whether the missing producer code is in an uncloned PowerApps repo, BrainSDK/1JS surface, or a service-side emitter owned by `O365Core/searchservices`.

## Artifacts

- Files: `C:\tiansrealm\agent-library\work-library\planes\knowledge\catalyst\notes\wi-6247112.md`, `C:\tiansrealm\agent-library\work-library\planes\knowledge\catalyst\notes\wi-6247112-bizchat-zq-default-prompts-ui.md`, `C:\tiansrealm\agent-library\work-library\planes\knowledge\catalyst\notes\wi-6247112-homepage-bizchat-zq-architecture.md`, `C:\tiansrealm\agent-library\work-library\planes\knowledge\catalyst\catalogs\cai-feature-repo-map.md`
- Durable reports:
  - `C:\tiansrealm\agent-library\work-library\planes\audit\catalyst\reports\2026-04-09-wi-6247112-work-library-queries.md`
  - `C:\tiansrealm\agent-library\work-library\planes\audit\catalyst\reports\2026-04-09-bizchat-zq-default-prompts-investigation.md`
  - `C:\tiansrealm\agent-library\work-library\planes\audit\catalyst\reports\2026-04-10-bizchat-homepage-zq-architecture-ingestion.md`
  - `C:\tiansrealm\agent-library\work-library\planes\audit\catalyst\reports\2026-04-10-wi-6247112-comparison-signals-kusto-validation.md`
  - `C:\tiansrealm\agent-library\work-library\planes\audit\catalyst\reports\2026-04-10-wi-6247112-copilot-events-code-surface-mapping.md`
- Session summary: `C:\tiansrealm\agent-library\private-library\planes\memory\reports\session-summaries\session-2026-04-15-wi-6247112-homepage-zq-mapping.md`

## Governance

- **Complexity:** medium
- **Skills used:** [routing-and-delegation, memory-recall, session-end]
- **Principles/rules applied:** [evidence-based verification, preserve pipeline boundaries, do not overclaim absent data, work-library for catalyst/bizchat artifacts]
- **Challenges encountered:** [wrong initial telemetry family for homepage signals, exact marker mismatch between architecture guide and live table, partial local repo coverage]
- **Delegations:** [router: classify research/validation requests — adopted, planner: define writeback/report contracts — adopted, projection.agent: split execution between shell and builder where needed — adopted, shell.agent: repo search + Kusto validation/mapping — adopted, builder: note/report writeback — adopted]

## Self-Assessment

- **Went well:** The session moved from vague ownership assumptions to a concrete split: DAB is live and local enough, homepage ZQ is upstream and now tied to a specific telemetry family.
- **Uncertain:** The exact homepage click contract in `copilot_events` is still missing, so the final comparison tile is not yet build-ready.
- **Patterns noticed:** New external evidence (guide, teammate ADX pointer, updated catalog) repeatedly unlocked progress faster than repeated local-only searching.
- **Next time:** Start from the newest external ownership/telemetry hints first, then use local repos only to confirm the handoff boundary.

## Post-Session Review

Reviewed by:
1. kongming — pending
2. <agent-id> — pending
