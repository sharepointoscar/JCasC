

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
docker build -t sharepointoscar/jcasc:v4 ./master
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

Note that you can use `docker-compose config` to view the configuration including the secret values to ensure they are picked up from the .env file.

# Deploying Jenkins JCasC To Minikube 
Minikube is our local K8s cluster, which allows us to develop specs locally and test them.

All of our deployment artifacts reside within the `minikube` folder of the repo.

Let's create all of our artifacts with one command. 

```bash
>$ kubectl apply -Rf ./minikube
namespace "jcasc" created
deployment "jenkins" created
service "jenkins" created
persistentvolumeclaim "jenkinshome-pv-claim" created

```

## Creating Secrets and ConfigMap
The Jenkins deployment will not work until its dependencies are created.  It depends on a few secrets and configmap.  So let's create that now.

### Create ConfigMap
We need to make the `jenkins.yaml` file available to our container.  For this, we use a configmap and mount a volue accessing it.
```shell
# creating the jcasc-configmap
kubectl create configmap jcasc-configmap --from-file=./jenkins.yaml --namespace jcasc

```
**NOTE:** There are more appropriate ways to deploy and manage secrets, this is is a not the best way, and I recommend looking into `HashiCorp Vault` or using a cloud native service.

### Create Secrets

```shell

# these are your github credentials
kubectl create secret generic github --from-literal=github_user=SharePointOscar --from-literal=github_pass='Graphics01!!!!!' --namespace jcasc

# these are your github  app auth credentials
kubectl create secret generic github-auth --from-literal=clientID='71eb404a7a654ce91966' --from-literal=clientSecret='e08f070aba21354a211a0bfd9067c89e5d78bc54' --namespace jcasc

# change password a desired
kubectl create secret generic adminpw --from-literal=adminpw=password1 --namespace jcasc

# point ot an existing ssh key in your system
kubectl create secret generic agent-private-key --from-file=/Users/sharepointoscar/.ssh/github_rsa --namespace jcasc

```