#!/bin/bash

set -e

sudo service docker start

sudo docker -v

bash /usr/local/bin/jenkins.sh
