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
- mysqlのクエリ
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

### Update レコードの更新

```sql
update users set score = 5.7 where id = 1;
update users set name = 'tanaka', score = 6.0 where id = 1;
```

### Delete レコードの削除

全件削除

```sql
delete from users
```

スコアが5.0以下のレコードを削除する

```sql
 delete from users where score < 5.0;
```

### 数値計算

- `round(5.355)`:5
  - 四捨五入
- `round(5.355,1)`:5.4
  - 小数点 1 桁目で丸めたい場合
- `floor(5.355)`:5
  - 小数点以下切り捨てにできる
- `ceil(5.355))`:6
  - 小数点以下を切りあげ
- `round()`
　- 乱数

```sql
select round(5.355); -- 5
select round(5.355, 1); -- 5.4
select floor(5.833); -- 5
select ceil(5.238); -- 6
select rand();
```

スコアをランダムの値でソートして、一番上の値を抽出する

```sql
select * from users order by rand() limit 1;
```

### 文字列の演算

- `length`:長さを取得する
- `substr`:文字を切り取る
- `upper`:文字列を大文字にする
- `lower`:小文字にする
- `concat`:文字列を連結する


### enum型

複数の値から、1つだけが格納できるようにする
MySQL の設定にもよりますが、この中にある値以外をはじくことができます。また内部的には連番で振られているので、`1`や`2`で指定できる

enum型のtableを作成する

```sql
create table users (
  id int unsigned primary key auto_increment,
  name varchar(20),
  score float,
  rank enum('gold', 'silver', 'bronze')
);
```

### set型

複数の値から、複数の値を格納できるようにする
enumと違って複数入れられる。
挿入時に順番を変えたとしても、こちらの create table で定義した順番に戻っている。したがって抽出時にはこちらの順番を守りつつ条件を指定してあげる必要があります。


```sql
alter table users add column coins set('gold','silver','bronz')
insert into users (name, score, coins) values ('taguchi', 5.8, 'silver,gold');
insert into users (name, score, coins) values ('taguchi', 5.8, 'bronz,gold');
-- ERROR 1265 (01000): Data truncated for column 'coins' at row 1
insert into users (name, score, coins) values ('taguchi', 5.8, 'red,gold');

```

### if,case文

if文を使った例

```sql
-- if文で分岐する
select
    name,
    score,
    -- 5.0以上だったらOKでそれよりも下だったらNGになる
    if (score > 5.0 , 'OK' , 'NG' ) as result
from
    users;
```

結果

```sql
+---------+-------+--------+
| name    | score | result |
+---------+-------+--------+
| endu    |   5.8 | OK     |
| koji    |   5.7 | OK     |
| kikuchi |   4.9 | NG     |
| hoge    |     1 | NG     |
| tomita  |  0.28 | NG     |
| sakita  |     3 | NG     |
+---------+-------+--------+
```

case文の例

```sql
-- case文で分岐する
select
    name,
    score,
    -- 5.0以上だったらOKでそれよりも下だったらNGになる
    case floor(score) % 2
        -- 2で割れたら偶数
        when 0 then '偶数'
        -- 2で割られなかったら奇数
        when 1 then '奇数'
        else NULL
    end as type
from
    users;
```

結果

```sql
+---------+-------+--------+
| name    | score | type   |
+---------+-------+--------+
| endu    |   5.8 | 奇数   |
| koji    |   5.7 | 奇数   |
| kikuchi |   4.9 | 偶数   |
| hoge    |     1 | 奇数   |
| tomita  |  0.28 | 偶数   |
| sakita  |     3 | 奇数   |
+---------+-------+--------+
```


case文ではwhenの後直接、条件分岐がかける

```sql
select
    name,
    score,
    -- 5.0以上だったらOKでそれよりも下だったらNGになる
    case
        when score > 5.0 then 'Team-A'
        when score > 4.0 then 'Team-B'
        else 'Team-C'
    end as TeamName
from
    users;
```

結果

```sql
+---------+-------+----------+
| name    | score | TeamName |
+---------+-------+----------+
| endu    |   5.8 | Team-A   |
| koji    |   5.7 | Team-A   |
| kikuchi |   4.9 | Team-B   |
| hoge    |     1 | Team-C   |
| tomita  |  0.28 | Team-C   |
| sakita  |     3 | Team-C   |
+---------+-------+----------+
```

### 抽象結果で新しくテーブルを作成する


`select`で抽出した結果を別のtableとして生成する。

