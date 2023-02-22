#!/bin/sh

cd infra
./deploy.sh
cd ..

cd minecraft_server
./deploy.sh
cd ..
