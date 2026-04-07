# Discord Pipeline and Temporal Fix — Session Summary (2026-04-05)

<!--
Complexity: complex
Type: debug
Agent: alpha
-->

## Status

Complete. Discord now routes through `alpha` end-to-end, report-bearing alpha execution can produce the required markdown audit artifact, and the local Temporal worker now recovers when `localhost:7233` is down by starting the local core stack and retrying until ready.

> **Durable report rule:** MEDIUM/HARD execution sessions are not complete until the markdown report artifact exists at `C:\tiansrealm\agent-library\general-library\planes\audit\reports\YYYY-MM-DD-<task-slug>.md`.
>
> **Boundary rule:** Behavioral trace → Audit. Outcome observation / learning signal → Memory.
>
> **Reflection read rule:** Reflection may read Audit for validation/constraint checks only. Reflection may read Memory for learning/improvement only.
>
> Use this template for factual execution evidence. If the session produced retrospectives, lessons learned, retry/tool effectiveness observations, or other improvement signals, store those in `C:\tiansrealm\agent-library\general-library\planes\memory\reports\`.

## Context

This session started because the Discord message pipeline into `agent-infra2` was still broken in live use. The work expanded into three linked fixes: removing reliance on unreviewed legacy agents, ensuring alpha-routed Discord execution produces the required audit report artifact, and fixing the Temporal worker startup failure at its real local-dev root cause.

## What Changed

1. **Reproduced the Discord failure locally** — Ran the runtime and Discord flow locally, sent live test requests, and confirmed the failure path instead of relying on tests alone.
2. **Removed legacy-agent dependence again** — Deleted the temporarily restored `.github\agents\advisor.md`, `.github\agents\engineer.md`, `.github\agents\scout.md`, and `.github\agents\sentinel.md` after owner correction that those agents remain under review and must not be reintroduced.
3. **Made alpha the only reviewed user-facing runtime default** — Updated `agent-infra2\.env.example` and `agent-infra2\src\runtime\agent-registry.ts` so the active routing cohort defaults to `alpha` instead of the old static registry.
4. **Fixed Discord authority handling for alpha** — Updated `agent-infra2\src\guardrails\authority-policy.ts` so Discord traffic targeting `alpha` is allowed as the reviewed entrypoint, and aligned tests to the actual loaded registry instead of a hardcoded cohort.
5. **Fixed the second guardrail failure across Temporal activities** — Propagated Discord routing context into Temporal activity execution through `agent-infra2\src\orchestrator\activities\direct-agent.ts`, `agent-infra2\src\orchestrator\interceptors.ts`, `agent-infra2\src\orchestrator\activities\plan-with-alpha.ts`, and `agent-infra2\src\orchestrator\workflows\retry-stabilization.ts`.
6. **Made report creation automatic for alpha execution-like Discord requests** — Added `agent-infra2\src\gateway\report-deliverables.ts` and `agent-infra2\src\orchestrator\execution-contract.ts`, then wired `agent-infra2\src\gateway\gateway-core.ts` and direct-agent prompt assembly to infer and pass the audit report contract automatically.
7. **Raised the direct-agent Temporal timeout budget** — Updated `agent-infra2\src\orchestrator\activity-options.ts` so report-bearing alpha runs have enough time to complete.
8. **Verified the durable audit report artifact exists** — Confirmed the markdown audit report at `C:\tiansrealm\agent-library\general-library\planes\audit\reports\2026-04-05-fix-the-discord-pipeline-issue-and-reproduce-it.md`.
9. **Fixed the Temporal worker startup root cause for local development** — Added `agent-infra2\src\orchestrator\worker-startup.ts`, wired `agent-infra2\src\orchestrator\worker.ts` through it, added tests in `agent-infra2\src\orchestrator\worker-startup.test.ts`, and implemented local Docker core auto-start plus bounded retry for `localhost:7233`.
10. **Validated the final worker behavior live** — With core services down, `pnpm worker` now logs that Temporal is unavailable, starts `docker compose --profile core up -d`, retries, and reaches `Worker started, polling for tasks`.

## Decisions & Rationale

- **[key] Keep deleted legacy agents deleted** — The runtime and tests were brought into alignment with the reviewed agent surface instead of restoring missing agent definitions. Rejected: reintroducing `advisor`/`engineer`/`scout`/`sentinel` as compatibility shims — that would have hidden the policy mismatch and violated the owner correction.
- **[key] Preserve Discord routing context through the Temporal boundary** — The first authority fix at gateway level was not enough because a second policy check ran inside the activity without adapter context. Rejected: broad authority exceptions for `alpha` — that would have weakened the guardrail instead of carrying the correct context.
- **[key] Auto-attach and expose the report contract for alpha execution work** — Report enforcement needed both a deliverable on the request and explicit prompt-visible instructions to the executor. Rejected: relying on CLI-only deliverable wiring — Discord and gateway paths would continue to miss the artifact requirement.
- **Fix worker startup by recovering local Temporal availability, not by retry alone** — The real failure was that nothing was listening on `localhost:7233`. Rejected: only increasing retries — that still fails when the core stack never starts.

## Decision Flow

Reproducing the Discord failure (1) exposed the invalid legacy-agent assumption, which led to the alpha-only routing correction (2-4). That exposed the activity-boundary context loss, which required propagated routing context (5). Once the pipeline worked end-to-end, the missing report artifact path led to automatic deliverable inference and prompt contract injection (6-8). The later worker crash report then traced to the stopped local Temporal stack, leading to the worker startup recovery fix and live validation (9-10).

## Resume

1. If Discord regresses, replay a non-owner Discord request through `agent-infra2` and confirm both gateway and activity-side policy checks still receive `routingContext.sourceAdapter='discord'`.
2. If report artifacts go missing again, inspect `agent-infra2\src\gateway\report-deliverables.ts` and `agent-infra2\src\orchestrator\execution-contract.ts` first to confirm the request still carries and exposes `deliverables.auditReport`.
3. If the worker again fails on `localhost:7233`, check whether `TEMPORAL_AUTO_START_CORE` was disabled or whether Docker is unavailable; the worker-side recovery depends on being able to run `docker compose --profile core up -d`.
4. Consider whether the same local Temporal bootstrap behavior should also be added to non-worker clients such as `gateway-core.ts` or workflow clients if similar local-dev failures appear.

## Issues & Risks

- **Worker auto-start is local-only by design** — Non-local Temporal addresses do not attempt Docker startup, so remote/devcontainer failures still require manual infrastructure handling.
- **Long-running alpha report sessions remain heavier than normal direct executions** — The direct-agent timeout was increased, but very long report-bearing executions may still need future tuning.
- **Shared environment noise** — Docker profiles outside `core` can remain up and make the compose environment look healthier than it is; Temporal availability should be checked directly.

## Friction Log

- Restoring deleted specialist agents briefly made the runtime pass, but the owner redirected that those agents remain under review and must stay deleted.
- The first Discord→alpha guardrail fix looked correct at gateway level, but live replay exposed a second denial inside the Temporal activity interceptor.
- The first successful Discord replay still failed the owner expectation because it produced a workflow outcome JSON without the required markdown audit report.
- Initial worker hardening added retry behavior, but the owner redirected that retry was not the underlying fix because `localhost:7233` was consistently refusing connections.

## Corrections & Redirects

- **Do not restore missing specialist agents** — Before: missing legacy agents were temporarily restored to get the runtime passing. After: those files were deleted again and the runtime/tests were changed to stop depending on them. Why it matters: reviewed surface area must drive runtime behavior, not the other way around.
- **Alpha is the only current user-facing entrypoint** — Before: some routing/test assumptions still encoded a static legacy cohort. After: runtime defaults and assertions were made registry-driven and alpha-only by default. Why it matters: keeps behavior consistent with the actual reviewed agent surface.
- **A successful fix still needs the expected artifact** — Before: the Discord bug fix was treated as complete once the pipeline executed. After: completion required reproducing the markdown audit report path expected by `alpha.md`. Why it matters: functional success is incomplete when the contractual artifact is missing.
- **Session end requires a structured session summary, not an informal closeout** — Before: the session was closed in chat without writing the session summary artifact. After: this summary was written and the trigger is being reinforced in Alpha's skills. Why it matters: continuity rules need durable records, not just chat text.

## Open Items

- [ ] Decide whether local Temporal auto-start should remain worker-only or be extended to other local clients.
- [ ] Review whether additional timeout tuning is needed for long alpha report-bearing runs beyond the current direct-agent increase.

## Artifacts

- Files: `C:\tiansrealm\agent-infra2\.env.example`, `C:\tiansrealm\agent-infra2\src\runtime\agent-registry.ts`, `C:\tiansrealm\agent-infra2\src\guardrails\authority-policy.ts`, `C:\tiansrealm\agent-infra2\src\guardrails\authority-policy.test.ts`, `C:\tiansrealm\agent-infra2\src\runtime\agent-registry.test.ts`, `C:\tiansrealm\agent-infra2\src\router\golden-routing.test.ts`, `C:\tiansrealm\agent-infra2\src\orchestrator\activities\direct-agent.ts`, `C:\tiansrealm\agent-infra2\src\orchestrator\interceptors.ts`, `C:\tiansrealm\agent-infra2\src\gateway\gateway-core.ts`, `C:\tiansrealm\agent-infra2\src\orchestrator\activities\plan-with-alpha.ts`, `C:\tiansrealm\agent-infra2\src\orchestrator\workflows\retry-stabilization.ts`, `C:\tiansrealm\agent-infra2\src\guardrails\activity-interceptor.test.ts`, `C:\tiansrealm\agent-infra2\src\orchestrator\activity-options.ts`, `C:\tiansrealm\agent-infra2\src\gateway\report-deliverables.ts`, `C:\tiansrealm\agent-infra2\src\gateway\report-deliverables.test.ts`, `C:\tiansrealm\agent-infra2\src\orchestrator\execution-contract.ts`, `C:\tiansrealm\agent-infra2\src\orchestrator\execution-contract.test.ts`, `C:\tiansrealm\agent-infra2\src\orchestrator\worker-startup.ts`, `C:\tiansrealm\agent-infra2\src\orchestrator\worker-startup.test.ts`, `C:\tiansrealm\agent-infra2\src\orchestrator\worker.ts`
- Durable report: `C:\tiansrealm\agent-library\general-library\planes\audit\reports\2026-04-05-fix-the-discord-pipeline-issue-and-reproduce-it.md`
- Plan: `C:\Users\tialin\.copilot\session-state\0306ab9d-cf26-4334-9cbe-44b40ca7cf75\plan.md` — updated during the session to track the Discord, report, and Temporal fixes
- Session summary: `C:\tiansrealm\agent-library\private-library\planes\memory\reports\session-summaries\session-2026-04-05-discord-pipeline-and-temporal-fix.md`

## Governance

- **Complexity:** complex
- **Skills used:** [routing-and-delegation, session-end, receive-feedback]
- **Principles/rules applied:** [alpha-only reviewed entrypoint, durable report rule, preserve policy context across boundaries, structured session-end summary requirement]
- **Challenges encountered:** [legacy-agent coupling, lost routing context across Temporal activity boundary, missing report artifact contract, local Temporal core stack not running]
- **Delegations:** none

## Self-Assessment

- **Went well:** Root causes were reproduced live instead of inferred from tests, and the final worker fix addressed service availability rather than only adding retries.
- **Uncertain:** Whether worker-only local Temporal bootstrap is the right long-term boundary or if similar behavior belongs in other local clients.
- **Patterns noticed:** The owner repeatedly corrected cases where a fix looked locally sufficient but still violated the higher-level contract (reviewed agent surface, required report artifact, structured session closeout).
- **Next time:** Treat `session end` as an automatic write/update of the summary artifact before any informal closeout message.

## Post-Session Review

Reviewed by:
1. kongming — pending
2. <agent-id> — pending
