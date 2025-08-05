#!/bin/bash

CONTAINER_NAME="test-fail-container"
LOG_FILE="monitor.log"

while true
do
  STATUS=$(docker inspect --format='{{.State.Status}}' "$CONTAINER_NAME" 2>/dev/null)

  if [ "$STATUS" == "exited" ]; then
    echo "$(date): $CONTAINER_NAME has exited. Restarting..." | tee -a $LOG_FILE
    docker restart "$CONTAINER_NAME"
  elif [ "$STATUS" == "running" ]; then
    echo "$(date): $CONTAINER_NAME is running." >> $LOG_FILE
  else
    echo "$(date): $CONTAINER_NAME not found or other error." | tee -a $LOG_FILE
  fi

  sleep 5
done
