#!/bin/bash
# script to restart the lua service

set +v
kill -s SIGKILL $(pgrep -f "th multi-server.lua")
nohup th multi-server.lua >> logs/server.log 2>&1&
