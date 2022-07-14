FROM tomcat:latest
VOLUME /Workspace/webapp/target/webapp.jar:/.
COPY ./webapp.war /usr/local/tomcat/webapps
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
