FROM openjdk:21-slim-bullseye

RUN apt-get update && \
    apt-get install -y maven git python3 curl lsof iputils-ping htop telnet zsh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN chsh -s $(which zsh) && \
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended    

RUN git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
        /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
        /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions 

COPY .devcontainer/.zshrc /root/.zshrc

ENV JAVA_OPTS="-Duser.timezone=UTC" \
    SHELL=/bin/zsh

WORKDIR /workspace

EXPOSE 8080

CMD [ "tail", "-f", "/dev/null" ]