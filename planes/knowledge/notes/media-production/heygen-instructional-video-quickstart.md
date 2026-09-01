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

# HeyGen Instructional Video Quickstart

## Purpose

Validate a low-overhead instructional-video format before investing in a larger production or governance workflow. The Phase-0 target is a 60–90 second talking-head lesson that explains one concept and produces an uploadable MP4 using HeyGen as the only production tool.

The originating plan applies this workflow to AceTitan topics, while the production method is reusable for other instructional subjects. It classifies the work as **P1**, **complexity 2 (enablement)**, in the **Phase-0 feasibility** lifecycle stage.

This approach suits creators who:

- make instructional or educational YouTube videos;
- do not want to film themselves;
- want a simple presenter-led format; and
- prefer to prove that the teaching is useful before adding production complexity.

The core flow is:

> Idea → brief → script → avatar video → uploadable MP4

## Phase 0: One-tool stack

| Capability | Tool | Role |
|---|---|---|
| Presenter and production | HeyGen | Converts a script into an avatar-led video with synthesized voice, lip-sync, and a background scene. |

HeyGen replaces the initial need for a camera, microphone, lighting setup, on-camera presenter, and separate editing software. This keeps the feasibility test focused on explanation quality rather than production overhead.

## Feasibility run

| Step | Action | Suggested owner | Gate or constraint |
|---|---|---|---|
| 1 | Select one AceTitan topic and write a short brief. | Planner; the source plan suggested GPT-5.4. | Human review; cover no more than one concept. |
| 2 | Turn the brief into a 60–90 second script. | Builder; the source plan suggested Claude Sonnet 4.6. | Human review; use the script structure below. |
| 3 | Create and render the avatar video in HeyGen. | Owner | Requires external HeyGen access. |
| 4 | Export the MP4 and prepare a YouTube draft. | Owner | Prefer a 16:9 long-form layout. |

### Script structure

Keep the first script short and use four parts:

1. **Hook — 10–15 seconds:** state exactly what the viewer will understand.
2. **Core concept — 30–40 seconds:** explain the mechanism in plain language.
3. **Why it matters — 20–30 seconds:** connect the concept to a practical benefit or problem.
4. **Close — 5–10 seconds:** preview the next useful step or lesson.

An example topic from the source material is retrieval-augmented generation:

- open by promising a simple explanation of RAG and its effect on LLM accuracy;
- explain that the model retrieves relevant external documents before answering rather than relying only on training data;
- connect that retrieval to fewer hallucinations and greater control over the knowledge used; and
- close by previewing a simple implementation walkthrough.

### Build the video in HeyGen

1. Create a new video.
2. Choose an avatar.
3. Choose a voice.
4. Select a simple office or studio background.
5. Paste the script.
6. Generate the video.

The expected result is a fully rendered talking-head video with lip-synced narration and a clean background. No separate edit is required for the Phase-0 version.

### Export and prepare the upload

- Export as MP4.
- Use 16:9 at 1920×1080 when preparing a conventional YouTube video.
- Write a direct explanatory title, such as “What Is RAG? (Simple Explanation).”
- Use a suitable exported frame as the initial thumbnail; replace it later only if a dedicated thumbnail becomes worthwhile.

## Phase-0 success and verification

The feasibility run is complete when:

1. at least one HeyGen-rendered instructional MP4 exists for the selected AceTitan topic; and
2. at least one YouTube draft upload has been prepared from that render.

Before upload, confirm:

- the script is no longer than 90 seconds;
- the hook arrives within the first 10 seconds;
- the video teaches only one concept;
- the export uses the intended aspect ratio; and
- the result prioritizes content clarity over production polish.

## Optional growth path

Stay with the single-tool workflow for the first three to five videos. Add tools only when a recurring production need justifies them.

| Phase | Stack | Added capability |
|---|---|---|
| 0 | HeyGen | Script-to-presenter video. |
| 1 | HeyGen + Pika 2.5 | Three-to-five-second concept clips or visual B-roll generated from prompts. |
| 2 | HeyGen + Pika 2.5 + Runway Gen-4 | Text overlays, cutaways, intro/outro, transitions, and assembly of presenter and concept clips. |

Pika can illustrate an abstract line with a short prompt-driven clip, such as an AI system pulling documents into memory nodes. Runway becomes useful when those clips need sequencing and polish.

## When to institutionalize the workflow

Move from feasibility into a governed Phase-1 workflow only after:

- at least three HeyGen instructional videos have been produced from AceTitan topics; and
- at least one video has been approved for public or internal distribution.

At that point, restore the planned scaffolding, knowledge references, audit/reporting requirements, and a report-based completion gate.

During Phase 0, the following remain deliberately deferred:

- canonical scaffolding;
- documentation-first validation evidence;
- audit-report requirements;
- mandatory library-documentation updates beyond this approved consolidation; and
- final plan archival or movement.

The Phase-0 operating mode also omits execution packets, shell-driven production steps, and model-to-model handoff gates. Planning and script authoring support the brief-to-script flow; the owner performs the external HeyGen render and upload preparation.

## Provenance

This guide consolidates the durable content of:

| Inventory ID | Source path | SHA-256 |
|---|---|---|
| INV-0001 | `C:\tiansrealm\meta-lnfo\acetitan-heygen-plan-phase0-patch.md` | `45E9CAEC99C87617DDD1AF334BB04EDB0B3E7CC86873B5FCF965AB293FC9C1C2` |
| INV-0007 | `C:\tiansrealm\meta-lnfo\heygen-youtube-teaching-video-quickstart.md` | `AC6512D64F19213E9A9A918E527B67E2077302CE154FCFA52F77EBE2215632F4` |
