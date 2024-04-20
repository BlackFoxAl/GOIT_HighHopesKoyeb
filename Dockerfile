#Build stage
FROM gradle:latest AS builder
WORKDIR /app
COPY . .
RUN gradle build

# Package stage
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar /app/highhopes.jar

CMD ["java", "-jar", "/app/highhopes.jar", "--spring.profiles.active=prod"]