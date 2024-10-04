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
eval sed $sed_i_flag "s/myprog/$name/g" include/myprog/$name.h

mv include/myprog include/$name

eval sed $sed_i_flag "s/myprog/$name/g" scripts/run.sh
eval sed $sed_i_flag "s/myprog/$name/g" src/main.c
eval sed $sed_i_flag "s/myprog/$name/g" .gitignore
eval sed $sed_i_flag "s/myprog/$name/g" build.ninja

if [ -f "myprog" ]; then
    mv "myprog" $name
fi
