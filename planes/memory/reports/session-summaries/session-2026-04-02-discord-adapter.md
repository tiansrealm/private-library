# Session Summary: Discord Channel Adapter Build + Debug

**Date:** 2026-04-02 to 2026-04-03
**Agent:** Alpha
**Plan:** `agent-library/general-library/planes/control/playbooks/plan-discord-channel-adapter.md`

## What Was Done

### Plan Execution (Steps 1-8 COMPLETE, Step 9 partial)

**Step 1 — Gateway Core Extraction**
- Split `src/gateway/cli.ts` into `gateway-core.ts` (shared `processGatewayRequest()`), `gateway-types.ts`, and slim `cli.ts`
- All channel adapters now call the same gateway logic

**Step 2-5 — Discord Adapter Built**
- `src/channels/discord/` — 7 files: config, bot, message-translator, response-formatter, slash-commands, response-guardrails, index
- Discord.js v14, multi-guild support (3 servers), DM + group messages
- Slash commands: `/ask`, `/status`, `/approve` — registered to all guilds
- Config ported from old agent-infra's `~/.openclaw/openclaw.json`

**Step 6 — Guardrail-Aware Response Filtering**
- PII redaction in group channels, authority-based content filtering, per-user rate limiting

**Step 7 — Tests**
- 28/28 unit tests passing (message translation, chunking, URL suppression, PII redaction, authority filtering)

**Step 8 — Library Docs Updated**
- Architecture, feature catalog, code map all updated for Discord adapter

### Live Debugging Session

Bot connected successfully to all 3 guilds. Messages received and routed correctly (owner-dm → alpha, confidence 1.0). But agent responses were generic ("Ready. What do you need?") instead of answering the actual question.

**Root cause investigation chain:**
1. ~~Message not reaching model~~ — confirmed `request.summary` carries user text
2. ~~Stdin piping broken~~ — Windows `shell: true` + stdin don't mix well
3. ~~System prompt file not read~~ — `--system-prompt-file` flag confirmed working in isolation
4. **CLAUDE.md auto-discovery** — Claude CLI loads workspace CLAUDE.md, injecting its own system context that overrides/conflicts with our agent prompt
5. **Wrong CLI invocation pattern** — Our `oauth-dev` provider used `--system-prompt-file` + `--dangerously-skip-permissions` while old agent-infra uses `--append-system-prompt` + `--permission-mode bypassPermissions` + strips `ANTHROPIC_API_KEY` from env

**Fix applied:** Rewrote `oauth-dev-proxy-provider.ts` to match old infra's proven pattern:
- `--append-system-prompt` (not `--system-prompt-file`)
- `--permission-mode bypassPermissions` (not `--dangerously-skip-permissions`)  
- Strip `ANTHROPIC_API_KEY` from env so CLI uses stored OAuth creds
- `shell: true` required on Windows (claude is a .cmd wrapper)

### Agent Registry Migration

Agent workspace restructured (not by us):
- **Old:** `agents/<id>/AGENTS.md` + `SOUL.md` + `STATUS.md`
- **New:** `.github/agents/<id>.md` (single file per agent) + `agent-workspace/<id>/` (runtime state)

Updated `agent-registry.ts` to read from `.github/agents/*.md`, parse frontmatter + body, extract Agent ID and display name.

## Unresolved — Resume Here

1. **Restart both processes fresh** — Discord bot AND worker need restart to pick up all code changes (registry, prompt loader, provider)
2. **Verify agent answers questions** — The CLI invocation fix (`--append-system-prompt`) hasn't been tested with both processes running latest code
3. **Workflow ID collision** — Fixed with correlationId suffix but untested
4. **If `--append-system-prompt` still fails** — Consider switching to Foundry provider (proper API calls, no CLI middleman)

## Files Created/Modified

### New files (Discord adapter)
- `src/gateway/gateway-core.ts` — shared processGatewayRequest()
- `src/gateway/gateway-types.ts` — GatewayInput, GatewayResult, GatewayRejection
- `src/channels/discord/config.ts` — multi-guild config from env
- `src/channels/discord/bot.ts` — Discord.js client + event handlers
- `src/channels/discord/index.ts` — entry point
- `src/channels/discord/message-translator.ts` — Discord Message → GatewayInput
- `src/channels/discord/response-formatter.ts` — chunking, URL suppression
- `src/channels/discord/slash-commands.ts` — /ask, /status, /approve
- `src/channels/discord/response-guardrails.ts` — PII redaction, authority filter, rate limit
- 3 test files (28 test cases)

### Modified files
- `src/gateway/cli.ts` — slimmed to arg parsing + gateway-core call
- `src/runtime/providers/oauth-dev-proxy-provider.ts` — rewritten to match old infra CLI pattern
- `src/runtime/agent-registry.ts` — reads .github/agents/*.md instead of agents/*/
- `agent-infra2/package.json` — discord.js dep, start:discord script
- `agent-infra2/.env` — Discord bot token, guild IDs, owner ID
- 3 library docs updated

## Key Learning

The `claude --print` CLI is a **full agent**, not a transparent model API wrapper. It has its own system prompts, CLAUDE.md discovery, tool use, and session management. Using it as a model provider requires matching the exact invocation pattern that the old agent-infra proved works — specifically `--append-system-prompt` (not replace), `--permission-mode bypassPermissions`, and stripping API keys from env.