```sql
-- selectで抽出した結果を別のテーブルにする
create table users_with_team as
select
    id,
    name,
    score,
    -- 5.0以上だったらOKでそれよりも下だったらNGになる
    case
        when score > 5.0 then 'Team-A'
        when score > 4.0 then 'Team-B'
        else 'Team-C'
    end as TeamName
from
    users;

select * from users_with_team;
```

結果

```sql
+----+---------+-------+----------+
| id | name    | score | TeamName |
+----+---------+-------+----------+
|  1 | endu    |   5.8 | Team-A   |
|  2 | koji    |   5.7 | Team-A   |
|  3 | kikuchi |   4.9 | Team-B   |
|  4 | hoge    |     1 | Team-C   |
|  5 | tomita  |  0.28 | Team-C   |
|  6 | sakita  |     3 | Team-C   |
+----+---------+-------+----------+
```



また既存のtableもコピーする事ができる。

```sql
-- users tableをそのままコピーする
create table uses_copy select * from users;
select * from uses_copy;
```

結果

```sql
+----+---------+-------+
| id | name    | score |
+----+---------+-------+
|  1 | endu    |   5.8 |
|  2 | koji    |   5.7 |
|  3 | kikuchi |   4.9 |
|  4 | hoge    |     1 |
|  5 | tomita  |  0.28 |
|  6 | sakita  |     3 |
+----+---------+-------+
6 rows in set (0.00 sec)
```


それ以外だとtableの構造だけコピーをしたい時は`like`文だけを使うようにする。

```sql
-- テーブルの構造だけコピーしたい
create table users_empty like users;
desc users_empty;
```

結果

```sql
+-------+------------------+------+-----+---------+----------------+
| Field | Type             | Null | Key | Default | Extra          |
+-------+------------------+------+-----+---------+----------------+
| id    | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
| name  | varchar(20)      | YES  |     | NULL    |                |
| score | float            | YES  |     | NULL    |                |
+-------+------------------+------+-----+---------+----------------+
3 rows in set (0.00 sec)
```

### データの集計処理

- count():集計を行う
- avg():平均値を取る
- distinct:重複した値を消して

```sql
create table users (
    id int unsigned primary key auto_increment,
    name varchar(20),
    score float
);

insert into users(name,score)values
    ('endu',5.8),
    ('koji',null),
    ('kikuchi',4.9),
    ('hoge',1.0),
    ('hoge',.28),
    ('sakita',3.0)
;

--  重複するレコードを除く ユニークな値だけを取得する
select distinct name from users_with_team;
```

結果

```sql
+---------+
| name    |
+---------+
| endu    |
| koji    |
| kikuchi |
| hoge    |
| sakita  |
+---------+
5 rows in set (0.00 sec)
```

### grouoe by,having

- `groupe by`でグループ集計する事ができる。
- グルーピングした場合は`wherr`ではなく`having`で条件をつけるようにする
  - `having` を使う場合は、グループ化に使ったカラムや、集計した値しか条件に使えない。
- `where`と`groupe by`を両方使うと、最初に`where`文が優先される。

```sql
-- グループごとで集計を取る
select sum(score), TeamName from users_with_team group by TeamName;

--降順で
select sum(score), TeamName from users_with_team group by TeamName desc;

-- スコアが10よりも大きいチームだけを表示する
select sum(score), TeamName from users_with_team group by TeamName having sum(score) >10;
```

### サブクエリ

新しくテーブルを作らずに一時的な抽出結果の為の用意する

サブクエリーを使わないパターン

```sql
-- グループごとで集計を取る
-- サブクエリを使って新しくテーブルを作らずに集計する
select
    sum(t.score),
    t.TeamName
from
    (
    select
        id,
        name,
        score,
        -- 5.0以上だったらOKでそれよりも下だったらNGになる
        case
            when score > 5.0 then 'Team-A'
            when score > 4.0 then 'Team-B'
            else 'Team-C'
        end as TeamName
    from
        users
    ) as t
group by
  t.TeamName;
```

## view

viewとは抽出条件に名前を付けてテーブルのように扱うことができる。
ただし、view は抽出条件であって値のコピーをして新しいテーブルを作るわけではないので、おおもとになる users テーブルの値が変われば結果も当然変わります。

```sql
-- view(抽出条件に名前をつけてテーブルように扱えるようにする)
create view top3 as select * from users order by score desc limit 3;

-- 表示する
select * from top3;

-- 一覧を見る
show tables;
```

```sql
--  どうやってそのviewが作られたかを見る
show create view top3 \G;
```

結果

