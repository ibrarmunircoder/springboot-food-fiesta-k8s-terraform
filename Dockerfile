FROM eclipse-temurin:21-jre-alpine

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
