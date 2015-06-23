# docker build -t rasshofer/dockerized-jenkins .
# docker run --name ci -p 8080:8080 -v /var/jenkins_home --privileged rasshofer/dockerized-jenkins

FROM jenkins
MAINTAINER Thomas Rasshofer <hello@thomasrasshofer.com>

# Switch to root

USER root

RUN DEBIAN_FRONTEND=noninteractive

# Update repositories

RUN apt-get -qq update

# Upgrade system

RUN apt-get -yqq upgrade

# Install base packages

RUN apt-get update && apt-get install -yqq --force-yes --no-install-recommends git-core sudo

# Make `jenkins` a sudoer

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# Install Docker (within Docker)

RUN wget -qO- https://get.docker.com/ | sh

RUN echo "DOCKER_OPTS=\"-H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock\"" >> /etc/default/docker

# Verify Docker

RUN docker -v

# Plugins

COPY plugins.txt /usr/share/jenkins/ref/

RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

# Switch back

USER jenkins

# Inject startup script

COPY startup.sh /usr/local/bin/startup.sh

RUN sudo chmod 755 /usr/local/bin/startup.sh

ENTRYPOINT ["/usr/local/bin/startup.sh"]
