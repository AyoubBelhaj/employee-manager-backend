# Use OpenJDK as the base image
FROM openjdk:17-jdk-slim AS build

WORKDIR /app
COPY . .

RUN ./mvnw clean package -DskipTests


# Use a smaller image to run the app
FROM openjdk:17-jre-slim
COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 8080
CMD ["java", "-jar", "/app/app.jar"]