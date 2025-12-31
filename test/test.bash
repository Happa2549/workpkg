#!/bin/bash
set -e

WORKSPACE=~/ros2_ws

cd $WORKSPACE
colcon build
source $WORKSPACE/install/setup.bash

# task2_testをバックグラウンドで起動
timeout 5 ros2 run workpkg task2_test > /tmp/task2.log 2>&1 &

# task1_testを実行してタスクを送信
ros2 run workpkg task1_test

sleep 1

# 受信ログに "test task" があるか確認
if grep -q "test task" /tmp/task2.log; then
    echo "Test passed"
    exit 0
else
    echo "Test failed"
    cat /tmp/task2.log
    exit 1
fi

