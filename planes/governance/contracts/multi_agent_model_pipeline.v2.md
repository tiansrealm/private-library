---
DocType: Plane-Targeted Guide
IntentType: Normative
TargetPlane: governance
InPlaneCategory: Contracts
AuthorityImpact: RestrictsMutation
MutationBinding: RuntimeEnforced
CrossPlaneEffect: PlannerMemory
DelegationSafe: false
Version: 1.0
---

# Multi‑Agent Framework — Model Usage & Pipeline (Sonnet / Opus / GPT‑5.4)

## Model roles
- **Sonnet**: executor (implementation)
- **GPT‑5.4**: spec compiler (pseudocode → contracts/schemas)
- **Opus**: auditor (cross-plane contract verification)

## Pipeline
1) GPT‑5.4 compiles authority/lifecycle/mutation constraints into schemas/guards.
2) Sonnet implements worker logic strictly within those contracts.
3) Opus audits for drift (plane leakage, ownership collapse, lifecycle violations).
