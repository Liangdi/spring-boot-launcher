

FROM docker.io/library/openjdk:17-alpine
MAINTAINER Liangdi <wu@liangdi.me>

WORKDIR /deploy/

# default config
ENV APP_PORT=8080
ENV JAR=application.jar
ENV JAVA_OPTS=
# expose port
EXPOSE $APP_PORT
ENTRYPOINT java $JAVA_OPTS -Dserver.port=$APP_PORT -jar /deploy/$JAR
