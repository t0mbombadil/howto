#!/bin/bash

# Execute from root of repo
cd "$(git rev-parse --show-toplevel)"
docker build -f docker/Dockerfile -t sandbox-howto .
