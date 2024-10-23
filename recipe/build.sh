#!/bin/bash

## manual fix for https://github.com/conda-forge/r-base-feedstock/issues/349
if [[ "$target_platform" == "linux-aarch64" || "$target_platform" == "linux-ppc64le" || "$target_platform" == "osx-arm64" ]]; then
    MAKECONF="$PREFIX/lib/R/etc/Makeconf"

    # piggyback CC17 and C17FLAGS on generic definition
    sed -i 's|^CC17 =.*|CC17 = $(CC) -std=gnu17|' "$MAKECONF"
    sed -i 's|^C17FLAGS =.*|C17FLAGS = $(CFLAGS)|' "$MAKECONF"
fi

export DISABLE_AUTOBREW=1

# shellcheck disable=SC2086
${R} CMD INSTALL --build . ${R_ARGS}
