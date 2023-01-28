#Create image from docker.io/victormwenda/natshule-html base image
# First build from s2i build https://github.com/sclorg/s2i-php-container.git registry.redhat.io/rhscl/php-72-rhel7 victormwenda/natshule-php7.2
FROM victormwenda/natshule-php7.4:latest

# Set servername
RUN sed -i 's_#ServerName www.example.com:80_ServerName kcb-natshule.apps.test.aro.kcbgroup.com:8443_g' /etc/httpd/conf/httpd.conf

MAINTAINER Victor Mwenda <vmwenda.vm@gmail.com>
