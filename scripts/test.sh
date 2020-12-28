#!/bin/sh

set -e

CURRENT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
BASE_DIR="$(dirname "$CURRENT_DIR")"

echo "Run Code Coverage Tests"
coverage run --rcfile "${BASE_DIR}/pyproject.toml" -m pytest "${BASE_DIR}/tests" "$*"
coverage html --rcfile "${BASE_DIR}/pyproject.toml"

echo "Run Branch Coverage Tests"
coverage run --branch -p --omit=${BASE_DIR}/docker --rcfile  "${BASE_DIR}/pyproject.toml" -m pytest "${BASE_DIR}/tests" "$*"
coverage html --rcfile "${BASE_DIR}/pyproject.toml" --directory="${BASE_DIR}/htmlbranch" --title="Branch Coverage"