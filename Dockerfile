FROM debian:stable AS build

ENV TEMPLATER_VERSION=5.0.0

WORKDIR /tmp
RUN apt-get update && apt-get install -y maven wget && \
    wget https://github.com/ngs-doo/TemplaterExamples/archive/v$TEMPLATER_VERSION.tar.gz -O source.tar.gz && \
    tar -xzf source.tar.gz && \
    mkdir /src && \
    cp -r /tmp/TemplaterExamples-$TEMPLATER_VERSION/Advanced/TemplaterServer/* /src && \
    cd /src && \
    mvn -f pom.xml clean package

FROM debian:stable

COPY --from=build /src/target/templater-server.jar /opt/templater/
COPY --from=build /src/templater.lic /opt/templater/

RUN apt update && apt install openjdk-11-jre-headless libreoffice-common libreoffice-java-common libreoffice-writer libreoffice-calc wget -yq

EXPOSE 7777

WORKDIR /opt/templater

ENTRYPOINT ["java", "-jar", "templater-server.jar", "-libreoffice=/usr/share/libreoffice"]
