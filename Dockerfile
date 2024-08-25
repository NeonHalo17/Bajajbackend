# Use an official Maven image with OpenJDK 21 as the build environment
FROM maven:3.9.4-eclipse-temurin-21 as build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and download dependencies (use cache if unchanged)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the entire project and build it
COPY . .
RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK 21 image to run the application
FROM eclipse-temurin:21-jre

# Set the working directory for the runtime
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/bajaj-1.0-SNAPSHOT.jar /app/app.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "/app/app.jar"]
