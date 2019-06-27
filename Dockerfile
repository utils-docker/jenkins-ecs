FROM jenkins/jenkins:lts                  

ENV JENKINS_REF /usr/share/jenkins/ref   

COPY jenkins-home/plugins.txt $JENKINS_REF/                                        
RUN /usr/local/bin/plugins.sh $JENKINS_REF/plugins.txt                             

ENV JAVA_OPTS -Dorg.eclipse.jetty.server.Request.maxFormContentSize=100000000 \
  -Dorg.apache.commons.jelly.tags.fmt.timeZone=America/Sao_Paulo \
  -Dhudson.diyChunking=false \
  -Djenkins.install.runSetupWizard=false
WORKDIR /tmp        

USER root           
RUN curl -s https://get.docker.com/builds/Linux/x86_64/docker-18.09.6.tgz > docker-18.09.6.tgz \
  && tar xzvf docker-18.09.6.tgz \    
  && mv docker/docker /usr/local/bin \   
&& rm -r docker docker-18.09.6.tgz
