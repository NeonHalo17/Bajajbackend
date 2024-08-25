# Use an official Maven image with OpenJDK 21 as the build environment
FROM maven:3.9.4-eclipse-temurin-21 as build

RUN apt-get update && apt-get install -y maven

# Copy the pom.xml and download dependencies (use cache if unchanged)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the entire project and build it
COPY . .
RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK 21 image to run the application
FROM eclipse-temurin:21-jre

# Copy the JAR file from the build stage
COPY --from=build /target/bajaj-1.0-SNAPSHOT.jar bajaj.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "bajaj.jar"]
