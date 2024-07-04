#!/bin/bash

# var definition
ROOT=$(pwd)
SOURCE_DIRECTORY=pages
BUILD_TARGET=dist
TARGET_DIRECTORY=$ROOT/$BUILD_TARGET/source/_posts

# create folder
git clone https://github.com/hexojs/hexo-starter.git $BUILD_TARGET
cd $BUILD_TARGET

# init hexo project & theme
npm i
git clone https://github.com/eggyShrimp/cactus.git themes/cactus

cd $ROOT
