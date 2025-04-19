FROM python:3.9.13-slim-buster

WORKDIR /app

COPY . .

RUN apt update
RUN apt upgrade -y
RUN apt install -y python3
RUN apt install -y python3-pip
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install -r requirements.txt

CMD ["python", "client_handler.py"]