---
DocType: Plane-Targeted Guide
IntentType: Normative
TargetPlane: governance
InPlaneCategory: Rules
AuthorityImpact: DefinesPolicy
MutationBinding: RuntimeEnforced
CrossPlaneEffect: PlannerMemory
DocLifecycle: Active
DelegationSafe: false
Version: 1.0
---

# DOC_LIFECYCLE_RULES

## Semantics

| DocLifecycle | Runtime Interpretation |
|-------------|------------------------|
| Active | Current authority |
| Superseded | Replaced — follow SupersededBy |
| Archived | Historical only |
| Record | Session/log — NEVER authority |

## Enforcement

Execution/Planner agents MUST:
- Ignore Superseded docs for decisions
- Ignore Archived docs unless explicitly requested
- NEVER derive mutation authority from Record docs

## Validation

- If `DocLifecycle: Record` → `MutationBinding` MUST be `NonBinding` AND `AuthorityImpact` MUST be `Informational`.
- If `DocLifecycle: Superseded` → MUST include `SupersededBy` field pointing to the replacement doc.
- If `MutationBinding: RuntimeEnforced` → `DocLifecycle` MUST NOT be `Record`.
