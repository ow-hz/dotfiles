#! /bin/bash


if [ $# -lt 1 ]; then
cat << EOF
docker tags -- list all tags for a Docker image on a remote registry.   

EXAMPLE:
    - list all tags for ubuntu:
        dockertags ubuntu

    - list all php tags containiing apache:
        dockertags php apache
EOF
fi

image="$1"
tags=`curl -fsSL https://registry.hub.docker.com/v1/repositories/${image}/tags | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'`


if [ -n "$2" ]; then
    tags=`echo "${tags}" | grep "$2"`
fi

echo "${tags}"
