#!/bin/bash

TEMPLATE=$(realpath  ./.markdown-template.md)

for i in *.md */*.md ; do
    n=$(basename $i .md);
    d=$(dirname $i)
    (cd $d && pandoc --highlight-style pygments  ${TEMPLATE} $n.md -o $n.pdf)
done