FROM python:3.9.13-slim-buster

WORKDIR /main

COPY . .

RUN apt update
RUN apt upgrade -y
RUN apt install -y python3
RUN apt install -y python3-pip
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install -r requirements.txt

RUN apt install git -y
RUN git clone https://github.com/MrForkle/communication_layer.git
RUN pip install -r communication_layer/requirements.txt

CMD ["python", "client_handler_main.py"]