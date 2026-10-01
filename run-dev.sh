#!/usr/bin/env bash
# Avoid Tauri's 180s frontend wait being eaten by sidecar compile:
# build/copy sidecars first, then start tauri with Next-only beforeDevCommand.
set -e
cd "$(dirname "$0")"
bash ./build-clean.sh
pnpm copy-proxy-binary
pnpm tauri dev --config '{"build":{"beforeDevCommand":"pnpm next dev --turbopack -p 12341"}}' "$@"
