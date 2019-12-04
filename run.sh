#!/usr/bin/env bash

set -ex

cd "$( dirname "${BASH_SOURCE[0]}" )"
KITCHEN_PATH=${KITCHEN_PATH:-/opt/data-integration/kitchen.sh}

[ -f "${KITCHEN_PATH}" ] || {
  set +e
  echo "Invalid KITCHEN_PATH!" >&2
  echo "  KITCHEN_PATH='${KITCHEN_PATH}'" >&2
  exit 1
}

dir="$(pwd)/etl"

# Options:
#   -rep            = Repository name
#   -user           = Repository username
#   -pass           = Repository password
#   -job            = The name of the job to launch
#   -dir            = The directory (dont forget the leading /)
#   -file           = The filename (Job XML) to launch
#   -level          = The logging level (Basic, Detailed, Debug, Rowlevel, Error, Minimal, Nothing)
#   -logfile        = The logging file to write to
#   -listdir        = List the directories in the repository
#   -listjobs       = List the jobs in the specified directory
#   -listrep        = List the available repositories
#   -norep          = Do not log into the repository
#   -version        = show the version, revision and build date
#   -param          = Set a named parameter <NAME>=<VALUE>. For example -param:FILE=customers.csv
#   -listparam      = List information concerning the defined parameters in the specified job.
#   -export         = Exports all linked resources of the specified job. The argument is the name of a ZIP file.
#   -custom         = Set a custom plugin specific option as a String value in the job using <NAME>=<Value>, for example: -custom:COLOR=Red
#   -maxloglines    = The maximum number of log lines that are kept internally by Kettle. Set to 0 to keep all rows (default)
#   -maxlogtimeout  = The maximum age (in minutes) of a log line while being kept internally by Kettle. Set to 0 to keep all rows indefinitely (default)

${KITCHEN_PATH} \
  -rep=etl \
  -job=${JOB_KEY} \
  -level=Basic \
  -file="${JOB_FILE}" \
  -dir="${dir}/"
