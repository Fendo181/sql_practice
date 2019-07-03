drop table if exists users;

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
