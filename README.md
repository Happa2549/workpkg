# workpkg

 このros２のパッケージは端末１からタスクを送信し、端末２でタスクリストとして保持、管理するサンプルです。

 **Repository:**
https://github.com/Happa2549/workpkg

## 目次
- [実行環境](#実行環境)
- [ディレクトリ構成](#ディレクトリ構成)
- [ノード一覧](#ノード一覧)
- [ノードの起動](#ノードの起動)
- [使用例](#使用例)
- [ノードとトピックの説明](#ノードとトピックの説明)
- [ライセンス](#ライセンス)


##
## 実行環境
- OS: Ubuntu 22.04 LTS
- ROS 2: Humble Hawksbill
- Python: 3.10
- 必要パッケージ: colcon, rclpy
- テスト環境: GitHub Actions上の `ryuichiueda/ubuntu22.04-ros2:latest` コンテナ


## ディレクトリ構成
```
workpkg/
├── package.xml
├── setup.py
├── workpkg/
│   ├── task1.py
│   ├── task2.py
│   ├── task1_test.py
│   └── task2_test.py
└── test/
    └── test.bash
```

## ノード一覧
- `task1`: ユーザ入力からタスクを送信するパブリッシャノード
- `task2`: 受信したタスクをリストに保持するサブスクライバノード
- `task1_test`: 自動テスト用の `task1` ノード（非対話型）
- `task2_test`: 自動テスト用の `task2` ノード



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

## ノードとトピックの説明
### 1.task1
    - タスクを追加するノードです。
    - ユーザー入力を受け取り、指定されたタスク名を task_list トピックに送信します。
### 2.task2
    - タスクの一覧を管理・表示するノードです。
    - task_list トピックを購読し、受信したタスクを内部リストに追加します。
    - タスクが追加されるたびに現在のリストのログを表示します。

### task_list
    - workpkgではこれをトピックとする。
    - task1 がタスクを送信するために使用するトピックです。
    - task2 はこのトピックを購読してタスクを受け取り、リストとして管理します。
     

# ライセンス
- このソフトウェアパッケージは，GNU General Public License v3.0 (GPL-3.0) の下で配布されます。
- ソフトウェアの使用，コピー，改変，および再頒布が許可されています。
- GPL 3.0 の全文は"https://github.com/Happa2549/robosys2025/blob/main/COPYING"
  を参照してください。
- © 2025 Shunsuke Morito
