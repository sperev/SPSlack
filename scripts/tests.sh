docker run -v $VOLUME -p $PORT $IMAGE /bin/sh -c "$SCRIPT"

docker logs $(docker ps -a -q) | grep -i "Test case.*passed" >> $FILE
docker logs $(docker ps -a -q) | grep -i "Test case.*failed" >> $FILE

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
