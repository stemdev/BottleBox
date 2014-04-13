#!/bin/bash

# Start python with nohup
killall python3
nohup python3 ./src/server.py &

