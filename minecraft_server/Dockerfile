FROM openjdk:17-alpine

RUN mkdir -p /server
RUN adduser -D notch
RUN chown notch /server
COPY server.properties /server
RUN chown notch /server/server.properties && chmod 0664 /server/server.properties
COPY eula.txt /server
RUN chown notch /server/eula.txt && chmod 0664 /server/eula.txt
USER notch

WORKDIR /server

COPY tmp/paperclip.jar .

ENTRYPOINT java -Xms1G -Xmx1G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paperclip.jar nogui
