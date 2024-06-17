# var definition
ROOT=$(pwd)
SOURCE_DIRECTORY=pages
BUILD_TARGET=hexo_deploy
TARGET_DIRECTORY=$ROOT/$BUILD_TARGET/source/_posts

cd $BUILD_TARGET
npm run build
