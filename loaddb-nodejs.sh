#!/bin/bash
#
# Copyright IBM Corporation 2017
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# Script to populate ('load') an empty database with the AcmeAir data, ready to be
# driven using the acmeair-jmeter driver.  This will check that the value of
# MAX_DAYS_TO_SCHEDULE_FLIGHTS is at least 30, which is required by the JMeter
# driver (which will search for flights up to 30 days from today).
#
# Prereqs:
# - node and curl installed and on the path
# - https://github.com/acmeair/acmeair-nodejs.git checked out locally
# - ACMEAIR_NODEJS param (below) set to point to the location of acmeair-nodejs
#

ACMEAIR_NODEJS="$HOME/acmeair/acmeair-nodejs"

export PATH=/usr/local/bin:$PATH

cd $ACMEAIR_NODEJS
FLIGHTS_DAYS=`grep 'MAX_DAYS_TO_SCHEDULE_FLIGHTS' loader/loader-settings.json | sed -e's#.*: ##' -e's#,##'`
echo "Flight days = $FLIGHTS_DAYS"
if [ $FLIGHTS_DAYS -lt 30 ]; then
  echo "Error: MAX_DAYS_TO_SCHEDULE_FLIGHTS needs to be at least 30"
#  exit 1
fi
echo "Start app"
node app.js &
APP_PID=$!
sleep 1
curl http://localhost:9080/rest/api/loader/load
if [ $? -eq 0 ]; then
  echo "DB load successful"
else
  echo "DB failed to load"
fi
echo "Kill app"
kill $APP_PID
