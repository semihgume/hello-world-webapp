FROM tomcat:latest

EXPOSE 8080

COPY target/hello-world-app.war /usr/local/tomcat/webapps/
