#!/bin/bash

DB_HOST=localhost

cd ~/acmeair/acmeair-nodejs

# Enable caching
sed -i.bak -e's#\(.*"useFlightDataRelatedCaching" :\).*#\1 true, #' settings.json

# Configure database host
sed -i.bak -e"s#\(.*\"mongoHost\" :\).*#\1 \"${DB_HOST}\", #" settings.json

# Disable logging
sed -i.bak -e's#\(.*"loggerLevel" :\).*#\1 "WARN", #' settings.json
sed -i.bak -e's#\(.*"useDevLogger" :\).*#\1 false #' settings.json

echo "Resetting DB to clean state"
~/acmeair/acmeair-scripts/resetdb.sh

echo "Starting Node (caching) implementation"
exec node app.js

