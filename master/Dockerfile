#FROM jenkinsxio/jenkinsx:latest
FROM praqma/jenkins4casc:1.3-latest

COPY plugins.txt /usr/share/jenkins/my-plugins.txt

ARG JAVA_OPTS

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/my-plugins.txt
