# --- Stufe 1: Build-Umgebung ---
# Verwendet ein offizielles Maven-Image, um das Projekt zu bauen.
# Die Java-Version hier sollte mit der in Ihrer pom.xml übereinstimmen.
FROM maven:3.8.5-openjdk-17 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

# Baut die Anwendung und erzeugt die .jar-Datei, Tests werden übersprungen.
RUN mvn package -DskipTests

# --- Stufe 2: Finale Laufzeit-Umgebung ---
# Beginnt mit einem sauberen, minimalen Image für die Laufzeit.
FROM registry.access.redhat.com/ubi8/ubi-minimal:8.5

LABEL BASE_IMAGE="registry.access.redhat.com/ubi8/ubi-minimal:8.5"
LABEL JAVA_VERSION="17"

RUN microdnf install --nodocs java-17-openjdk-headless && microdnf clean all

WORKDIR /work/
# Kopiert nur die gebaute .jar-Datei aus der "builder"-Stufe.
COPY --from=builder /app/target/*.jar /work/application.jar

EXPOSE 8080
CMD ["java", "-jar", "application.jar"]