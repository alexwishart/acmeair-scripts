#!/bin/bash

./mongo_ramdisk.sh stop
./mongo_ramdisk.sh start && ./loaddb-nodejs.sh

