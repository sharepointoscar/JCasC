FROM jenkins:2.32.3

#perform tasks as root
USER root
RUN apt-get update && \
  apt-get install -y python python-dev python-distribute python-pip && \
  apt-get install curl -y && \
  curl -sSL https://get.docker.com/ | sh && \
  pip install docker-compose && \
  apt-get -y install sudo

# add jenkins to the docker group
RUN sudo usermod -aG docker jenkins
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

#drop back to the regular jenkins user - good practice
USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