```sql
*************************** 1. row ***************************
                View: top3
         Create View: CREATE ALGORITHM=UNDEFINED DEFINER=`myapp_user`@`localhost` SQL SECURITY DEFINER VIEW `top3` AS select `users`.`id` AS `id`,`users`.`name` AS `name`,`users`.`score` AS `score` from `users` order by `users`.`score` desc limit 3
character_set_client: utf8
collation_connection: utf8
```

### transaction

一連の処理を必ずまとめて行いたい場合に使います。

変更を反映させる場合

```sql
start TRANSACTION;

-- 何らかのSQL

-- 変更を反映させる
COMMIT;
```

変更を破棄させる

```sql
start TRANSACTION;

-- 何らかのSQL

ROLLBACK;
```

### index(索引)

`index`をつけるとデータの抽出が速くなる。
`primary key` には必ず索引が作られます。
索引は抽出時は早いですが、データの追加や更新処理を行うたびに作り直されるので、そちらの処理が遅くなってしまうというデメリットがある。とはいえ、抽出処理が遅いな、と思ったら索引を付けたり外したりして、パフォーマンスを最適化できるようになっておくと良い。

- indexの追加
  - `alter table {table_name} add index {index_name} (column);`
- indexの削除
  - `alter table {table_name} drop index {index_name};`

```sql
-- indexを追加する
alter table users add index index_score (score);
show index from users\G;

-- その索引が使われているかはkeyで確認できる
explain
select * from users where score > 5.0\G;

-- 使ってない場合はnullになる
explain
select * from users where name = 'endu'\G;

-- 索引の削除
alter table users drop index index_score;
show index from users\G;
```

### 内部結合でデータを抽出する

- `inner join`:内部結合を行う
  - `2 つのテーブルに共通のデータだけを取得する方法`

```sql
select posts.id, title, comments.body from posts inner join comments on posts.id = comments.post_id
```

実行結果

```sql
+----+--------+----------------------------+
| id | title  | body                       |
+----+--------+----------------------------+
|  1 | title1 | first comment! for         |
|  1 | title1 | Secound comment! for post1 |
|  3 | title3 | Third comment3             |
|  4 | title4 | Yes!Yes!It me 4            |
+----+--------+----------------------------+
4 rows in set (0.00 sec)
```

### 外部結合

- `outer join`:外部結合を行う
  - `2 つのテーブルで一致しないデータも含めてデータを取得する方法になります。`

ただし、外部結合はどちらのテーブルを軸にするかで書き方が変わってくる

- `left outer join`
  - 左側のテーブルを軸にする
- `right outer join`
  - 右側のテーブルを軸にする

※outerは省略する事が可能です。

#### LeftJoin(左のテーブルを軸にします)

```sql
select * from posts left join comments on posts.id = comments.post_id;
```

実行結果

```sql

+----+--------+--------+------+---------+----------------------------+
| id | title  | body   | id   | post_id | body                       |
+----+--------+--------+------+---------+----------------------------+
|  1 | title1 | Hello! |    1 |       1 | first comment! for         |
|  1 | title1 | Hello! |    2 |       1 | Secound comment! for post1 |
|  3 | title3 | Yes!   |    3 |       3 | Third comment3             |
|  2 | title2 | Bye!   | NULL |    NULL | NULL                       |
+----+--------+--------+------+
```

#### Right Join(右側のテーブルを軸にします)

```sql
select * from posts right join comments on posts.id = comments.post_id;
```

```sql
+------+--------+--------+----+---------+----------------------------+
| id   | title  | body   | id | post_id | body                       |
+------+--------+--------+----+---------+----------------------------+
|    1 | title1 | Hello! |  1 |       1 | first comment! for         |
|    1 | title1 | Hello! |  2 |       1 | Secound comment! for post1 |
|    3 | title3 | Yes!   |  3 |       3 | Third comment3             |
| NULL | NULL   | NULL   |  4 |       4 | Yes!Yes!It me 4            |
```

### 外部キー制約

外部キー制約を使うと、`insert`をした時に関連したデータでなければ挿入できないように制限をかける事ができます。しかし外部キー制約を設定してしまうと、関連するデータがある場合にはデータの削除や更新が簡単にはできなくなります。


`comments` の `post_id` に関しては `posts` テーブルの `id` に値があるものだけしか挿入できなくなります。加えて、紐付ける`カラム`の型が一致していないといけないので、統一してあげる。

```sql
alter table comments add constraint fk_comments FOREIGN key (post_id) REFERENCES posts(id);
```

入れようとするとこんなエラーが出る

```sql
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`myapp`.`#sql-44e_10`, CONSTRAINT `fk_comments` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`))
```

外部キー制約を削除する

```sql
alter table comments drop foreigin_key fk_comments;
```
