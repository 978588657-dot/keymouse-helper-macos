#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v cargo >/dev/null 2>&1; then
  echo "缺少 Rust。请先访问 https://rustup.rs 安装。"
  read -r -p "按回车退出…"
  exit 1
fi

if command -v bun >/dev/null 2>&1; then
  bun install
  bun run tauri build
elif command -v npm >/dev/null 2>&1; then
  npm ci
  npm run tauri -- build
else
  echo "缺少 Bun 或 Node.js 18+。"
  read -r -p "按回车退出…"
  exit 1
fi

echo
echo "构建完成。请查看 src-tauri/target/release/bundle/。"
open "src-tauri/target/release/bundle" 2>/dev/null || true
read -r -p "按回车退出…"
