#!/bin/bash

# var definition
ROOT=$(pwd)
SOURCE_DIRECTORY=pages
BUILD_TARGET=dist
TARGET_DIRECTORY=$ROOT/$BUILD_TARGET/source/_posts

cp .github/user/_config.yml $BUILD_TARGET/_config.yml
cp -r .github/user/themes/cactus/_config.yml $BUILD_TARGET/themes/cactus/_config.yml

# cp posts files
published_files={}
grep -rl 'published: "true"' ./pages --include=*.md >.temp
mapfile -t published_files <.temp
for file in "${published_files[@]}"; do
  # 提取不带路径的文件名
  filename=$(basename "$file")
  echo -e "\033[32mPUBLISHED\033[0m  $filename"

  # 构造目标文件的完整路径
  source_file="$ROOT/$SOURCE_DIRECTORY/$filename"
  target_file="$TARGET_DIRECTORY/$filename"

  # 复制文件
  cp "$source_file" "$target_file"
done
rm .temp

cd $ROOT
