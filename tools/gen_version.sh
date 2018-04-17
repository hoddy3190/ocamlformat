#!/bin/bash

# usage: gen_version.sh <file> [<version>]

FILE="$1"

if [[ ! -z "$2" ]]; then
    # second arg passed when called from ocamlformat.opam
    VERSION="$2"
else
    # second arg omitted when called from src/jbuild
    if [[ ! "0.5" == "%%"*"%%" ]]; then
        # file has been watermarked when building distrib archive
        VERSION="0.5"
    else
        # file has not been watermarked when building in dev git tree
        VERSION=$(git describe --tags --dirty --always)
    fi
fi

echo "let version = \"$VERSION\"" > $FILE
