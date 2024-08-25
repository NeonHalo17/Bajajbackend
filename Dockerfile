# Use an official Maven image as the base image
FROM maven:3.8.6-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package

# Use an openjdk image to run the application
FROM openjdk:17-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/bajaj.jar /app/bajaj.jar

# Run the JAR file
CMD ["java", "-jar", "/app/bajaj.jar"]
