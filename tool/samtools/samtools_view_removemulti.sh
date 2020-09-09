#!/bin/sh

samtools view -@ ${1} -f ${2} ${3} | \
grep -v "uT:A:3" | samtools view  -@ ${1} -bS -