echo 'Building Containers'

echo 'Building Base'
docker build --no-cache -t base .

echo 'Building Init Container'
docker build --no-cache -t init init

echo 'Building Client Handler Container'
docker build --no-cache -t client_handler client_handler

echo 'Building Chat Server Main Container'
docker build --no-cache -t chat_server_main chat_server/main

echo 'Building Chat Server Child Container'
docker build --no-cache -t chat_server_child chat_server/child