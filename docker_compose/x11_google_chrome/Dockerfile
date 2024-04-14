FROM ubuntu:20.04
RUN apt update -y && apt install -y x11vnc xvfb xauth wget
RUN apt install -y firefox 

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install -y ./google-chrome-stable_current_amd64.deb
