FROM ubuntu:22.04
EXPOSE 1338
RUN apt update -y && apt install -y ca-certificates curl gnupg lsb-release sudo
RUN sudo install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN sudo chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN sudo apt update -y
RUN sudo apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# RUN systemctl start docker
# RUN systemctl enable docker
# RUN systemctl restart docker
RUN mkdir -p /kong
WORKDIR /kong
COPY docker-compose.yml .
# ENTRYPOINT ["/bin/bash","-c"]
# CMD ["docker compose up -d"]