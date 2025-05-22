#!/bin/bash

echo "🧹 清理旧数据..."
rm -rf public public_en

echo "🌐 生成中文站..."
hexo clean
hexo generate

echo "🌐 生成英文站..."
hexo generate --config _config.yml,_config_en.yml

echo "📦 合并英文站内容..."
mkdir -p public/en
cp -r public_en/* public/en/
touch public/.nojekyll

echo "🚀 开始部署到 GitHub Pages..."
hexo deploy

echo "✅ 部署完成！现在访问："
echo "👉 中文站: https://lidyaqf.github.io/"
echo "👉 英文站: https://lidyaqf.github.io/en/"
