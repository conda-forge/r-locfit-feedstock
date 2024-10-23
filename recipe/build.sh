#!/bin/bash
set -x

## manual fix for https://github.com/conda-forge/r-base-feedstock/issues/349
if [[ "$target_platform" == "linux-aarch64" || "$target_platform" == "linux-ppc64le" || "$target_platform" == "osx-arm64" ]]; then
    if [[ "$build_platform" != "$target_platform" ]]; then
        MAKECONF="${BUILD_PREFIX}/lib/R/etc/Makeconf"
    else
        MAKECONF="${PREFIX}/lib/R/etc/Makeconf"
    fi

    # capture CC and CFLAGS entries
    CC_VALUE=$(sed -n 's/^CC = \(.*\)/\1/p' "${MAKECONF}")
    CFLAGS_VALUE=$(sed -n 's/^CFLAGS = \(.*\)/\1/p' "${MAKECONF}")
    
    # insert into CC17 and C17FLAGS definitions
    sed -i "s|^CC17 =.*|CC17 = $CC_VALUE -std=gnu17|" "${MAKECONF}"
    sed -i "s|^C17FLAGS =.*|C17FLAGS = $CFLAGS_VALUE|" "${MAKECONF}"

    # debug
    cat ${MAKECONF}
fi

export DISABLE_AUTOBREW=1

# shellcheck disable=SC2086
${R} CMD INSTALL --build . ${R_ARGS}
