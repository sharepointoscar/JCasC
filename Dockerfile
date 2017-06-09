FROM jenkins:latest
MAINTAINER Oscar Medina "me@sharepointoscar.com"

# perform tasks as root
# installs python, curl, docker-compose, sudo, docker-machine, Packer
USER root
RUN apt-get update && \
  apt-get install -y python python-dev python-distribute python-pip && \
  apt-get install curl -y && \
  curl -sSL https://get.docker.com/ | sh && \
  pip install docker-compose && \
  apt-get -y install sudo && \
  curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine && \
  chmod +x /tmp/docker-machine && \
  sudo cp /tmp/docker-machine /usr/local/bin/docker-machine && \
  curl -L https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip-`uname -s`-`uname -m` >/tmp/packer && \
  chmod +x /tmp/packer && \
  sudo cp /tmp/packer /usr/local/bin/packer

# add jenkins to the docker group
RUN sudo usermod -aG docker jenkins
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

#drop back to the regular jenkins user - good practice
USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
