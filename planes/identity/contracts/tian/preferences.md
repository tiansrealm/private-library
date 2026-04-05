---
DocType: Plane-Targeted Guide
IntentType: Advisory
TargetPlane: identity
InPlaneCategory: Contracts
AuthorityImpact: Informational
MutationBinding: HumanApprovalRequired
CrossPlaneEffect: BootIdentity
DocLifecycle: Active
DelegationSafe: false
Version: 1.0
---
# Preferences

## Communication

- Concise responses, no trailing summaries
- Always show bilingual (Chinese + English) when displaying or drafting chat messages
- Run as main-agent by default in this workspace
- Ack immediately when gateway/Discord processing will take >10 seconds

## Planning & Sessions

- Draft plans in `tiansrealm/plans/active/`, not internal plan locations
- Ask approach preferences before proposing plans for large tasks
- Update active plan file before session review for continuity
- Always run agent-improver session review at end of every session

## Testing

- Don't run full replay suite after every change
- Focus on failing replays individually

## Engineering

- Fix root causes; don't mask bugs by syncing from external data
- Raise errors on invalid states; never silently skip
- Avoid `node -e` with shell-unsafe characters (`!`, `!==`, `$`); write temp `.js` files instead
- Ask before proposing architectural changes

## POD Pricing

- Always include shipping + Etsy fees in pricing calculations
- Target ~$6.50 net profit per item

## AWBW / AlphaWars

- Ask user directly for AWBW rules/terrain info instead of searching online
- Ask before proposing changes to game rules/mechanics
- Verified rules reference: `projects/alphawars/docs/awbw-rules.md`

## VM & Training

- Never load full replay dataset into memory at once
- Use chunked disk-backed processing
- Cap workers at 3
- Match Python versions between local and VM environments
