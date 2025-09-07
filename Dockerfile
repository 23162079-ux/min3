# Sử dụng image Tomcat chính thức
FROM tomcat:10-jdk21

# Xóa ứng dụng mặc định trong thư mục webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR từ target vào thư mục webapps của Tomcat
COPY target/web3-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Khởi chạy Tomcat
CMD ["catalina.sh", "run"]
