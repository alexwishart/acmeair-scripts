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
# Script to run the AcmeAir JMeter driver, suitable for the Node.js or Swift implementations.
# Requires some minor modifications I made to the script (parameterization of some hard-coded
# values) and the sample system.properties and user.properties files.
#
# These are provided in my fork of the driver:
#
# https://github.com/djones6/acmeair-driver.git
#

# Customize this line to the location of the driver
DRIVER_LOCATION="$HOME/acmeair/acmeair-driver"

# Customize NUMA affinity used for jmeter process (or remove if you don't want it)
DRIVER_AFFINITY="numactl --cpunodebind=1 --membind=1"

SCRIPT_DIR="${DRIVER_LOCATION}/acmeair-jmeter/scripts"
${DRIVER_AFFINITY} jmeter -n -t ${SCRIPT_DIR}/AcmeAir.jmx -S ${SCRIPT_DIR}/system.properties -q ${SCRIPT_DIR}/user.properties -j AcmeAir1.log -l AcmeAir1.jtl

