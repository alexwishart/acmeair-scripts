#!/bin/bash

export DB_HOST=localhost
export DB_PORT=27017
export PORT=9080

cd ~/acmeair/acmeair-swift
exec .build/release/Acmeair

