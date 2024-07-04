#!/bin/bash

# var definition
ROOT=$(pwd)
SOURCE_DIRECTORY=pages
BUILD_TARGET=hexo_deploy
TARGET_DIRECTORY=$ROOT/$BUILD_TARGET/source/_posts

# create folder
git clone https://github.com/hexojs/hexo-starter.git $BUILD_TARGET
cd $BUILD_TARGET

# init hexo project & theme
npm i
git clone https://github.com/probberechts/hexo-theme-cactus.git themes/cactus

cd $ROOT
