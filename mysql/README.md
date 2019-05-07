### MySQL入門

- MySQL は高速性と堅牢性を追及したマルチユーザ・マルチスレッドのＳＱＬデータベースです。
- 世界で最も人気のあるオープンソースデータベースです。

ref:[MySQL](https://www.mysql.com/jp/)


### 用語説明

- 行:レコード(Record/Row)
  - データ
  - 横
- 列:フィールド(Fields/Column)
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

#### 作業ユーザを作成して権限を与える

ユーザを作成する


```sql
create user dbuser@localhost identified by '****';
```

ユーザ名`dbuser@localhost`に`dot_install`DBに対する操作権限を全て与える

```sql
grant all on dotinstall_db.* to dbuser@localhost;
```

ログイン

```sql
mysql -u dbuser -p
パスワード入力
```

ユーザを確認する

```sql
mysql> select user();
+------------------+
| user()           |
+------------------+
| dbuser@localhost |
+------------------+
1 row in set
```

データベースを確認する

```sql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| dotinstall_db      |
+--------------------+
2 rows in set (0.00 sec)
```

#### ユーザを削除する

※ルートユーザで作業を行う

```sql
drop user dbuser@localhost
```

#### 外部からSQLを実行する

リダイレククションで実行する


```
mysql -u root < mysql/create_mysql.sql
```

mysqlサーバに入って`sorce` or `\.`コマンドを実行する

```sql
mysql> \. ./mysql/create_mysql.sql
Query OK, 0 rows affected (0.01 sec)

Query OK, 1 row affected (0.00 sec)

Query OK, 0 rows affected, 1 warning (0.00 sec)
```

#### テーブル一覧を見る

```sql
mysql> show tables;
+-----------------+
| Tables_in_myapp |
+-----------------+
| users           |
+-----------------+
```

#### テーブル構造を見る

```sql
mysql> desc users;
+-------+------------------+------+-----+---------+-------+
| Field | Type             | Null | Key | Default | Extra |
+-------+------------------+------+-----+---------+-------+
| id    | int(10) unsigned | YES  |     | NULL    |       |
| name  | varchar(20)      | YES  |     | NULL    |       |
| score | float            | YES  |     | NULL    |       |
+-------+------------------+------+-----+---------+-------+
3 rows in set (0.01 sec)
```

#### テーブルの削除方法

```sql
mysql> drop table users;
Query OK, 0 rows affected (0.00 sec)

mysql> show tables;
Empty set (0.00 sec)
```

### データ型について

- Number
  - int:整数
  - float:浮動小数
  - double:倍精度浮動小数点
  - int unsigned (マイナスの領域は使わず、プラスの領域だけを使う)
- String
  - char:固定
  - varchar:可変長
  - text:長さがわからない
- Date/Time
  - date:日付
  - time:時間
  - datetime:日時
    - `2017-07-22 17:23:33`
- True/False
  - boolean　-> tinyint(1)
    - trueは1(空文字を含むそれ以外の値は全て true になる)
    - falseは0と管理されれている

ref:[MySQL :: MySQL 5.6 リファレンスマニュアル :: 11 データ型](https://dev.mysql.com/doc/refman/5.6/ja/data-types.html)

#### フィールドの属性について

- `not null` : nullは入らない
- `default` : デフォルト値を設定できる
- `unique`: 重複した値を許さない
- `primary key`:レコードを一意に特定できるようなフィールドには、主キーを付けることが推奨されています。
  - これを入れるだけで、`null`でなく、`unique`(重複しない値)である事が保証されます。
  - 主キー属性のフィールドには自動的に`UNIQUE` & `NOT NULL`属性がつきます。
- `auto_increment`:自動で連番にしてくれる

#### フォールドを後から追加する

- `alter`コマンドを使ってカラムを追加する

```sql
-- フィールドの属性を後から追加する
alter table users add column email varchar(255);
```

- `after`を指定すると、特定のカラムの後ろに追加する事ができる

```sql
-- フィールドの属性を後から追加する
alter table users add column email varchar(255) after name;
```

#### フィールドを後から削除する

```sql
alter table users drop column score ;
```


#### フィールドのデータの型や名前を変えたい場合

```sql
alter table users change name user_name varchar(80) default 'nobody';
```

#### テーブルの名前を変えたい場合

```sql
alter table users rename persons;
```
### Select:レコード抽出

- `slect * from table_name`:全件表示
- `select id,name ftom table_name`:カラムを指定して表示
- `where`:条件付きで抽出する
- 論理演算
   - `<>`
   - `<=`
   - `>=`
   - `<>` or `!=` 等しくない
- `null`
  - `is null`:nullか
  - `is not null`nullではない
- `where column between X and Y`:`X~Y`の範囲に含まれているか
- `in`: () の中の値のどれか
- `like`:部分一致
  - `%`:0文字以上のワイルドカード
    - `%endu%`:enduを含む
    - `%ですね`:ですねで終わる文字列
- `binaly`:SQLは大文字、小文字を区別できないが`binaly`演算子を使うと厳密に比較をしてくれる
- `_`:任意の文字を指定できる
  - `_e%`:名前の2文字目がeの人
- `order by`:並び替えを行う
  - `desc`:大きい順
  - `ask`:小さい順
- `limit`:件数を絞る
- `offset`:取得開始地点を指定ずる
