#!/bin/bash

# Determine location of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

${SCRIPT_DIR}/mongo_ramdisk.sh stop
${SCRIPT_DIR}/mongo_ramdisk.sh start && ${SCRIPT_DIR}/loaddb-nodejs.sh

