# Start with a base image containing Java runtime
FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD

# build file copy
COPY pom.xml /build/
COPY src /build/src/

# work diractory
WORKDIR /build/

# maven packaging
RUN mvn package -DskipTests -Dspring.profiles.active=dev

FROM openjdk:8-jre-alpine

# work diractory
WORKDIR /app

# copy to java image
COPY --from=MAVEN_BUILD /build/target/demo-0.0.1-SNAPSHOT.jar /app/
ENTRYPOINT ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]
