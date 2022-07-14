FROM tomcat:latest
ADD /workspace/webapp/target/webapp.jar /usr/local/tomcat/webapps
#COPY ./webapp.war /usr/local/tomcat/webapps
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
