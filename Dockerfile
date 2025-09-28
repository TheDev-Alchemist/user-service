# 1. Build stage
FROM maven:3.9.3-eclipse-temurin-11 AS build

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

WORKDIR /app
COPY pom.xml .
COPY src ./src

# Maven ile package, testleri atla
RUN mvn clean package -DskipTests -Dproject.build.sourceEncoding=UTF-8

# 2. Runtime stage
FROM eclipse-temurin:11-jre

WORKDIR /app

# Jar dosyasını build stage'den kopyala
COPY --from=build /app/target/*.jar app.jar

# Portu argümanla dışarıdan değiştirebilmek için ENV
ENV SERVER_PORT=8081
EXPOSE ${SERVER_PORT}

# Java opsiyonlarını da dışarıdan ayarlayabiliriz
ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar app.jar"]
