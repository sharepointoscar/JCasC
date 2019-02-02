#FROM jenkinsxio/jenkinsx:latest
FROM praqma/jenkins4casc:1.3-latest
# perform tasks as root
# installs python, curl, docker-compose, sudo, docker-machine, Packer
#USER root
# RUN apt-get update && \
#   apt-get install -y python python-dev python-distribute python-pip && \
#   apt-get install curl -y && \
#   curl -sSL https://get.docker.com/ | sh && \
#   pip install docker-compose && \
#   apt-get -y install sudo && \
#   curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && \
#   chmod +x /tmp/docker-machine && \
#   sudo cp /tmp/docker-machine /usr/local/bin/docker-machine && \
#   curl -L https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip -o /tmp/packer.zip; unzip /tmp/packer.zip -d /usr/local/bin

  # RUN sudo echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" >> /etc/apt/sources.list && \
  # wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - && \
  # wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - && \
  # sudo apt-get update -y && \
  # sudo apt-get install -y virtualbox-5.2



# add jenkins to the docker group
#RUN sudo usermod -aG docker jenkins
#RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

#drop back to the regular jenkins user - good practice
#USER jenkins
#COPY jenkins.yaml /var/jenkins_home/jenkins.yaml


##### JENKINS SETUP. For alpha releases use the experimental update center
#ENV JENKINS_HOME /var/jenkins_home

COPY plugins.txt /usr/share/jenkins/my-plugins.txt
ARG JAVA_OPTS
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/my-plugins.txt
