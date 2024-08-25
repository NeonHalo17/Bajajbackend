# Use an official Maven image as the base image
FROM maven:3.9.4-eclipse-temurin-21 AS build

# Set the working directory in the container
WORKDIR /bajaj

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
COPY --from=build /bajaj/target/bajaj-1.0-SNAPSHOT.jar /bajaj/bajaj.jar

# Run the JAR file
CMD ["java", "-jar", "/app/bajaj.jar"]
