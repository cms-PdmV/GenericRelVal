#!/bin/bash

CMD=$1

if [ "$CMD" = "dev" ]; then
  trap "exit" INT TERM ERR
  trap "kill 0" EXIT
  echo "Starting DEV python server"
  python main.py --debug --mode dev &
  python_pid=$!
  echo "Starting DEV node server"
  cd vue_frontend/
  npm run watch &
  npm_pid=$!
  cd ..
  echo "python pid $python_pid"
  echo "npm pid $npm_pid"
  wait
fi

if [ "$CMD" = "build" ]; then
  echo "Building for production"
  cd vue_frontend/
  npm run build
  cd ..
fi

if [ "$CMD" = "start" ]; then
  echo "Starting RelVal"
  nohup python $(pwd)/main.py --mode prod &
  echo "Started with pid $!"
fi
