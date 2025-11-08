FROM python:3.12-slim-bookworm AS base

WORKDIR /main

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y python3
RUN apt install -y python3-pip

RUN apt install git -y
RUN git clone https://github.com/MrForkle/communication_layer.git
RUN pip install -r communication_layer/requirements.txt