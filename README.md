# workpkg

 このros２のパッケージは端末１からタスクを送信し、端末２でタスクリストとして保持、管理するサンプルです。

 **Repository:**
https://github.com/Happa2549/workpkg

## 目次
- [準備](#準備)
- [対応環境](#対応環境)
- [ファイルの実行](#ファイルの実行)
- [使用例＋出力例](#使用例＋出力例)
- [既知の制限](#既知の制限)
- [ライセンス](#ライセンス)


## ディレクトリ構成
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
# Current tasks:
# 1. 買い物
# 2. 洗濯
```


# ライセンス
- このソフトウェアパッケージは，GNU General Public License v3.0 (GPL-3.0) の下で配布されます。
- ソフトウェアの使用，コピー，改変，および再頒布が許可されています。
- GPL 3.0 の全文は"https://github.com/Happa2549/robosys2025/blob/main/COPYING"
  を参照してください。
- © 2025 Shunsuke Morito
