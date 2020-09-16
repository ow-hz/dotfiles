#! /usr/bin/env bash


arr=()


for item in $(brew list)
do
    for dep in $(brew deps $item)
    do
        if [[ $dep == $1 ]]; then
            arr=("$item" "${arr[@]}")
        fi
    done
done


if [[ ${#arr[@]} -eq 0 ]]; then
    echo "No package deps on $1!"
else
    echo ${arr[@]}
fi

