# SPDX-FileCopyrightText: 2025 Morito Shunsuke
# SPDX-License-Identifier: GPL-3.0-only

#!/usr/bin/env python3
import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class TaskSubscriber(Node):
    def __init__(self):
        super().__init__('task_list_test')
        self.subscription = self.create_subscription(
            String,
            'task_topic',
            self.listener_callback,
            10)
        self.tasks_received = []

    def listener_callback(self, msg):
        self.tasks_received.append(msg.data)
        self.get_logger().info(f"Current tasks: {msg.data}")

def main(args=None):
    rclpy.init(args=args)
    node = TaskSubscriber()
    # spin for a short while to receive messages
    rclpy.spin_once(node, timeout_sec=2)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()

