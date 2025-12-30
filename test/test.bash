#!/bin/bash
set -e

WORKSPACE=/root/ros2_ws

cd $WORKSPACE
colcon build

source $WORKSPACE/install/setup.bash

timeout 5 ros2 run workpkg task2 > /tmp/task2.log 2>&1 &
ros2 run workpkg task1 "test task"

sleep 1

if grep -q "test task" /tmp/task2.log; then
    echo "Test passed"
    exit 0
else
    echo "Test failed"
    cat /tmp/task2.log
    exit 1
fi

