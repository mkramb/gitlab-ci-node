FROM ubuntu

ENV PROFILE ~/.bash_profile
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.5.0

# make sure apt is up to date
RUN apt-get update --fix-missing
RUN apt-get install -y bash wget git

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN touch ~/.bash_profile

# Install nvm with node and npm
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
