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
