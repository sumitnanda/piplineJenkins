FROM openjdk:17-oracle

# Use LABEL instead of deprecated MAINTAINER
LABEL org.opencontainers.image.authors="sumit@example.com"

EXPOSE 8682

COPY target/docker-jenkins-pipeline.jar docker-jenkins-pipeline.jar

ENTRYPOINT ["java", "-jar", "docker-jenkins-pipeline.jar"]