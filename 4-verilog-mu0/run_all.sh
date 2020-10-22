#!/bin/bash

# Build the MU0 utilities
./build_utils.sh

# Run all the test-cases for each variant
./run_all_testcases.sh delay0
./run_all_testcases.sh delay1