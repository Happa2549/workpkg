import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class TaskList(Node):
    def __init__(self):
        super().__init__('task_list')
        self.tasks = []
        self.subscription = self.create_subscription(
            String,
            'todo_tasks',
            self.listener_callback,
            10
        )

    def listener_callback(self, msg):
        self.tasks.append(msg.data)
        self.get_logger().info('Current tasks:')
        for i, task in enumerate(self.tasks, 1):
            self.get_logger().info(f'{i}. {task}')

def main(args=None):
    rclpy.init(args=args)
    node = TaskList()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()

