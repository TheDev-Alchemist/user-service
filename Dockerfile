# 1. Build stage
FROM maven:3.9.3-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests -Dproject.build.sourceEncoding=UTF-8

# 2. Runtime stage
FROM eclipse-temurin:11-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENV SPRING_PROFILES_ACTIVE=docker
ENV SERVER_PORT=8081
EXPOSE 8081
ENTRYPOINT ["java", "-Dspring.profiles.active=docker", "-Dserver.port=8081", "-jar", "app.jar"]