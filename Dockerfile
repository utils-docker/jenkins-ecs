FROM jenkins/jenkins:2.117-alpine

ENV JENKINS_REF /usr/share/jenkins/ref

COPY jenkins-home/plugins.txt $JENKINS_REF/
RUN /usr/local/bin/plugins.sh $JENKINS_REF/plugins.txt

ENV JAVA_OPTS -Dorg.eclipse.jetty.server.Request.maxFormContentSize=100000000 \
 			  -Dorg.apache.commons.jelly.tags.fmt.timeZone=America/Los_Angeles \
 			  -Dhudson.diyChunking=false \
 			  -Djenkins.install.runSetupWizard=false

COPY jenkins-home/init.groovy.d $JENKINS_REF/init.groovy.d/
