---
DocType: Plane-Targeted Guide
IntentType: Normative
TargetPlane: governance
InPlaneCategory: Rules
AuthorityImpact: RestrictsMutation
MutationBinding: RuntimeEnforced
CrossPlaneEffect: None
DelegationSafe: false
Version: 1.0
---

# DOC_HEADER_LINTER_RULES

## Rule
Any document entering the library MUST contain a valid YAML header.

## Required fields
- DocType
- IntentType
- TargetPlane
- InPlaneCategory
- AuthorityImpact
- MutationBinding
- CrossPlaneEffect
- DocLifecycle
- DelegationSafe
- Version

## Validity constraints
- All enum values MUST come from the template.
- If TargetPlane is `knowledge`, then MutationBinding MUST be `NonBinding`.
- DocLifecycle MUST be one of: Active, Superseded, Archived, Record.
- If `DocLifecycle: Record` → MutationBinding MUST be `NonBinding` AND AuthorityImpact MUST be `Informational`.
- If `DocLifecycle: Superseded` → MUST include `SupersededBy` field.
- If `MutationBinding: RuntimeEnforced` → DocLifecycle MUST NOT be `Record`.

## Action on failure
- Missing/invalid header → REJECT placement.
