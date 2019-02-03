

# Deploy Jenkins X CI/CD to your K8s cluster using a custom Docker image that uses Jenkins Configuration as Code (JCasC) 
### Deploy it to GKE or Minikube, specs included.

<img src="images/logo.svg" width="192">


# About Jenkins X
[Jenkins-x.io](https://jenkins-x.io/) is a great place to learn about this wonderful project that is positioning itself to be next generation CI/CD platform for `Kubernetes`.  And rightfully so, it is loaded with features that get you up and running quickly on any cloud you are working on.


# Overview
The goal of this article is to help you deploy a `Jenkins X` to your `K8s` cluster using a custom `Docker` image that uses `JCasC`. 

Deploying Jenkins is easy these days.  However, configuring and saving the configuration has not been easy, especially since there is a lot of manual config via the UI. This is far more onerous when dealing with multiple instances of Jenkins which many environments actually have.

Jenkins Configuration as Code is the next big thing.  This repository helps you get started quickly.

## About JCasC
There is a vibrant and active community for `JCasC`.

View the [wiki](https://wiki.jenkins.io/display/JENKINS/configuration+as+code+plugin) page. See [presentation slides](https://docs.google.com/presentation/d/1VsvDuffinmxOjg0a7irhgJSRWpCzLg_Yskf7Fw7FpBg/edit?usp=sharing) from Jenkins World 2018.

Join the Jenkins Configuration as Code (JCasC) office hours meeting scheduled for every second Wednesday. Use the Hangout on Air link from our [Gitter](https://gitter.im/jenkinsci/configuration-as-code-plugin) chat channel. As an alternative, use the link from the [invitation](https://calendar.google.com/event?action=TEMPLATE&tmeid=MmdwdTE1cTFvaGw1NGUycGxqdWUwcXExaWFfMjAxODA3MjVUMDcwMDAwWiBld2VAcHJhcW1hLm5ldA&tmsrc=ewe%40praqma.net&scp=ALL). See previous [meeting minutes](https://docs.google.com/document/d/1Hm07Q1egWL6VVAqNgu27bcMnqNZhYJmXKRvknVw4Y84/edit?usp=sharing)

# What you can do with this Repository

* Deploy Jenkins using JCasC on your laptop running Docker
* Deploy Jenkins using JCasC to Minikube
* Deploy Jenkins using JCasC to GKE

# The Jenkins Configurations
There are two key configurations I decided to incorporate as a starting point, to demonstrate how that is done:

* **Branding Jenkins** - using the Simple Theme Plugin and specifying a Theme   because who likes the default UI???

* **Configuring Jenkins to use OAuth against GitHub** - Most companies do not use the Jenkins db for users, that is just not possible in the Enterpise.


# Assumptions
* You have `Docker` working locally
* You have `kubectl` and `Minikube` working locally or a cluster in GKE and you're authenticated via the `gcloud` CLI.

# Build the Jenkins Image & Push to Registry
Most of the `YAML` files including the `docker-compose` use an image.  This image needs to be built and pushed to the registry, I use `Docker Hub`.

## Building Image Using Docker CLI
First, build the image, execute this command in the root of this repo as follows:
```bash
docker build -t sharepointoscar/jcasc:v2 ./master
```
Let's take a look at what images are now available to us.

```bash
docker images

REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
sharepointoscar/jcasc   v2                  29b4ca22c9d8        25 seconds ago      755MB
jenkinsxio/jenkinsx     latest              8816714cda1f        3 days ago          588MB
praqma/jenkins4casc     1.3-latest          b05ed588ccfb        2 months ago        704MB
walkerlee/nsenter       latest              b3e591c9273c        16 months ago       582kB
```
Ok it looks like our image built succesfully, lets push the image to the registry. I use Docker Hub.

```bash
docker push sharepointoscar/jcasc:v2
```

Once you are done, you will then edit the proper files such as the `docker-compose.yaml`, depending on where you plan to deploy Jenkins, and reference said image and version.

# Protecting Secrets
For the purpose of quickly safe-guarding the Github **ClientID** and **ClientSecret** values, I've used a `.env` file which is **not** checked into source control, you'll have to create one.

**NOTE** The `.env` file values should be filled in prior to using the solution.  

Here is a snippet, replace the placeholder text with real values. You typically get this from creating an app in GitHub.

```env
GITHUB_CLIENT_ID=<CLIENTID>
GITHUB_CLIENT_SECRET=<CLIENTSECRET>
```

# Deploy Jenkins using JCasC on your laptop running Docker

Perhaps, this is one of the easiest and fastest method.

* Edit `docker-compose.yaml` and use the image we just built and pushed to the registry.  Since we are configuring Jenkins to use GitHub as an authentication provider, be sure you've created an `.env` file and added the two variables and values.

* Ensure you've modified the jenkins.yaml - You can leave it as is as well, to quickly see this in action, then make incremental modifications to experiment.

Now let's run the following command on the root of our repository.

```bash
docker-compose up
```

Note that you can use `docker-compose config` to view the configuration including the secret values.

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
