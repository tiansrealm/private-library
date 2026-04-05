---
DocType: Plane-Targeted Guide
IntentType: Normative
TargetPlane: audit
InPlaneCategory: Schemas
AuthorityImpact: ObservabilityOnly
MutationBinding: RuntimeEnforced
CrossPlaneEffect: RepoState
DocLifecycle: Record
DelegationSafe: true
Version: 1.0
---

# AUDIT_SCHEMA_TEMPLATE

## Events to capture

## Required fields
- correlationId
- actor
- plane
- action
- result

## Storage
- append-only
