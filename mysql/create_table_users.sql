-- 存在していたら削除を行う
drop table if exists users;

create table users (
    id int unsigned primary key auto_increment,
    name varchar(20),
    score float
);

-- nameカラムの後ろに新しくemailカラムを追加する
alter table users add column email varchar(255) after name;
-- scoreカラムを削除する
alter table users drop column score ;
-- nameの名前や属性を変更する
alter table users  name user_name varchar(80) default 'nobody';

desc users;

-- tableの名前を変更する
alter table users rename persons;
show tables;
drop table if exists persons;
