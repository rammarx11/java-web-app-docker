FROM tomcat:latest
# Dummy text to test 
COPY target/java-web-app*.war /usr/local/tomcat/webapps/java-web-app-docker0802.war
