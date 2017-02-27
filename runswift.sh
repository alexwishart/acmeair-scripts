#!/bin/bash

export DB_HOST=localhost
export DB_PORT=27017
export PORT=9080

echo "Resetting DB to clean state"
ssh $DB_HOST -t "~/acmeair/acmeair-scripts/resetdb.sh"

echo "Starting Swift implementation"
cd ~/acmeair/acmeair-swift
exec .build/release/Server

