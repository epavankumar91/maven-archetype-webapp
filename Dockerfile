from tomcat:8
copy target/*.war /usr/local/tomcat/webapps/
cmd ["catalina.sh", "run"]
