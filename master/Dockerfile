#FROM jenkinsxio/jenkinsx:latest
FROM praqma/jenkins4casc:1.3-latest

# ARG GITHUB_CLIENT_ID
# ARG GITHUB_CLIENT_SECRETs

# ENV GITHUB_CLIENT_ID=$GITHUB_CLIENT_ID
# ENV GITHUB_CLIENT_SECRET=$GITHUB_CLIENT_SECRET

COPY plugins.txt /usr/share/jenkins/my-plugins.txt

ARG JAVA_OPTS

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/my-plugins.txt
