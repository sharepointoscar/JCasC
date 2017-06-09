

## A Dockerfile to spin up a Jenkins Container configured to use the Docker CLI
Concept from Adrian Mouat's [article](http://container-solutions.com/running-docker-in-jenkins-in-docker)

![alt text](http://www.focusedsupport.com/blog/content/images/2015/06/docker_jenkins_page-2.png "Cute Docker Whale In Action")

***

# Overview
Like many other nerds out there, I wanted to enhance my CI/CD configuration and have the ability to build/push Docker images to Docker Hub on successful app build and testing.  In order to do that, Jenkins needs the ability to execute Docker CLI commands.  

## My Setup
I am running Docker for Mac on my Macbook Pro, I've chosen to install it using the homebrew vs. downloading the dmg.  This approach gets me the Docker for Mac, here is a blurb
from Docker describing it:

>Docker for Mac is a Mac native application, that you install in /Applications. At installation time, it creates symlinks in /usr/local/bin for docker and docker-compose, to the version of the commands inside the Mac application bundle, in /Applications/Docker.app/Contents/Resources/bin.

Prior to installing **Docker for Mac**, I was running Docker Toolbox, which does not use the native [HyperKit](https://github.com/docker/HyperKit/) but rather Virtual Box.  My environment looked like this:

![Docker Toolbox](https://docs.docker.com/docker-for-mac/images/toolbox-install.png)
[image credit: Docker, Inc.]
### So what is Docker for Mac?
Docker for Mac is a native App which has docker compose, docker and docker-image built-in.  It also does not require VirtualBox as it uses Hyperkit, and you don't manage the box as this is handled by the app itself.

>At installation time, Docker for Mac provisions an HyperKit VM based on Alpine Linux, running Docker Engine. It exposes the docker API on a socket in /var/run/docker.sock. Since this is the default location where docker will look if no environment variables are set, you can start using docker and docker-compose without setting any environment variables.

This is what I end up with.

![Docker for Mac diagram](https://docs.docker.com/docker-for-mac/images/docker-for-mac-install.png)
[image credit: Docker, Inc.]

You can run both Docker Toolbox and Docker for Mac, but it is damn confusing and a pain to track which environment you are using, so your setup would look like this.

![Docker for Mac and Docker Toolbox coexistence](https://docs.docker.com/docker-for-mac/images/docker-for-mac-and-toolbox.png)
[image credit: Docker, Inc.]

## Setup Jenkins to execute Docker CLI Commands
Now that you have an idea of the setup required, let's dive into setting up Jenkins to allow for executing Docker CLI commands.


  #### Using Docker Compose and Dockerfile
  We could use CLI commands, but why go through that if we can create a nice configuration to repeatedly build this image?

##### The docker-compose.yaml file.
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
