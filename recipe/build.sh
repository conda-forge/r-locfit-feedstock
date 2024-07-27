#!/bin/bash

set -x
echo $CC17
echo $CC

export CC17=$CC
export DISABLE_AUTOBREW=1

# shellcheck disable=SC2086
${R} CMD INSTALL --build . ${R_ARGS}
