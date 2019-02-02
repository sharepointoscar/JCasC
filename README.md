

## Deploy Jenkins using Jenkins Configuration as Code [JCaC]
### Deploy it to GKE or Minikube, specs included.

<img src="images/logo.svg" width="192">




# Overview
Deploying Jenkins is easy these days.  However, configuring and saving the configuration has not been easy, especially since there is a lot of manual config via the UI. This is far more onerous when dealing with multiple instances of Jenkins as many environments have.

Jenkins Configuration as Code is the next big thing.  This repository helps you get started quickly.

## What you can do with this Repository

* Deploy Jenkins using JCasC via a Docker Container locally
* Deploy Jenkins using JCasC to a K8s Cluster in GKE or Minikube

## The Jenkins.yaml
There are two key configurations I decided to incorporate as a starting point, to demonstrate how that is done:

* Branding Jenkins using the Simple Theme Plugin and specifying a Theme -  because who likes the default UI???
* Configuring Jenkins to use OAuth against GitHub - Most companies do not use the Jenkins db for users, that is just not possible in the Enterpise.

# Reference
There is a vibrant and active community.  

View the [wiki](https://wiki.jenkins.io/display/JENKINS/configuration+as+code+plugin) page. See [presentation slides](https://docs.google.com/presentation/d/1VsvDuffinmxOjg0a7irhgJSRWpCzLg_Yskf7Fw7FpBg/edit?usp=sharing) from Jenkins World 2018.

Join the Jenkins Configuration as Code (JCasC) office hours meeting scheduled for every second Wednesday. Use the Hangout on Air link from our [Gitter](https://gitter.im/jenkinsci/configuration-as-code-plugin) chat channel. As an alternative, use the link from the [invitation](https://calendar.google.com/event?action=TEMPLATE&tmeid=MmdwdTE1cTFvaGw1NGUycGxqdWUwcXExaWFfMjAxODA3MjVUMDcwMDAwWiBld2VAcHJhcW1hLm5ldA&tmsrc=ewe%40praqma.net&scp=ALL). See previous [meeting minutes](https://docs.google.com/document/d/1Hm07Q1egWL6VVAqNgu27bcMnqNZhYJmXKRvknVw4Y84/edit?usp=sharing).



# Assumptions
* You have `Docker` working locally
* You have `kubectl` and `Minikube` working locally or a cluster in GKE and you're authenticated via the `gcloud` CLI.

# Build the Jenkins Image & Push to Registry
Most of the `YAML` files and the `docker-compose` use an image.  This image needs to be built and pushed to your registry.

## Using Docker CLI
First, build the image, execute this command in the root of this repo as follows:
```bash
docker build -t sharepointoscar/JCasC:v1 .
```

On success, push the image to your registry.  I use Docker Hub.

```bash
docker push sharepointoscar/JCasC:v1
```
## Using Docker Compose

Once you are done, you will then edit the proper files, depending on where you plan to deploy Jenkins, and reference said image and version (version is important, as you want to ensure you use the latest).

# Deploying Jenkins using JCasC Using Docker Container Locally

Perhaps, this is one of the easiest and fastest method.

* Ensure you've modified the jenkins.yaml

# Deploying Jenkins JCasC To GKE 

## The docker-compose.yaml file.
In this file, we specify the configuration of our Jenkins image when it needs to be spun up.

``` yaml
version: "3"
services:
  jenkins:
    build:
      context: .
      dockerfile: Dockerfile
    image: sharepointoscar/jenkins:latest
    container_name: EL_JENKINS_LOCO
    restart: always
    ports:
      - 8080:8080
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker
      - ./JenkinsHome:/var/jenkins_home
```

A few things to note:

  - Use the Dockerfile at build time, as it contains specific tasks we want to run.  In my case, I want to have a list of Jenkins plugins to quickly install at build time and install additional software.
  - Specify the image the service Jenkins will use
  - Volumes
    - *JENKINS_HOME* - I override this to use the JenkinsHome folder in this git repo to save configuration changes, this means every time I spin up Jenkins, it will have all my plugins and UI configuration I previously setup.
    - *Docker Socket* - This is the socket the docker client uses to communicate with the daemon within the Jenkins container
    - *Docker executable* (/usr/bin/docker) - The docker binary.


NOTE: One thing to note, is that my configuration had ` /usr/local/bin/docker` as I am using Docker for Mac and so when I tried executing
` docker-compose up` it gave me an error message.  

What I did, was to create a symlink by executing this command `sudo ln /usr/local/bin/docker /usr/bin/docker` see more details on this [Github](https://github.com/marcelbirkner/docker-ci-tool-stack/issues/24) thread and the image spins up with no problems.


To bring up or build Jenkins image, all you do is execute this command to have it running in the background.
` docker-compose up -d`
## Build and run the Jenkins image manually using Docker CLI
If you need to use the CLI, this is how you would build and run the Jenkins image.  We use the -rm=true flag to remove intermediate containers.
``` bash
   docker build -t=sharepointoscar/jenkins --rm .
```

#### Create Docker Container
This command ensures that the host machine docker installation is accessible to the container we are about to run.

``` bash
  docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
        -v /usr/bin/docker:/usr/bin/docker -v $PWD/JenkinsHome:/var/jenkins_home -p 8080:8080 sharepointoscar/jenkins
```

**NOTE**: This is a quick way for getting Jenkins to build containers.  I will be working on what I feel is a best practice - using Jenkins master and slaves to perform tests and build my images as described  on [Building Continuous Integration Pipeline with Docker](https://www.docker.com/sites/default/files/UseCase/RA_CI%20with%20Docker_08.25.2015.pdf)
