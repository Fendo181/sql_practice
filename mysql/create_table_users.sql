-- 存在していたら削除を行う
drop table if exists users;

create table users (
    id int unsigned,
    name varchar(20),
    score float default 0.5
);
