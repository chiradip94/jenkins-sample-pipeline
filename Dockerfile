FROM tomcat:latest
ARG TOMCAT_VERSION=tomcat-8.0-doc
ADD https://tomcat.apache.org/${TOMCAT_VERSION}/appdev/sample/sample.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh" "run"]