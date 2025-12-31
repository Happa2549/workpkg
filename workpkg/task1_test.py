# SPDX-FileCopyrightText: 2025 Morito Shunsuke
# SPDX-License-Identifier: GPL-3.0-only

#!/usr/bin/env python3
import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class TaskPublisher(Node):
    def __init__(self):
        super().__init__('task_publisher_test')
        self.publisher_ = self.create_publisher(String, 'task_topic', 10)
        self.publish_task("test task")

    def publish_task(self, task_name: str):
        msg = String()
        msg.data = task_name
        self.publisher_.publish(msg)
        self.get_logger().info(f'Added task: "{task_name}"')

def main(args=None):
    rclpy.init(args=args)
    node = TaskPublisher()
    rclpy.spin_once(node, timeout_sec=1)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()

