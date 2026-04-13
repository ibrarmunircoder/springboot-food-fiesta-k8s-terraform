FROM eclipse-temurin:21-jre-alpine

ENV DOCKERIZE_VERSION=v0.9.3

RUN apk update --no-cache \
    && apk add --no-cache wget openssl \
    && wget -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xzf - -C /usr/local/bin \
    && apk del wget

WORKDIR /app

# Create a non-root user for security
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copy the jar and entrypoint script from the build stage
COPY target/*.jar app.jar

USER spring:spring

# Expose the application port
EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
