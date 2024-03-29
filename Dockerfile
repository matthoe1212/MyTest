# Container image that runs your code
FROM debian:11.1-slim

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    sudo \
    && rm -rf /var/lib/apt/lists/* \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && mkdir -p /home/$USERNAME \
    && chown $USER_UID:$USER_GID /home/$USERNAME


RUN apt-get update && apt-get install -y --no-install-recommends\
    binutils \
    cmake \
    clang \
    clang-format \
    clang-tidy \
    git \
    make \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

USER $USER_UID:$USER_GID

ENV TERM xterm-256-colors