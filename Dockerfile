FROM jenkins/jenkins:lts

ENV JENKINS_REF /usr/share/jenkins/ref
ENV JAVA_OPTS -Dorg.eclipse.jetty.server.Request.maxFormContentSize=100000000 \
  -Dorg.apache.commons.jelly.tags.fmt.timeZone=America/Sao_Paulo \
  -Dhudson.diyChunking=false \
  -Djenkins.install.runSetupWizard=false

COPY jenkins-home/plugins.txt $JENKINS_REF/

WORKDIR /tmp

USER root

RUN curl -s https://download.docker.com/linux/static/stable/x86_64/docker-18.09.6.tgz > docker-18.09.6.tgz \
  && tar xzvf docker-18.09.6.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-18.09.6.tgz \
  && /usr/local/bin/plugins.sh $JENKINS_REF/plugins.txt
