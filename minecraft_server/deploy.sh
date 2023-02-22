#!/bin/sh

rm -rf tmp

mkdir tmp
cd tmp

paper_version='1.16.5'

# Fetch Paper Minecraft server from official website
LATEST_BUILD=$(curl -X GET "https://papermc.io/api/v2/projects/paper/versions/${paper_version}" -H  "accept: application/json" | jq '.builds[-1]')

curl -o paperclip.jar -X GET "https://papermc.io/api/v2/projects/paper/versions/${paper_version}/builds/${LATEST_BUILD}/downloads/paper-${paper_version}-${LATEST_BUILD}.jar" -H  "accept: application/java-archive" -JO

cd ..

docker build --tag minecraft_server:latest .

terraform apply -auto-approuve
