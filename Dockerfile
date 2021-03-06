FROM tomcat:latest
ARG APP_TOMCAT_VERSION=tomcat-8.0-doc
ADD https://tomcat.apache.org/${APP_TOMCAT_VERSION}/appdev/sample/sample.war /usr/local/tomcat/webapps/
EXPOSE 8080
WORKDIR /usr/local/tomcat
CMD ["./bin/catalina.sh", "run"]