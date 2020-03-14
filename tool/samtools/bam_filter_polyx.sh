#!/bin/sh

samtools view -h ${1} | \
grep -v "AAAAAAAAAAAAAAAAAAAA" | grep -v "TTTTTTTTTTTTTTTTTTTT" | \
samtools view -bS - 