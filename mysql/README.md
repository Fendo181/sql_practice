### MySQL入門

- MySQL は高速性と堅牢性を追及したマルチユーザ・マルチスレッドのＳＱＬデータベースです。
- 世界で最も人気のあるオープンソースデータベースです。

- ref:[MySQL](https://www.mysql.com/jp/)


### 用語説明

- 行:レコード(Record/Row)
  - データ
  - 横
- 列:フィールド(Fiels/Column)
  - 属性値
  - 縦
- SQL(Structured Query Language)
  - Database や Table 、 Field や Record を扱う言語を SQL （ Structured Query Language ）と呼ぶの


### コマンド

※Macでの環境でに検証になります。

#### mysqlが動いているか確認する

```sh
$ mysql.server status
SUCCESS! MySQL running (581)
```

#### ログイン

```sh
mysql -uroot
```

#### 現在のユーザを確認する

```sh
mysql> select user();
+----------------+
| user()         |
+----------------+
| root@localhost |
+----------------+
1 row in set (0.00 sec)
```

### サーバの接続を切る

```sh
 \q
 exit
```
