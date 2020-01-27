#!/bin/bash
set -xe

fasterq-dump -e 8 ERR3240275
cwltool ../workflow/createindex.cwl ../workflow/createindex.job.yaml