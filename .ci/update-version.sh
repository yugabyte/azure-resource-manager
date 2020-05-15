#!/usr/bin/env bash

set -o errexit -o pipefail

# Following file will modify to update YugabyteDB version
readonly TEMPLATE_FILE="yugabyte_deployment.json"
readonly README="README.md"

# version_gt compares the given two versions.
# It returns 0 exit code if the version1 is greater than version2.
function version_gt() {
  test "$(echo -e "$1\n$2" | sort -V | head -n 1)" != "$1"
}

# Verify number of arguments
if [[ $# -ne 1 ]]; then
  echo "No arguments supplied. Please provide release version" 1>&2
  echo "Terminating the script execution." 1>&2
  exit 1
fi

release_version="$1"
echo "Release Version - ${release_version}"

# Verify release version
if ! [[ "${release_version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Something wrong with the version. Release version format - *.*.*.*" 1>&2
  exit 1
fi

# Current Version in yugabyte_deployment.json
current_version="$(grep -A 2 "YBVersion\":" "${TEMPLATE_FILE}" | grep "defaultValue" | cut -d '"' -f 4)"
echo "Current Release Version - ${current_version}"

# Version comparison
if ! version_gt "${release_version}" "${current_version}" ; then
  echo "Release version is either older or equal to the current version: '${release_version}' <= '${current_version}'" 1>&2
  exit 1
fi

# Version will be updated at following location in the following files-
#  1. yugabyte_deployment.json"
#    1.1. "defaultValue": "2.1.2.0"
#  2. README.md
#    2.1. YBVersion='2.0.6.0'

echo "Updating..."

# Update Version in yugabyte_deployment.json
sed -i -E "/YBVersion\":/,+2 s/[0-9]+.[0-9]+.[0-9]+.[0-9]+/"${release_version}"/" "${TEMPLATE_FILE}"

# Update Version in README.md
sed -i -E "/YBVersion=/,+1 s/[0-9]+.[0-9]+.[0-9]+.[0-9]+/"${release_version}"/" "${README}"

echo "Completed"
