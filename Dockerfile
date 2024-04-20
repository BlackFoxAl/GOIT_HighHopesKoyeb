# Gradle image for the build stage.
FROM gradle:jdk17-jammy as build-image

# Set the working directory.
WORKDIR /app
COPY . .
# Build the application.
RUN chmod +x gradlew && ./gradlew clean build

# Java image for the application to run in.
FROM openjdk:17-jdk-alpine

# Copy the jar file in and name it highhopes.jar.
COPY --from=build-image app/build/libs/*.jar highhopes.jar

# The command to run when the container starts.
ENTRYPOINT java -jar highhopes.jar --spring.profiles.active=prod
