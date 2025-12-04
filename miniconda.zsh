#!/usr/bin/env sh
# This script enables miniconda if exist

MINICONDA_PATH=$HOME/miniconda3/etc/profile.d/conda.sh
test -f $MINICONDA_PATH && source $MINICONDA_PATH
