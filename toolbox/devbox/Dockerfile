FROM ubuntu:bionic

ENV DOCKER_USER dev

# Create user with passwordless sudo. This is only acceptable as it is a
# private development environment not exposed to the outside world. Do 
# NOT do this on your host machine or otherwise.
RUN apt-get update && \
    apt-get install -y sudo && \
    adduser --disabled-password --gecos '' "$DOCKER_USER" && \
    adduser "$DOCKER_USER" sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    touch /home/$DOCKER_USER/.sudo_as_admin_successful && \
    rm -rf /var/lib/apt/lists/*

USER "$DOCKER_USER"

WORKDIR "/home/$DOCKER_USER"

RUN yes | sudo unminimize && \
    sudo apt-get install -y man-db bash-completion build-essential curl openssh-client && \
    sudo rm -rf /var/lib/apt/lists/*

RUN sudo apt-get update && \
    sudo apt-get install -y tmux && \
    sudo rm -rf /var/lib/apt/lists/*


RUN sudo apt-get update && \
    sudo apt-get install -y neovim && \
    sudo rm -rf var/lib/apt/lists/*

ENV NVM_DIR /home/$DOCKER_USER/.nvm


#RUN . "$NVM_DIR/nvm.sh" && \
#    nvm install --lts && \
#    nvm alias default stable
