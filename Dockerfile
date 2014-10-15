FROM dockerfile/ubuntu
MAINTAINER Namhoon (emerald105@hanmail.net)

# Non-interactive automated build - avoid some warning messages
ENV DEBIAN_FRONTEND noninteractive

# Set node version
ENV NODE_VER v0.11.14
ENV NODE_HOME_DIR /root/.nvm/v0.11.14

# Install node.js using nvm
RUN \
  git clone https://github.com/creationix/nvm.git $HOME/.nvm \
  echo "source /.nvm/nvm.sh" >> $HOME/.profile \
  /bin/bash -c 'source ~/.vnm/nvm.sh && nvm install $NODE_VER && nvm alias default $NODE_VER && ln -s $NODE_HOME_DIR/bin/node /usr/bin/node && ln -s $NODE_HOME_DIR/bin/npm /usr/bin/npm'

# Install source
RUN \
  git clone https://github.com/reaperes/pine-push-server-v2.git && \
  cd pine-push-server-v2 && \
  npm install

# Run source
ADD ./start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]

EXPOSE 8500
