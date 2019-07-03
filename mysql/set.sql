drop table if exists users;

create table users (
    id int unsigned primary key auto_increment,
    name varchar(20),
    score float
);

alter table users add column coins set('gold','silver','bronz') after score;
desc users;


insert into users (name, score, coins) values ('taguchi', 5.8, 'silver,gold');
insert into users (name, score, coins) values ('taguchi', 5.8, 'bronz,gold');
-- ERROR 1265 (01000): Data truncated for column 'coins' at row 1
insert into users (name, score, coins) values ('taguchi', 5.8, 'red,gold');

select * from users;

-- ser型は抽出時に順番を守る必要がある
select * from users where coins = 'gold,silver';
-- もしくはlike文で正規表現で抽出する
select * from users where coins like '%gold%';





