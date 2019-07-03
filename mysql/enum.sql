drop table if exists users;

create table users (
    id int unsigned primary key auto_increment,
    name varchar(20),
    score float
);

alter table users add column rank enum('gold','silver','bronz') after score;
desc users;


insert into users (name, score, rank) values ('taguchi', 5.8, 'silver');
insert into users (name, score, rank) values ('taguchi', 5.8, 'red');  -- ERROR 1265 (01000): Data truncated for column 'rank' at row 1


-- enum型は内部で連番で入る為
select * from users where rank = 2;

select * from users;

