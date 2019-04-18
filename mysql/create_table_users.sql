-- 存在していたら削除を行う
drop table if exists users;

create table users (
    id int unsigned primary key auto_increment,
    name varchar(20) unique,
    score float default 0.5
);
