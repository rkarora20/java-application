#e the official OpenJDK base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file from the target directory to the container
COPY target/spring-boot-demo-0.0.1-SNAPSHOT.jar /app/spring-boot-demo.jar

# Expose the port the app runs on
EXPOSE 9090

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "spring-boot-demo.jar"]

