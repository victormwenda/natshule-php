How to build the natshule php

- Download the container
  - `docker pull registry.redhat.io/rhel8/php-74`
  - `docker pull registry.redhat.io/ubi8/php-74`

- Build using sci
  - `./s2i build https://github.com/sclorg/s2i-php-container.git registry.redhat.io/ubi8/php-74 victormwenda/ubi8-php7.4-base:latest`
  - `./s2i build https://github.com/sclorg/s2i-php-container.git registry.redhat.io/rhel8/php-74 victormwenda/rhel8-php7.4-base:latest`

- Build base images for the project
    - `docker build -t victormwenda/natshule-rhel8-php74-base:latest sci-php-container/rhel8`
    - `docker build -t victormwenda/natshule-ubi8-php74-base:latest sci-php-container/ubi8`

- Build actual images for the project
    - `docker build -t victormwenda/natshule-rhel8-php74:latest -f Dockerfile.rhel8 .`
    - `docker build -t victormwenda/natshule-ubi8-php74:latest -f Dockerfile.ubi8 .`
