-- 存在していたら削除を行う
drop table if exists users;

create table users (
    id int unsigned primary key auto_increment,
    name varchar(20),
    score float
);

-- フィールドの属性を後から追加する

alter table users add column email varchar(255);

desc users;
