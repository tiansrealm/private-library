#!/bin/bash
# Personal Library Migration Completion Script
# Handles: profile markdown stubs (prepend header + append source content),
#          missing profile markdowns, and all binary file copies
set -e

SRC="/c/tiansrealm/library/private-library"
DST="/c/tiansrealm/agent-library/private-library"

HEADER_PROFILE='---
DocType: Plane-Targeted Guide
IntentType: Advisory
TargetPlane: knowledge
InPlaneCategory: notes
AuthorityImpact: Informational
MutationBinding: NonBinding
CrossPlaneEffect: None
DocLifecycle: Active
DelegationSafe: false
Version: 1.0
---
'

HEADER_PLAN='---
DocType: Plane-Targeted Guide
IntentType: Procedural
TargetPlane: knowledge
InPlaneCategory: notes
AuthorityImpact: Informational
MutationBinding: NonBinding
CrossPlaneEffect: None
DocLifecycle: Active
DelegationSafe: false
Version: 1.0
---
'

HEADER_CHATLOG='---
DocType: Plane-Targeted Guide
IntentType: Reflective
TargetPlane: knowledge
InPlaneCategory: notes
AuthorityImpact: Informational
MutationBinding: NonBinding
CrossPlaneEffect: None
DocLifecycle: Record
DelegationSafe: true
Version: 1.0
---
'

# Helper: write md with header
write_md() {
    local src="$1" dst="$2" header="$3"
    mkdir -p "$(dirname "$dst")"
    printf '%s' "$header" > "$dst"
    cat "$src" >> "$dst"
    echo "WROTE: $dst"
}

# Helper: copy binary
copy_bin() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo "COPIED: $dst"
}

echo "=== Fixing profile markdown stubs (overwrite with full content) ==="

# Profile files (Advisory, DelegationSafe: false)
for profile in esther/profile.md new/profile.md snow/profile.md; do
    write_md "$SRC/knowledge/relationships/profiles/$profile" \
             "$DST/planes/knowledge/notes/relationships/profiles/$profile" \
             "$HEADER_PROFILE"
done

# Plan files (Procedural)
for plan in esther/plan.md snow/plan.md; do
    write_md "$SRC/knowledge/relationships/profiles/$plan" \
             "$DST/planes/knowledge/notes/relationships/profiles/$plan" \
             "$HEADER_PLAN"
done

# Chat log md files (Reflective, Record)
for chatlog in esther/chat-logs/2026-03-13.md snow/chat-logs/2026-03-09.md yuri/chat-logs/2026-03-12.md yuri/chat-logs/2026-03-12-more.md; do
    write_md "$SRC/knowledge/relationships/profiles/$chatlog" \
             "$DST/planes/knowledge/notes/relationships/profiles/$chatlog" \
             "$HEADER_CHATLOG"
done

echo "=== Writing remaining profile markdown files ==="

# Yimiwu profile
write_md "$SRC/knowledge/relationships/profiles/yimiwu/profile.md" \
         "$DST/planes/knowledge/notes/relationships/profiles/yimiwu/profile.md" \
         "$HEADER_PROFILE"

# Yuri profile
write_md "$SRC/knowledge/relationships/profiles/yuri/profile.md" \
         "$DST/planes/knowledge/notes/relationships/profiles/yuri/profile.md" \
         "$HEADER_PROFILE"

echo "=== Copying all binary/non-md files ==="

# .gitkeep files (already done in main migration)

# Images in jun-ge/5-step-chatting-framework/
for img in 5-stages-relationship-map.png flirting-escalation-examples.png icebreaking-chat-examples.png marriage-value-mindmap.png; do
    copy_bin "$SRC/knowledge/relationships/jun-ge/5-step-chatting-framework/$img" \
             "$DST/planes/knowledge/notes/relationships/jun-ge/5-step-chatting-framework/$img"
done

# Image in jun-ge/mindset/
copy_bin "$SRC/knowledge/relationships/jun-ge/mindset/attraction-quadrant-value-availability.png" \
         "$DST/planes/knowledge/notes/relationships/jun-ge/mindset/attraction-quadrant-value-availability.png"

# Transcript in shared case studies
copy_bin "$SRC/knowledge/relationships/jun-ge/shared case studies/03-16-2026-transcript.txt" \
         "$DST/planes/knowledge/notes/relationships/jun-ge/shared case studies/03-16-2026-transcript.txt"

# JPG images in shared case studies/03-16-2026/
for img in "$SRC/knowledge/relationships/jun-ge/shared case studies/03-16-2026/"*.jpg; do
    bn=$(basename "$img")
    copy_bin "$img" "$DST/planes/knowledge/notes/relationships/jun-ge/shared case studies/03-16-2026/$bn"
done

# Source files (docx, pdf) in jun-ge/source-files/
for dir in 10-ways-to-flirt 1000-chat-topics chat-insights confidence-cultivation high-eq-dating-strategies improve-eq top-tier-dating-knowledge; do
    for f in "$SRC/knowledge/relationships/jun-ge/source-files/$dir/"*; do
        bn=$(basename "$f")
        ext="${bn##*.}"
        case "$ext" in
            md) ;; # Already handled
            *) copy_bin "$f" "$DST/planes/knowledge/notes/relationships/jun-ge/source-files/$dir/$bn" ;;
        esac
    done
done

# Chat log text files in profiles/
for txt in \
    "profiles/afan/chat-logs/afan-wechat-history-2026-03-22.txt" \
    "profiles/aria/chat-logs/aria-wechat-history-3-11-2026.txt" \
    "profiles/esther/chat-logs/esther-wechat-history-2026-03-13.txt" \
    "profiles/new/chat-logs/new-wechat-history-2026-03-13.txt" \
    "profiles/snow/chat-logs/2026-03-22.txt" \
    "profiles/snow/chat-logs/snow-wechat-history-3-11-2026.txt" \
    "profiles/yimiwu/chat-logs/yimiwu-wechat-history-2026-03-15.txt" \
    "profiles/yimiwu/chat-logs/yimiwu-wechat-history-2026-03-16.txt" \
    "profiles/yimiwu/chat-logs/yimiwu-wechat-history-2026-03-17.txt" \
    "profiles/yimiwu/chat-logs/yimiwu-wechat-history-2026-03-18.txt" \
    "profiles/yuri/chat-logs/yuri-wechat-history-3-11-2026.txt"; do
    copy_bin "$SRC/knowledge/relationships/$txt" \
             "$DST/planes/knowledge/notes/relationships/$txt"
done

# Yuri chat-log PNG
copy_bin "$SRC/knowledge/relationships/profiles/yuri/chat-logs/2026-03-12.png" \
         "$DST/planes/knowledge/notes/relationships/profiles/yuri/chat-logs/2026-03-12.png"

echo ""
echo "=== Migration complete ==="
echo "Run: find $DST -type f | wc -l"
echo "to verify total file count."
