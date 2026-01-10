# workpkg

 この ROS 2 パッケージは タスク管理アプリケーションノード task2.py を中心としたサンプルである。
本パッケージの中心となるノードで、/task_listトピックを購読し、task1.pyから受信したタスクを内部リストに追加する。また、タスク追加ごとに現在のタスクリストのログを出力する。


 **Repository:**
https://github.com/Happa2549/workpkg

## 目次
- [実行環境](#実行環境)
- [ノード・トピック一覧](#ノード・トピック一覧)
- [ノードの起動](#ノードの起動)
- [使用例](#使用例)
- [ライセンス](#ライセンス)


## 実行環境
- OS: Ubuntu 22.04 LTS
- ROS2: Humble Hawksbill
- Python: 3.10
- 必要パッケージ: colcon, rclpy


## ノード・トピック一覧
### ノード一覧
- `task1.py`：ユーザ入力からタスクを送信するパブリッシャノード
- `task2.py`：受信したタスクをリストに保持するサブスクライバノード
- `task1_test.py`：自動テスト用の送信ノード
- `task2_test.py`：自動テスト用の受信ノード

### トピック一覧
- トピック名：/task_list 
- 型：std_msgs/msg/String
- Publisher：task1.py
- Subscriber：task2.py 
 

## ノードの起動
 ```
  #端末1: 送信側
  $ros2 run workpkg task1

  #端末2: 受信側
  $ros2 run workpkg task2
 ```


## 使用例
```
# ターミナル1: タスク送信
$ros2 run workpkg task1
# Add task: と表示されたらタスク名を入力
# 例:
# Add task: 買い物
# Add task: 洗濯

# ターミナル2: タスク受信
$ros2 run workpkg task2
# 受信したタスクがリスト表示されます
# ログ出力例:
# [INFO] [task_list]: Current tasks:
# 1. 買い物
# 2. 洗濯
```
   

# ライセンス
- このソフトウェアパッケージは，GNU General Public License v3.0 (GPL-3.0) の下で配布されます。
- ソフトウェアの使用，コピー，改変，および再頒布が許可されています。
- GPL 3.0 の全文は"https://github.com/Happa2549/robosys2025/blob/main/COPYING"
  を参照してください。
- © 2025 Shunsuke Morito
