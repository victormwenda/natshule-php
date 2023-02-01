#Create image from docker.io/victormwenda/natshule-html base image
# First build from s2i build https://github.com/sclorg/s2i-php-container.git registry.redhat.io/rhscl/php-72-rhel7 victormwenda/natshule-php7.2
FROM victormwenda/natshule-php7.4:latest

#Use root
USER 0

# Install php pear and devel
RUN yum -y install php-pear
RUN yum -y install php-devel

# Oracle
RUN mkdir /opt/oracle
ADD oci/ /opt/oracle
RUN cd /opt/oracle && yum -y install oracle-instantclient18.3-basic-18.3.0.0.0-3.x86_64.rpm
RUN cd /opt/oracle && yum -y install oracle-instantclient18.3-devel-18.3.0.0.0-3.x86_64.rpm
RUN sh -c "echo /usr/lib/oracle/18.3/client64/lib > /etc/ld.so.conf.d/oracle.conf"


#Install libnsl
RUN dnf -y install libnsl-2.28-211.el8.x86_64.rpm

# Build OCI8
RUN tar -zxvf /opt/oracle/oci8-2.2.0.tgz -C /opt/oracle \
  && cd /opt/oracle/oci8-2.2.0  \
  && /usr/bin/phpize --with-oci8=shared,instantclient --with-php-config=/usr/bin/php-config \
  && /opt/oracle/oci8-2.2.0/configure --with-oci8=shared,instantclient --with-php-config=/usr/bin/php-config \
  && cd /opt/oracle/oci8-2.2.0 && make install

# Enable oci8
RUN echo $'; Enable oci8.so extension\nextension=oci8' > /etc/php.d/oracle-oci.ini

# Remove unwanted files
RUN rm -rf /opt/oracle

MAINTAINER Victor Mwenda <vmwenda.vm@gmail.com>

