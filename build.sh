#!/usr/bin/env bash

TS=$(date +%s)
SOURCE=$(dirname $0)
SOURCE=$(realpath $SOURCE)
TARGET=paroisse

read TODELETE << EOF
COPYING
CREDITS
README
VERSION
build.sh
EOF

pushd $SOURCE/.. 2>&1 1>/dev/null

# copy directory
[[ $# -gt 0 ]] && BASE_DIR=$1 || BASE_DIR=$TARGET-v$TS
if [[ -d $BASE_DIR ]]; then
  echo "Directory $BASE_DIR already exist!" >&2
  exit 2
fi
mkdir $BASE_DIR

# copying the files
cp -R $SOURCE/* $BASE_DIR
cd $BASE_DIR

# deleting git files
rm -rf .gi*
for file in $TODELETE; do
  rm $file 2>/dev/null
done

# done!
echo
echo "Directory build and available as $BASE_DIR."
echo "Be happy. :)"
echo

popd
