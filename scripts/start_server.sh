#!/bin/bash
cd /home/ubuntu/app
npm install
nohup node index.js > output.log 2>&1 &
