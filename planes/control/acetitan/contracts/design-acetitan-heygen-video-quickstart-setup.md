# Design: AceTitan HeyGen Video Quickstart Setup

| Field | Value |
|---|---|
| Status | DRAFT / PLANNING ONLY |
| Date | 2026-04-09 |
| Project | AceTitan |
| Complexity | **2 (ENABLEMENT)** |
| Lifecycle Phase | **Phase-0 Feasibility** |
| Plan Link | `C:\tiansrealm\agent-library\private-library\planes\control\acetitan\plans\active\acetitan-heygen-video-quickstart-setup.md` |
| Source Guide | `C:\tiansrealm\agent-library\general-library\planes\knowledge\distilled\patterns\heygen-youtube-teaching-quickstart.md` |
| Legacy Note | Old `work-library` planning artifacts are superseded by these `private-library` targets |

## Objective

Create and validate a minimal HeyGen instructional-video production flow for AceTitan topics that converts a brief into a 60-90 second talking-head video suitable for YouTube upload, using the fewest tools possible.

Success in this phase is defined by producing HeyGen-rendered MP4 output and a prepared YouTube draft, not by documentation completeness.

## Planning Scope

### In scope
- One-topic AceTitan feasibility run
- Brief creation for a single instructional topic
- One 60-90 second HeyGen-ready script
- Owner-performed HeyGen render
- Owner-performed YouTube draft preparation
- Revised private-library control-plane planning artifacts
- Phase-1 migration criteria and deferred institutionalization references

### Out of scope for Phase-0
- Canonical control/knowledge/audit scaffolding
- Audit-plane report delivery
- Execution packets
- shell.agent filesystem-command work
- GPT↔Claude human handoff gates as a protocol requirement
- Project-doc rollout and library knowledge canonicalization
- Git move/finalization work
- Public release approval

## Canonical Artifact Locations

### Control-plane artifacts
- Plan: `C:\tiansrealm\agent-library\private-library\planes\control\acetitan\plans\active\acetitan-heygen-video-quickstart-setup.md`
- Design: `C:\tiansrealm\agent-library\private-library\planes\control\acetitan\contracts\design-acetitan-heygen-video-quickstart-setup.md`

### Phase-0 execution outputs
- Feasibility brief: owner-approved working output for one AceTitan topic
- Feasibility script: owner-approved 60-90 second instructional script
- Rendered output: at least one HeyGen-generated MP4
- Distribution prep: at least one YouTube draft upload prepared from the render

### Deferred Phase-1 private-library references
- Knowledge note: `C:\tiansrealm\agent-library\private-library\planes\knowledge\acetitan\notes\heygen-video-production-reference.md`
- Knowledge catalog: `C:\tiansrealm\agent-library\private-library\planes\knowledge\acetitan\catalogs\content-asset-map.md`
- Audit report: `C:\tiansrealm\agent-library\private-library\planes\audit\acetitan\reports\2026-04-09-heygen-video-quickstart-setup.md`

## Phase-0 Component Model

| Component | Type | Responsibility |
|---|---|---|
| AceTitan topic brief | Planning/runtime input | Constrains the feasibility run to one concept |
| 60-90s script | Working content artifact | Provides the exact narration basis for the HeyGen render |
| HeyGen render | Owner external action | Produces the feasibility MP4 |
| YouTube draft | Owner external action | Confirms the render can reach upload-ready state |
| Plan + design | Control-plane planning artifacts | Define the approved Phase-0 feasibility contract |
| Deferred knowledge/audit refs | Phase-1 references | Re-activate only after migration criteria are met |

## Interface Definitions

```ts
interface Phase0InstructionVideoBrief {
  topic: string;
  audience: string;
  singleConcept: string;
  hookAngle: string;
  keyPoints: string[];
  callToAction: string;
}

interface Phase0InstructionVideoScript {
  title: string;
  targetDurationSec: 60 | 75 | 90;
  hook: string;
  teachingBody: string[];
  close: string;
  estimatedWordCount: number;
}

interface Phase0FeasibilityOutcome {
  renderedMp4Count: number;
  youtubeDraftPreparedCount: number;
  ownerPerformedRender: true;
  ownerPerformedUploadPrep: true;
}
```

## Data Flow

```text
AceTitan topic
    ↓
Short brief
    ↓
60-90s script
    ↓
OWNER renders in HeyGen
    ↓
Rendered MP4
    ↓
OWNER prepares YouTube draft
    ↓
Phase-0 feasibility proven
    ↓
If >= 3 videos and one approved → migrate to Phase-1 institutionalization
```

## Execution Protocol Note

> Phase-0 Override:
> For feasibility runs, disable audit-plane requirements, execution packets, shell.agent filesystem commands, and GPT↔Claude human handoff gates. Use planner/builder only for brief→script authoring. External render is owner-performed in HeyGen.

The retained `HUMAN GATE` checkpoints in the plan are owner content approvals, not model-switch protocol gates.

## Migration / Rollout Strategy

1. Run one minimal AceTitan feasibility pass:
   - select one topic
   - create one brief
   - produce one script
   - owner renders one video
   - owner prepares one YouTube draft
2. Repeat feasibility runs only as needed to validate usefulness.
3. Migrate to Phase-1 institutionalization only after:
   - `>= 3` HeyGen instructional videos have been produced from AceTitan topics
   - at least one video is approved for public or internal distribution
4. At Phase-1:
   - re-enable scaffolding
   - re-enable knowledge-plane references
   - re-enable audit reporting
   - restore completion gate: `report-written`

## Risks and Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Feasibility effort gets buried under governance work | Delayed learning | Keep Phase-0 limited to brief → script → owner render → draft |
| External HeyGen access is owner-only | AI cannot complete end-to-end independently | Explicitly assign render and upload-prep steps to OWNER |
| Early documentation hardens too soon | Wasted structure before workflow proves useful | Defer scaffolding, knowledge, and audit requirements to Phase-1 |
| Legacy work-library references remain in circulation | Path confusion | Mark old work-library plan/design as superseded by private-library targets |

## Approval Requirements

- This design is intentionally retained as a slim planning contract because the owner explicitly requested both a design and a plan, even though the work is now Complexity 2 / enablement.
- This document does **not** approve product execution by itself.
- Phase-0 execution may begin only after explicit owner approval of the revised plan/design.
- Phase-1 institutionalization remains blocked until migration criteria are met and a refreshed approval is issued.
