FROM docker.io/openjdk:17-jdk-slim

WORKDIR /app

COPY target/delta-capita-test-0.0.1-SNAPSHOT.jar /app/delta-capita-test.jar

EXPOSE 8085

ENTRYPOINT ["java", "-jar", "delta-capita-test.jar"]