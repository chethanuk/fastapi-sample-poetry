#!/bin/sh

set -e

CURRENT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
BASE_DIR="$(dirname "$CURRENT_DIR")"

echo $CURRENT_DIR
echo $BASE_DIR
cd $BASE_DIR

docker build --tag chethanuk/poetry:0.1 --file docker/Dockerfile . 
