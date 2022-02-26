#!/bin/bash
#
# Check that the version is >= to version_min.

version_min="0.7.0"

if [[ $# -ne 0 ]]; then
    version_min=$1
fi

nvim_version() {
    if command -v nvim >/dev/null; then
        nvim --version | sed -rn 's/^NVIM v([0-9]+\.[0-9]+\.[0-9]+).*$/\1/p'
    else
        echo 0.0.0
    fi
}

version_cur=$(nvim_version)

if [[ "${version_cur}" == "0.0.0" ]]; then
    echo "error, nvim not installed"
    exit 1
elif [[ "${version_cur}" == "${version_min}" ]]; then
    echo "ok, nvim ${version_cur} == ${version_min}"
    exit 0
else
    lower=$(echo -e "${version_cur}\n${version_min}" | sort -V | head -1)
    if [[ "${lower}" != "${version_min}" ]]; then
        echo "error, nvim ${version_cur} < ${version_min}"
        exit 1
    else
        echo "ok, nvim ${version_cur} > ${version_min}"
        exit 0
    fi
fi
