#!/usr/bin/env bash
# Clean production / release artifacts only.
set -e
cd "$(dirname "$0")"
rm -rf dist out build src-tauri/target/release
