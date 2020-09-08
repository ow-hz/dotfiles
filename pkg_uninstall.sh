#! /usr/bin/env bash

_package="$1"

while read _file
do
    if ! pkgutil --file-info "${_file}" | grep -E "^pkgid: " | grep -v "${_package}" > /dev/null; then
        rm -rf "${_file}" && printf "." || {
            printf "E"
            printf "Can not remove ${_file}\n" >> "uninstall_package.log"
        }
    fi
done < <(pkgutil --files "${_package}")
printf "\n"
pkgutil --forget "${_package}"
