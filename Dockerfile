FROM openjdk:17-jdk-alpine AS builder

WORKDIR /app
COPY . .
RUN chmod +x gradlew && ./gradlew build

FROM openjdk:17-jdk-alpine AS runner

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar /app/highhopes.jar

CMD ["java", "-jar", "/app/highhopes.jar", "--spring.profiles.active=prod"]