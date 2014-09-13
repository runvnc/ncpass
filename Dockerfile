FROM dockerfile/ubuntu
# Install Haproxy.
RUN \
  apt-get install -y haproxy && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy

ADD haproxy.cfg /etc/haproxy/haproxy.cfg
# Add files.
ADD start.bash /haproxy-start

# Define mountable directories.
VOLUME ["/data", "/haproxy-override"]

# Define working directory.
WORKDIR /etc/haproxy

# Define default command.
CMD ["bash", "/haproxy-start"]

# Expose ports.
EXPOSE 80
EXPOSE 443
