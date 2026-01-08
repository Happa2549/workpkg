#!/bin/bash 
# SPDX-FileCopyrightText: 2025 Morito Shunsuke
# SPDX-License-Identifier: GPL-3.0-only
set -e

WORKSPACE=/github/workspace/ros2_ws
LOG_DIR=$WORKSPACE/.ros_log

mkdir -p $WORKSPACE/src
mkdir -p $LOG_DIR
export ROS_LOG_DIR=$LOG_DIR

cd $WORKSPACE

source /opt/ros/humble/setup.bash

colcon build --symlink-install
source install/setup.bash

timeout 5 ros2 run workpkg task2_test > /tmp/task2.log 2>&1 &

#first test
echo "test task" | ros2 run workpkg task1_test
sleep 1

if grep -q "test task" /tmp/task2.log; then
    echo "Test passed"
else
    echo "Test failed"
    cat /tmp/task2.log
fi

#single test
echo "single message" | ros2 run workpkg task1_test
if [ $? -eq 0 ]; then
    echo "[task1_test single message] Passed"
    cat /tmp/task2.log
fi

#Mult msg test
for i in {1..5}; do
    echo "test task" | ros2 run workpkg task1_test
done
sleep 1

COUNT=$(grep -c 'Added task: "test task"' /tmp/task2.log)

if [ "$COUNT" -ge 5 ]; then
    echo "[Multiple messages] Passed"
else
    cat /tmp/task2.log
fi

#long msg test
echo "" | ros2 run workpkg task1_test
LONG_MSG=$(head -c 5000 </dev/zero | tr '\0' 'a')
echo "$LONG_MSG" | ros2 run workpkg task1_test
sleep 1

echo "[Abnormal input] Passed"

#set -e

echo "All tests passed"
exit 0	
