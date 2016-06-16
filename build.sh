#!/bin/bash

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"
docker build -t spinderella . 
