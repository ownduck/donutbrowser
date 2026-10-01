#!/usr/bin/env bash
# Clean development artifacts only.
set -e
cd "$(dirname "$0")"
rm -rf .next src-tauri/target/debug
