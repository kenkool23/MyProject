FROM tomcat
COPY **/*.war /usr/local/tomcat
EXPOSE 8090
