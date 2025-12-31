#!/bin/bash
set -e

WORKSPACE=/github/workspace/ros2_ws

mkdir -p $WORKSPACE/src
cd $WORKSPACE

source /opt/ros/humble/setup.bash

colcon build --symlink-install
source install/setup.bash

timeout 5 ros2 run workpkg task2_test > /tmp/task2.log 2>&1 &

echo "test task" | ros2 run workpkg task1_test

sleep 1

if grep -q "test task" /tmp/task2.log; then
    echo "Test passed"
    exit 0
else
    echo "Test failed"
    cat /tmp/task2.log
    exit 1
fi


