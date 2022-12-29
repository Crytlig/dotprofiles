# Build Dockerfile from root
# docker build -t <name>:v1 -f ./toolbox/v1/Dockerfile .
FROM alpine:latest

RUN apk add -U --no-cache \
    neovim git zsh tmux openssh-client bash curl

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

COPY .bashrc .bashrc
COPY ubuntu/.zshrc .zshrc


