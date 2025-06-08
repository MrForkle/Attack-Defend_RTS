FROM base

WORKDIR /main

COPY . .
RUN pip install -r requirements.txt

CMD ["python", "chat_server_child.py"]