# var definition
ROOT=$(pwd)
SOURCE_DIRECTORY=pages
BUILD_TARGET=dist
TARGET_DIRECTORY=$ROOT/$BUILD_TARGET/source/_posts

cd $BUILD_TARGET
npm run build
