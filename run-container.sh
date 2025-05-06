#!/bin/bash
docker run -e LITELLM_SERVER=https://bearborg.berkeley.edu:4433 -e LITELLM_API_KEY=$2 -p $1:8888 rickmcgeer/jupyter-ai-2:latest