-- 存在していたら削除を行う

drop table id exxists users;

create table users (
    id int unsigned,
    name varchar(20),
    score float
);
