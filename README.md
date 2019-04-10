# Jenkins Docker

[![Build Status](https://dev.azure.com/pcosta-fccn/Docker base images/_apis/build/status/fccn.docker-jenkins?branchName=master)](https://dev.azure.com/pcosta-fccn/Docker base images/_build/latest?definitionId=5&branchName=master)

Jenkins adaptation for running docker pipelines as a docker container.

Based on [jenkinsci/blueocean](https://hub.docker.com/r/jenkinsci/blueocean) Alpine image and adds user jenkins to the docker group (default GID 999) to allow it to run docker inside the container. 
You can fetch the latest image in [docker hub](https://hub.docker.com/r/stvfccn/jenkins), this image will use the GID 999 for the docker group. To use a different GID you need to build a new image.

## Requirements

To build this container you need to have docker installed. A makefile is provided along with the project to facilitate
building and publishing of the images.

## Configure and Install

Check the **deploy.env** file for build configurations. To publish the image to another repository you will need to change the **DOCKER_REPO** var to your repository location. This can also be a private repository.

You also need to check the GID of the docker group on the host machine and change the **DOCKER_GID** var accordingly. 

## Building the docker image

To create the image run:
```
make image
```

To create and publish a new version run:
```
make release
```

For more information on what it is possible to do

```
make help
```

## Usage

To run this image you need to define a home folder. By default the home folder provided in the project is used. To start jenkins with default settings run:

```
make run
```

You can also start an instance using the docker command:

```
docker run -i -t --rm --name "jenkins" -v /var/run/docker.sock:/var/run/docker.sock -v $(PWD)/home:/var/jenkins_home -p "8080:8080" -p "50000:50000" stvfccn/jenkins
```
You can replace *$(PWD)/home* with the path the jenkins home folder

### Usage with docker-compose

Use the following sample compose file to start this container in docker-compose:

```yaml
version: '3.4'
services:
  jenkins: 
    image: stvfccn/jenkins
    restart: always
    container_name: jenkins
    privileged: true
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - ./home:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
```

## Author

Paulo Costa

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/fccn/docker-npn-webapp-base/tags).

### Versions
- 1.0.1 - jenkins 2.150.2
- 1.0.2 - jenkins >= 2.164.1

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
