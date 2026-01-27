#!/bin/sh

echo "更新版本号..."
npm version patch --no-git-tag-version

VERSION=$(node -p "require('./package.json').version")
echo "新版本: $VERSION"

echo "打包中..."
vsce package

echo "打包完成！生成: v3s-snippets-$VERSION.vsix"