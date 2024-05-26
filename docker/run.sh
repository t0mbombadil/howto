#!/bin/bash

CONFIG_DIR="$HOME/.howto/config"
docker run --read-only -v "$CONFIG_DIR:/nonexistent:rw" -e OPENAI_API_KEY=$OPENAI_API_KEY sandbox-howto $1 
