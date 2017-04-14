# Hecate 1.0

# Description

Hecate is the Greek goddess of solitude, described as having an independent nature.
Oftentimes people that work from home are similar in temperament. The result
is this project. Hecate monitors [Cisco Spark](http://www.ciscospark.com) for your
current presence information - Do Not Disturb, Available, Inactive, and coming
soon, In a Call and In a WebEx. This information is distributed to
one or more intelligent agents that will use that information in a variety
of ways.

Currently, the one agent that is done utilizes [Cisco Tropo](http://www.tropo.com)
to send an SMS message to the phone of your choice on each status change.
This could be to a roommate, letting them know that you wish not to be
disturbed, or to a co-worker, informing them that you are on the phone.

# Installation

## Environment

### Prerequites
* Python 2.7+
* setuptools package
* requests library
* Hosting environment - There are installation scripts provided that will
install the application into a [mantl](http://mantl.io) environment. There is also
an installation script to create a [docker](http://www.docker.com)
[compose](https://docs.docker.com/compose/) file which can be used to deploy
onto your local workstation or the container environment of your choice.

## Downloading

Option A:

If you have git installed, clone the repository.

git clone https://github.com/imapex/Hecate

Option B:

The latest build of this project is also available as a Docker image from Docker Hub

docker pull imapex/Hecate:latest

Though in the case of docker installation, the docker-compose script is the simplest choice as it correctly instantiates the dependencies between the containers and builds networking between them.

## Installing

### Mantl installation

These instructions assume that you have cloned the installation repo as listed above.

Source hecate_setup. This will prompt for temporary environment variables needed for the installation.
Run the hecate-install.sh script to install the application to your mantl server. This script will also create json files that can be used to re-install the application if needed.

### Docker installation

To quickly bring the application up, type "docker-compose up". This will launch the containers in the correct sequence and instantiate the web interface.

Installation into a swarm should work if you create a bundle and upload it; this has not
been tested at this time.

## Usage

As of this version, configuration is done via environment variables passed to
the containers.

More words to follow.

## Development

### Linting
Do so.

### Test coverage
Yes.
