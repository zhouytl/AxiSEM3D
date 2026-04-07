#!/usr/bin/env bash

set -euo pipefail

numdiff_executable="$1"
output_file="$2"
reference_file="$3"

$numdiff_executable -a 1e-6 -q -s ' \t\n:' $output_file $reference_file
