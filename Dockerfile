# Build stage
FROM openjdk:17-oracle AS builder

WORKDIR /app
COPY . .
RUN chmod +x gradlew && ./gradlew build

# Run stage
FROM openjdk:17-oracle AS runner

WORKDIR /app
COPY --from=builder /app/build/libs/*.jar /app/highhopes.jar

CMD ["java", "-jar", "/app/highhopes.jar", "--spring.profiles.active=prod"]