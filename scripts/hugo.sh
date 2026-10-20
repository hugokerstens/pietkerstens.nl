#!/usr/bin/env bash
set -euo pipefail
project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version="$(tr -d '\r\n' < "$project_root/.hugo-version")"
export HUGO_CACHEDIR="$project_root/.tools/cache"
case "$(uname -s)" in
  Linux) platform=linux ;;
  Darwin)
    cd "$project_root"
    command -v hugo >/dev/null || { echo "Install the site builder version $version on macOS first (https://gohugo.io/installation/macos/)." >&2; exit 1; }
    [[ "$(hugo version)" == "hugo v$version"* ]] || { echo "Install the pinned site builder version $version first." >&2; exit 1; }
    exec hugo "$@" ;;
  *) echo 'Use scripts/hugo.ps1 on Windows.' >&2; exit 1 ;;
esac
case "$(uname -m)" in x86_64|amd64) architecture=amd64 ;; aarch64|arm64) architecture=arm64 ;; *) echo 'Unsupported architecture.' >&2; exit 1 ;; esac
tool_directory="$project_root/.tools/hugo/$version-$platform-$architecture"
executable="$tool_directory/hugo"
if [[ ! -x "$executable" ]]; then
  mkdir -p "$tool_directory"
  archive_name="hugo_${version}_${platform}-${architecture}.tar.gz"
  expected="$(awk -v name="$archive_name" '$2 == name {print $1}' "$project_root/scripts/hugo-checksums.txt")"
  [[ -n "$expected" ]] || { echo 'Missing pinned checksum.' >&2; exit 1; }
  echo "Downloading site builder $version (first run only)..."
  curl --fail --location --retry 3 "https://github.com/gohugoio/hugo/releases/download/v$version/$archive_name" -o "$tool_directory/$archive_name"
  if command -v sha256sum >/dev/null; then
    actual="$(sha256sum "$tool_directory/$archive_name" | awk '{print $1}')"
  else
    actual="$(shasum -a 256 "$tool_directory/$archive_name" | awk '{print $1}')"
  fi
  [[ "$actual" == "$expected" ]] || { echo 'Site builder checksum verification failed.' >&2; exit 1; }
  tar -xzf "$tool_directory/$archive_name" -C "$tool_directory"
fi
cd "$project_root"
exec "$executable" "$@"
