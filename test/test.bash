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


timeout 5 ros2 run workpkg task2_test > /tmp/task2.log 2>&1 &
echo "test task" | ros2 run workpkg task1_test
sleep 1
if grep -q "test task" /tmp/task2.log; then
	echo "Test passed" 
	exit 0 
else echo "Test failed"
	cat /tmp/task2.log
	exit 1 
fi


echo "single message" | ros2 run workpkg task1_test
if [ $? -eq 0 ]; then
    echo "[task1_test single message] Passed"
else
    echo "[task1_test single message] Failed"
    exit 1
fi

for i in {1..5}; do
    echo "msg $i" | ros2 run workpkg task1_test
done
sleep 1

FAIL=0
for i in {1..5}; do
    if ! grep -q "msg $i" /tmp/task2.log; then
        echo "[Multiple messages] msg $i missing"
	FAIL=1
    fi
done
if [ $FAIL -eq 0 ]; then
    echo "[Multiple messages] Passed"
else
    echo "[Multiple messages] Failed"
    cat /tmp/task2.log
    exit 1
fi

echo "" | ros2 run workpkg task1_test
LONG_MSG=$(head -c 5000 </dev/zero | tr '\0' 'a')
echo "$LONG_MSG" | ros2 run workpkg task1_test
sleep 1

if grep -q "$LONG_MSG" /tmp/task2.log; then
    echo "[Abnormal input] Passed"
else
    echo "[Abnormal input] Failed"
    cat /tmp/task2.log
    exit 1
fi

echo "All tests passed"
exit 0
