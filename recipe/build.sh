#!/bin/bash

## manual fix for https://github.com/conda-forge/r-base-feedstock/issues/349
export CC17="${CC} -std=gnu17"
export CC17FLAGS="${CFLAGS}"

export DISABLE_AUTOBREW=1

# shellcheck disable=SC2086
${R} CMD INSTALL --build . ${R_ARGS}
