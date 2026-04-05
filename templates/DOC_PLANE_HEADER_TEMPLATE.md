# DOC_PLANE_HEADER_TEMPLATE.md

Copy/paste this YAML header at the top of EVERY document in this library.

```yaml
---
DocType: Plane-Targeted Guide
IntentType: Normative | Advisory | Procedural | Reflective
TargetPlane: identity | governance | control | memory | execution | retry | audit | reflection | knowledge
InPlaneCategory: Principles | Conventions | Rules | Contracts | Policies | Playbooks | Schemas | Reports | Notes
AuthorityImpact: DefinesPolicy | GrantsCapability | RestrictsMutation | ExecutionWorkflow | ObservabilityOnly | Informational
MutationBinding: RuntimeEnforced | PlannerEnforced | ExecutorOnly | HumanApprovalRequired | NonBinding
CrossPlaneEffect: None | PlannerMemory | RuntimeCache | StrategicPlan | BootIdentity | RepoState
DocLifecycle: Active | Superseded | Archived | Record
DelegationSafe: true | false
Version: 2.0
---
```

Optional fields (recommended when `DocLifecycle: Superseded`):
```yaml
SupersededBy: <relative path to replacement doc>
Supersedes: <relative path to prior doc>
```

### DocLifecycle meanings
- **Active** — current, authoritative for its plane/category.
- **Superseded** — previously authoritative but replaced by another doc. MUST include `SupersededBy`.
- **Archived** — no longer used; kept only for historical reference.
- **Record** — session summaries, run logs, meeting notes, transcripts, post-hoc raw captures. MUST be `MutationBinding: NonBinding` and `AuthorityImpact: Informational`.

## Minimal examples

### Governance Rule (runtime-enforced)
```yaml
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
```

### Governance Contract (runtime authority model)
```yaml
---
DocType: Plane-Targeted Guide
IntentType: Normative
TargetPlane: governance
InPlaneCategory: Contracts
AuthorityImpact: RestrictsMutation
MutationBinding: RuntimeEnforced
CrossPlaneEffect: PlannerMemory
DocLifecycle: Active
DelegationSafe: false
Version: 1.0
---
```

### Execution Playbook (executor-only)
```yaml
---
DocType: Plane-Targeted Guide
IntentType: Procedural
TargetPlane: execution
InPlaneCategory: Playbooks
AuthorityImpact: ExecutionWorkflow
MutationBinding: ExecutorOnly
CrossPlaneEffect: RepoState
DocLifecycle: Active
DelegationSafe: true
Version: 1.0
---
```

### Knowledge Note (non-binding)
```yaml
---
DocType: Plane-Targeted Guide
IntentType: Advisory
TargetPlane: knowledge
InPlaneCategory: Notes
AuthorityImpact: Informational
MutationBinding: NonBinding
CrossPlaneEffect: None
DocLifecycle: Active
DelegationSafe: true
Version: 1.0
---
```

### Session Summary (record)
```yaml
---
DocType: Plane-Targeted Guide
IntentType: Reflective
TargetPlane: memory
InPlaneCategory: Reports
AuthorityImpact: Informational
MutationBinding: NonBinding
CrossPlaneEffect: None
DocLifecycle: Record
DelegationSafe: true
Version: 1.0
---
```
