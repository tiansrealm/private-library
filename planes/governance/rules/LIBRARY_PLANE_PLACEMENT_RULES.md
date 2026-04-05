---
DocType: Plane-Targeted Guide
IntentType: Normative
TargetPlane: governance
InPlaneCategory: Rules
AuthorityImpact: DefinesPolicy
MutationBinding: RuntimeEnforced
CrossPlaneEffect: None
DelegationSafe: false
Version: 1.0
---

# LIBRARY_PLANE_PLACEMENT_RULES

## Rule
Placement is deterministic based on the header.

## Reject conditions (MUST reject)
- Header missing
- Any required field missing (including DocLifecycle)
- Any enum value invalid
- TargetPlane = knowledge AND MutationBinding != NonBinding
- TargetPlane folder does not match TargetPlane header
- Category folder does not match InPlaneCategory header
- DocLifecycle = Record AND MutationBinding != NonBinding
- DocLifecycle = Record AND AuthorityImpact != Informational
- DocLifecycle = Superseded AND SupersededBy field missing
- MutationBinding = RuntimeEnforced AND DocLifecycle = Record

## Knowledge plane acceptance
Knowledge plane ACCEPTS ONLY:
- IntentType: Advisory or Reflective
- AuthorityImpact: Informational
- MutationBinding: NonBinding

## Governance rule acceptance (binding)
Governance/Rules is for runtime-enforced policies only.

## DocLifecycle field
Valid values: Active | Superseded | Archived | Record
- **Active**: current, authoritative for its plane/category.
- **Superseded**: replaced by another doc. MUST include `SupersededBy` field.
- **Archived**: no longer used; kept for historical reference.
- **Record**: session summaries, logs, transcripts — NON-BINDING only.
