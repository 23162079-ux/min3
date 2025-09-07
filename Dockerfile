# ----- Stage 1: Build WAR với Maven -----
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -q -DskipTests package

# ----- Stage 2: Chạy trên Tomcat 10.1 -----
FROM tomcat:10.1-jdk21

# Xóa webapp mẫu để dùng ROOT của mình
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy app thành ROOT.war để chạy tại "/"
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Render yêu cầu service LISTEN trên $PORT (mặc định 10000)
ENV PORT=10000
EXPOSE 10000

# Đổi cổng Connector của Tomcat = $PORT rồi chạy
CMD ["sh","-c","sed -i \"s/port=\\\"8080\\\"/port=\\\"$PORT\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
