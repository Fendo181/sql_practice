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
- msyqlのクエリ
  - 大文字、小文字は区別されない

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

#### サーバの接続を切る

```sh
 \q
 exit
```

#### データベースの一覧を取得する

```sh
 show databases
 +--------------------+
| Database           |
+--------------------+
| information_schema |
| homestead          |
| laravel_app        |
| laravel_tutorial   |
+--------------------+
```

#### データベースを作成する

```sql
create database dotinstall_db
Query OK, 1 row affected (0.03 sec)
```
#### データベースを削除する

```sql
drop database dotinstall_db;
Query OK, 0 rows affected (0.00 sec)
```

#### データベースの操作対象を切り替える

選択されてない状態

```sql
mysql> select database();
+------------+
| database() |
+------------+
| NULL       |
+------------+
```

選択する

```sql
mysql> use dotinstall_db;
Database changed
mysql> select database();
+---------------+
| database()    |
+---------------+
| dotinstall_db |
+---------------+
1 row in set (0.00 sec)
```

