import rclpy
from rclpy.node import Node
from std_msgs.msg import String

class TaskPublisher(Node):
    def __init__(self):
        super().__init__('task_publisher')
        self.publisher_ = self.create_publisher(String, 'todo_tasks', 10)
        self.get_logger().info('Type task names to add. Ctrl+C to quit.')

    def run(self):
        while True:
            try:
                task = input('Add task: ')
                msg = String()
                msg.data = task
                self.publisher_.publish(msg)
                self.get_logger().info(f'Added task: "{task}"')
            except KeyboardInterrupt:
                break

def main(args=None):
    rclpy.init(args=args)
    node = TaskPublisher()
    node.run()
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()

