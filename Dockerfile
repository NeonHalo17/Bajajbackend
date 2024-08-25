# Use an official Maven image as the base image
FROM maven:3.9.9-eclipse-temurin-21 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .
COPY src ./src

COPY . .

# Build the application
RUN mvn clean package

# Use an openjdk image to run the application
FROM eclipse-temurin:21-jre

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/bajaj-0.0.1-SNAPSHOT.jar /app/bajaj.jar

# Run the JAR file
CMD ["java", "-jar", "/app/bajaj.jar"]
