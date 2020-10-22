#!/bin/bash

set -eou pipefail

MU0_SRCS="utils/mu0_assembly.cpp utils/mu0_disassembly.cpp utils/mu0_simulate.cpp"

echo "Building MU0 utils" > /dev/stderr
g++ -o bin/assembler utils/assembler.cpp ${MU0_SRCS}
g++ -o bin/simulator utils/simulator.cpp ${MU0_SRCS}
g++ -o bin/disassembler utils/disassembler.cpp ${MU0_SRCS}
echo "  done" > /dev/stderr