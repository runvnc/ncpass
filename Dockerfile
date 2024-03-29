FROM dockerfile/ubuntu
# Install Haproxy.
RUN add-apt-repository ppa:vbernat/haproxy-1.5
RUN apt-get update -qy
RUN \
  apt-get install -y haproxy && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy

ADD haproxy.cfg /etc/haproxy/haproxy.cfg
# Add files.
ADD start.bash /haproxy-start

ADD . /opt/localserver

# Define mountable directories.
VOLUME ["/data", "/haproxy-override"]

# Define working directory.
WORKDIR /etc/haproxy

# Define default command.
CMD ["bash", "/haproxy-start"]

# Expose ports.
EXPOSE 443
