#!/usr/bin/env sh

if [ -z "$1" ]; then
    echo "error: no name provided"
    exit 1
fi

if [ "$(uname)" = "Darwin" ]; then
    sed_i_flag='-i ""'
else
    sed_i_flag='-i'
fi

name=$(printf '%s\n' "$1" | sed 's/[\/&]/\\&/g')

mv include/myprog/myprog.h include/myprog/$name.h
sed $sed_i_flag "s/myprog/$name/g" include/myprog/$name.h

mv include/myprog include/$name

sed $sed_i_flag "s/myprog/$name/g" scripts/run.sh
sed $sed_i_flag "s/myprog/$name/g" src/main.c
sed $sed_i_flag "s/myprog/$name/g" .gitignore
sed $sed_i_flag "s/myprog/$name/g" build.ninja

if [ -f "myprog" ]; then
    mv "myprog" $name
fi
