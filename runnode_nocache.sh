#!/bin/bash

DB_HOST=localhost

cd ~/acmeair/acmeair-nodejs

# Disable caching
sed -i -e's#\(.*"useFlightDataRelatedCaching" :\).*#\1 false, #' settings.json

# Configure database host
sed -i -e"s#\(.*\"mongoHost\" :\).*#\1 \"${DB_HOST}\", #" settings.json

# Disable logging
sed -i -e's#\(.*"loggerLevel" :\).*#\1 "WARN", #' settings.json
sed -i -e's#\(.*"useDevLogger" :\).*#\1 false #' settings.json

echo "Resetting DB to clean state"
ssh $DB_HOST -t ~/acmeair/acmeair-scripts/resetdb.sh

echo "Starting Node (no caching) implementation"
exec node app.js

