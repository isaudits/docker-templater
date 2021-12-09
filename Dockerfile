FROM debian:stable

RUN apt-get update && apt-get install -y openjdk-11-jre-headless libreoffice-common libreoffice-java-common libreoffice-writer libreoffice-calc wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV TEMPLATER_VERSION=6.1.0

WORKDIR /tmp

# RUN apt-get update && apt-get install -y maven && \
#     wget https://github.com/ngs-doo/TemplaterExamples/archive/v$TEMPLATER_VERSION.tar.gz -O source.tar.gz && \
#     tar -xzf source.tar.gz && \
#     mkdir /src && \
#     cp -r /tmp/TemplaterExamples-$TEMPLATER_VERSION/Advanced/TemplaterServer/* /src && \
#     cd /src && \
#     mvn clean package && \
#     mkdir -p /opt/templater/resources/templates && \
#     cp /src/templater.lic /opt/templater && \
#     cp /src/target/templater-server.jar /opt/templater && \
#     rm -r /tmp/* && \
#     rm -r /src && \
#     apt-get autoremove -y && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/ngs-doo/TemplaterExamples/archive/v$TEMPLATER_VERSION.tar.gz -O source.tar.gz && \
    wget https://github.com/ngs-doo/TemplaterExamples/releases/download/v$TEMPLATER_VERSION/templater-server.jar && \
    tar -xzf source.tar.gz && \
    mkdir /src && \
    cp -r /tmp/TemplaterExamples-$TEMPLATER_VERSION/Advanced/TemplaterServer/* /src && \
    cd /src && \
    mkdir -p /opt/templater/resources/templates && \
    cp /src/templater.lic /opt/templater && \
    cp /tmp/templater-server.jar /opt/templater && \
    rm -r /tmp/* && \
    rm -r /src

EXPOSE 7777

WORKDIR /opt/templater

ENTRYPOINT ["java", "-jar", "templater-server.jar", "-libreoffice=/usr/share/libreoffice", "-disable-exit"]


