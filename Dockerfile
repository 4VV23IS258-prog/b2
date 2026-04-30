FROM eclipse-temurin:17-jdk-focal
WORKDIR /app
COPY . .
RUN javac Main.java
CMD ["java","Main"]