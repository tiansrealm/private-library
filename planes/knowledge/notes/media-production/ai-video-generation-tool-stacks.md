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

# AI Video Generation Tool Stacks

## Purpose

Use specialized tools according to the kind of footage being produced rather than forcing one generator to handle every scene. This reference covers two distinct stacks:

1. photorealistic YouTube production; and
2. anime music videos generated without actor capture, motion transfer, or motion capture.

Tool capabilities change over time, so validate current product features and usage terms before starting a production.

## Photorealistic YouTube production

### Intended output

This stack supports photorealistic footage for:

- B-roll;
- product demonstrations;
- presenter or talking scenes;
- technology explainers; and
- long-form videos and Shorts.

### Responsibility split

| Production need | Tool | Primary reason |
|---|---|---|
| Script and planning | GPT or Claude | Develops the narrative and shot plan. |
| Human scenes | Kling 3.0 | Facial realism, lip-sync, micro-expressions, HDR lighting, and body movement. |
| Environments | Veo 3.1 | Cinematic landscapes, interiors, city scenes, and nature or drone-style shots. |
| Object motion | Luma Dream Machine | Physically plausible rotation, collision, and surface interaction. |
| Short-form effects | Pika 2.5 | Dissolves, morphs, and physics-style transformations. |
| Avatar presenter | HeyGen | Script-to-avatar presentation, lip-synced narration, and multilingual delivery without filming. |
| Assembly | Runway Gen-4 | Clip extension, sequencing, transitions, and timeline stitching. |
| Repurposing | OpusClip | Converts longer material into short-form clips. |

### Selection guidance

**Kling 3.0 — human presence**

Use for presenter scenes, simulated interview-style shots, and walk-and-talk sequences where facial and body realism matter.

**Veo 3.1 — environments**

Use for skyline shots, office interiors, city walk-ins, nature scenes, intros, and mid-roll establishing footage when cinematic composition matters.

**Luma Dream Machine — object motion**

Use for product spins, device demonstrations, collisions, and other shots where physical interaction is the main visual requirement.

**Pika 2.5 — short-form transformations**

Use for dissolves, object morphs, stylized transitions, Shorts, and TikTok-style effects.

**HeyGen — presenter replacement**

Use when a talking presenter is required but filming is not. It combines the avatar, narration, lip-sync, and multilingual delivery.

**Runway Gen-4 — assembly**

Use to extend generated clips, arrange them into a sequence, and smooth the transitions between independently generated assets.

**OpusClip — repurposing**

Use after the long-form edit when promising segments need to be converted into Shorts.

### Delivery notes

- Label realistic AI-generated footage when required by YouTube policy.
- Use 16:9 for conventional long-form videos.
- Use 9:16 for Shorts.

## Pure-latent anime music-video production

### Non-negotiable constraint

This pipeline assumes:

- no real-actor performance capture;
- no dance-footage upload;
- no motion transfer;
- no motion-capture or mocap mapping; and
- all character motion originates from prompt-driven latent inference.

The flow is:

> Idea → prompt → AI motion → scene → beat sync → final music video

### Responsibility split

| Generation need | Tool | Primary reason |
|---|---|---|
| Character identity | SDXL with anime LoRAs or Midjourney Niji | Creates consistent identity anchors for motion tools. |
| Primary motion | Seedance 2.0 | Prompt-driven choreography, identity locking, continuity, and camera-path inference without mocap. |
| Anime stylization | Vidu | Strong cel shading, anime depth palettes, expressive facial frames, and stable line weight. |
| Environments | Kling 3.0 in text-to-video/latent mode | Physically coherent wide environments, weather layers, lighting, and camera movement. |
| Beat synchronization | freebeat.ai | Detects BPM and song structure and aligns transitions to musical sections. |
| Final assembly | Runway Gen-4 | Extends, retimes, smooths, and stitches short independent clips. |

### Identity anchors

Anime motion tools may allow the character to morph between verse and chorus unless they receive consistent reference imagery. Before generating motion, create:

- a face reference;
- an outfit design;
- pose variants;
- a turnaround sheet;
- lighting variants; and
- costume variants.

SDXL with anime LoRAs or Midjourney Niji can produce these assets. Feed them downstream as identity anchors for Seedance and Vidu.

### Primary choreography with Seedance

Use Seedance as the primary motion generator when choreography must arise entirely from text or latent generation. Its useful capabilities include:

- identity lock;
- prompt-driven choreography;
- multi-shot continuity;
- camera-path inference; and
- native audio-and-video motion.

A prompt should specify the character, action, setting, atmosphere, and camera movement—for example, an idol performing slow hip-hop choreography under neon rain while the camera tracks from the side.

Do not substitute Kling motion transfer for this role: its reference-movement workflow would violate the pure-latent constraint.

### Closeups and expressive moments with Vidu

Seedance is the motion-coherence tool, but anime line fidelity can weaken in extreme closeups. Use Vidu when style fidelity matters more than complex movement, especially for:

- closeups;
- lip-sync moments;
- emotional chorus shots;
- blinks; and
- gesture beats.

### Wide environments with Kling latent mode

Kling remains useful if it is restricted to text-to-video generation rather than motion transfer or mocap mapping. Use it for:

- skyline flythroughs;
- hallway walk-ins;
- wide scenic stages;
- rain, fog, and other physics layers;
- camera continuity; and
- coherent environmental lighting.

This physical coherence can stabilize wide scenes that stylized generators may otherwise break.

### Beat mapping with freebeat.ai

Generative clips are time-agnostic, while music-video edits depend on musical structure. Use BPM and section detection to map shot types to the song, such as:

- a tracking shot during a verse;
- a closeup before a drop; and
- the strongest dance motion at the drop.

### Assembly with Runway

Seedance and Vidu produce short, independent clips. Use Runway Gen-4 for:

- clip extension;
- scene retiming;
- transition smoothing; and
- multi-shot stitching.

The completed pipeline is:

> Prompt → motion → style → beat sync → music video

### Compliance checklist

- Never use Kling motion transfer.
- Do not use filmed choreography, actor capture, or mocap.
- Confirm that all motion originates from prompts or latent generation.
- Use Seedance for choreography and continuity.
- Use Vidu for closeups and high-fidelity anime expression.

## Provenance

This reference consolidates the durable content of:

| Inventory ID | Source path | SHA-256 |
|---|---|---|
| INV-0046 | `C:\tiansrealm\meta-lnfo\to do\anime-ai-music-video-stack-explained.md` | `F709E29BCC3DEF1CA5BE637B56BE941A40498687788216BCE91BC42941CAB0CB` |
| INV-0048 | `C:\tiansrealm\meta-lnfo\to do\general-youtube-ai-video-stack-explained.md` | `EF2DC011BE19A19F3DB13592116CCEE4928E5A674DC701BCC8FFF39AB6DAEF45` |
