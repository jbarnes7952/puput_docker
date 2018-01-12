docker build -t jbarnes7952/puput_docker .
docker-compose up -d
sleep 5
docker exec -it blog_wagtail ./load_data.sh
echo "Hit [return] to restart build"
read
docker-compose down
./build-loop.sh

