drop table if exists users;
drop table if exists users_with_team;

create table users (
    id int unsigned primary key auto_increment,
    name varchar(20),
    score float
);

insert into users(name,score)values
    ('endu',5.8),
    ('koji',null),
    ('kikuchi',4.9),
    ('hoge',9.2),
    ('hoge',.28),
    ('sakita',3.0)
;

-- すでにあれば削除する
drop view if exists top3;

-- view(抽出条件に名前をつけてテーブルように扱えるようにする)
create view top3 as select * from users order by score desc limit 3;


-- 表示する
select * from top3;

-- 一覧を見る
show tables;

--  どうやってそのviewが作られたかを見る
show create view top3 \G;


