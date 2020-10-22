#!/bin/bash
set -eou pipefail

# First parameter to script determines the variant (e.g. delay0 or delay1)
VARIANT="$1"

# Use a wild-card to specifiy that every file with this pattern represents a testcase file
TESTCASES="test/0-assembly/*.asm.txt"

# Loop over every file matching the TESTCASES pattern
for i in ${TESTCASES} ; do
    # Extract just the testcase name from the filename. See `man basename` for what this command does.
    TESTNAME=$(basename ${i} .asm.txt)
    # Dispatch to the main test-case script
    ./run_one_testcase.sh ${VARIANT} ${TESTNAME}
done