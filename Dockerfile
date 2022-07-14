FROM tomcat:latest
ADD /var/lib/jenkins/workspace/docker-build/webapp/target/webapp.war /usr/local/tomcat/webapps
#COPY ./webapp.war /usr/local/tomcat/webapps
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
