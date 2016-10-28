FROM philcryer/min-jessie

# Set environment variables
ENV NVM_DIR /usr/local/nvm
ENV NVM_NODE_VERSION 6.9.1
ENV PATH $NVM_DIR/versions/node/v$NVM_NODE_VERSION/bin:$PATH

# Install built-in packages
RUN apt-get update --fix-missing
RUN apt-get install -y bash wget git libpng12-0 libelf1 openjdk-7-jre-headless xvfb
RUN apt-get clean

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install Google Chrome
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable && \
  rm -rf /var/lib/apt/lists/*

# Install nvm with node and npm
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NVM_NODE_VERSION \
    && nvm alias default $NVM_NODE_VERSION \
    && nvm use default
