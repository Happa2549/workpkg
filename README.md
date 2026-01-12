# workpkg

 このROS2パッケージは タスク管理アプリケーションノードであるtask2を中心としたサンプルである。
task2は、/task_listトピックを購読し、任意のROS2ノード(このサンプルではtask1)から受信したタスクを内部リストに追加する。また、タスク追加ごとに現在のタスクリストのログを出力する。



## 実行環境
- OS: Ubuntu 22.04 LTS
- ROS2: Humble Hawksbill
- Python: 3.10


## ノード・トピック一覧
### ノード一覧
- `task1`：ユーザ入力からタスクを送信するパブリッシャノード
- `task2`：受信したタスクをリストに保持するサブスクライバノード
- `task1_test`：自動テスト用の送信ノード
- `task2_test`：自動テスト用の受信ノード

### トピック一覧
- トピック名：/task_list 
- 型：std_msgs/msg/String
- Publisher：本パッケージではtask1がパブリッシュノードであるが、タスク情報を文字列として送信する任意のノードが publish 可能である。
- Subscriber：本パッケージではtask2が購読しているが同じ型を使用するノードが購読可能である。 
 

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
