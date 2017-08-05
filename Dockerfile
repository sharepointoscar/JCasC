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
  curl -L https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip -o /tmp/packer.zip; unzip /tmp/packer.zip -d /usr/local/bin
  #sudo echo "deb http://download.virtualbox.org/virtualbox/debian jessie contrib" >> /etc/apt/sources.list && \
  #wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - && \
  #wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - && \
  #wget -q http://download.virtualbox.org/virtualbox/debian/sun_vbox.asc -O- | sudo apt-key add - && \
  #sudo apt-get update -y; sudo apt-get install -y virtualbox-5.1 dkms


# add jenkins to the docker group
RUN sudo usermod -aG docker jenkins
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

#drop back to the regular jenkins user - good practice
USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
