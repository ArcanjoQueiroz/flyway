FROM gliderlabs/alpine:3.4

WORKDIR /flyway

ENV FLYWAY_VERSION=5.1.4 \
    WAIT_FOR_VERSION=v0.0.1 \
    MAVEN_REPO=http://central.maven.org/maven2

RUN apk upgrade --update

RUN apk add --no-cache bash

RUN apk-install openjdk8-jre ca-certificates wget \
  && wget "$MAVEN_REPO/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz" \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && mv flyway-${FLYWAY_VERSION}/* . \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && ln -s /flyway/flyway /usr/local/bin/flyway \
  && wget "https://github.com/ArcanjoQueiroz/wait-for/releases/download/${WAIT_FOR_VERSION}/wait-for-postgres" \
  && chmod u+x wait-for-postgres && mv wait-for-postgres /usr/local/bin/wait-for-postgres \
  && echo -ne "- with Flyway $FLYWAY_VERSION\n" >> /root/.built

CMD ["flyway", "--help"]
