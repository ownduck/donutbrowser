#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
bash ./build-dev-clean.sh
bash ./build-clean.sh
pnpm tauri build --no-bundle "$@"

rel=src-tauri/target/release
ver=$(node -p "require('./package.json').version")
dir=$rel/Donut-Portable
zip_name=Donut_${ver}_x64-portable.zip

rm -rf "$dir"
mkdir -p "$dir/licenses"
cp "$rel/donutbrowser.exe" "$dir/Donut.exe"
cp "$rel/donut-proxy.exe" "$dir/donut-proxy.exe"
cp "$rel/xray.exe" "$dir/xray.exe" 2>/dev/null \
  || cp src-tauri/binaries/xray-x86_64-pc-windows-msvc.exe "$dir/xray.exe"
cp src-tauri/binaries/xray-LICENSE.txt "$dir/licenses/Xray-core-LICENSE.txt" 2>/dev/null || true
: > "$dir/.portable"

rm -f "$rel/$zip_name"
(
  cd "$rel"
  powershell.exe -NoProfile -Command \
    "Compress-Archive -Path Donut-Portable -DestinationPath $zip_name -Force"
)

abs=$(cd "$rel" && pwd)
echo "ZIP: $abs/$zip_name"
read -r -p 'Press Enter to exit...'
