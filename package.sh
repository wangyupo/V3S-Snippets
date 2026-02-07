#!/bin/sh
set -e

# 进入脚本所在目录，避免在错误目录执行
cd "$(dirname "$0")"

# 检查依赖
command -v npm >/dev/null 2>&1  || { echo "错误: 未找到 npm"; exit 1; }
command -v node >/dev/null 2>&1  || { echo "错误: 未找到 node"; exit 1; }
command -v vsce >/dev/null 2>&1  || { echo "错误: 未找到 vsce，请执行 npm i -g @vscode/vsce"; exit 1; }
[ -f package.json ] || { echo "错误: 未找到 package.json"; exit 1; }

echo "→ 更新版本号 (patch)..."
npm version patch --no-git-tag-version

VERSION=$(node -p "require('./package.json').version")
NAME=$(node -p "require('./package.json').name")
echo "→ 新版本: $NAME@$VERSION"

echo "→ 打包中..."
vsce package

echo "✓ 打包完成: $NAME-$VERSION.vsix"
