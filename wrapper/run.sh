#!/bin/bash
set -xe

DIR_VIRTUS=$HOME/Programs/VIRTUS
DIR_INDEX_ROOT=$HOME/media32TB/bioinformatics/reference/VIRTUS_200803

python3 VIRTUS_wrapper.py input.csv \
    --VIRTUSDir $DIR_VIRTUS \
    --genomeDir_human $DIR_INDEX_ROOT/STAR_index_human \
    --genomeDir_virus $DIR_INDEX_ROOT/STAR_index_virus \
    --salmon_index_human $DIR_INDEX_ROOT/salmon_index_human \
    --nthreads=4