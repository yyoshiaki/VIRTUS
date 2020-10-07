#!/bin/sh

samtools view -h ${1} | \
grep -v "AAAAAAAAAAAAAAAAAAAA" | grep -v "TTTTTTTTTTTTTTTTTTTT" | grep -v "TGTGTGTGTGTGTGTGTGTGTGTGTGTGTGTG" | \
samtools view -bS - 