#!/bin/bash
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

TMP_LOG=/tmp/task2.log

timeout 5 ros2 run workpkg task2_test > $TMP_LOG 2>&1 &
sleep 1
echo "test task" | ros2 run workpkg task1_test
sleep 1

if grep -q "test task" $TMP_LOG; then
    echo "[Basic test] Passed"
else
    echo "[Basic test] Failed"
    cat $TMP_LOG
    exit 1
fi

echo "single message" | ros2 run workpkg task1_test
if [ $? -eq 0 ]; then
    echo "[task1_test single message] Passed"
else
    echo "[task1_test single message] Failed"
    exit 1
fi

echo "All tests passed"
exit 0


