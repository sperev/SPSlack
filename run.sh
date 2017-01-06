export IMAGE=sperev/ubuntu-swift:latest
export WORKD=source
export VOLUME="`pwd`/:/root/$WORKD"

export PORT=8090:8090
export SCRIPT="swift --version; $WORKD/scripts/test $WORKD"

export FILE="logs"

scripts/tests.sh
scripts/check.sh
