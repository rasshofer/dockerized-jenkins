# Dockerized Jenkins

> Jenkins wrapped in a Docker container + everything you need to run your stuff within Docker containers again.

I heard you like Docker. So I put a Docker in your Docker.

## Why?

While building an example CI environment for my masters thesis ([you can find the corresponding example application I built here](https://github.com/rasshofer/masters-thesis-example)), I was looking for a quick and simple way to set up Jenkins and its test runners without being forced to start a lot of VMs.

## Setup

As you may want to customize this whole thing to your personal requirements, I decided to not publish a image of my version of a dockerized Jenkins on the Docker Hub. Instead, you have to build the image on your own locally using this repository and the following command(s).

### Build

You may want to replace `rasshofer` and `dockerized-jenkins` with your own namespaces and names.

```sh
docker build -t rasshofer/dockerized-jenkins .
```

### Run

You may want to replace `rasshofer`, `dockerized-jenkins` and `ci` with your own namespaces and names.

```sh
docker run --name ci -p 8080:8080 -v /var/jenkins_home --privileged rasshofer/dockerized-jenkins
```

## Configuration

- Docker appears in the »Cloud« section of the Jenkins configuration
- Select »Docker« from the »Add a new cloud« drop down menu
- Set »Docker URL« to `http://127.0.0.1:4243`

However, every once in a while the [Jenkins Docker Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin) likes to throw some fancy `NullPointerException`s, which breaks everything. Thus, another option is to use the shell provided by Jenkins as a build step and just build the Docker image using the command-line arguments you would normally use in that shell script. For my [example application](https://github.com/rasshofer/masters-thesis-example), I used the following command.

```sh
docker -H=tcp://127.0.0.1:4243 build -t rasshofer/masters-thesis-example .
```

## Changelog

* 0.0.1
	* Initial version

## License

Copyright (c) 2015 [Thomas Rasshofer](http://thomasrasshofer.com/)  
Licensed under the MIT license.

See LICENSE for more info.
