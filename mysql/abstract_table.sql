drop table if exists users;
drop table if exists users_with_team;
drop table if exists uses_copy;
drop table if exists users_empty;

create table users (
    id int unsigned primary key auto_increment,
    name varchar(20),
    score float
);

insert into users(name,score)values
    ('endu',5.8),
    ('koji',5.7),
    ('kikuchi',4.9),
    ('hoge',1.0),
    ('tomita',.28),
    ('sakita',3.0)
;

-- selectで抽出した結果をテーブルにする

create table users_with_team as
select
    id,
    name,
    score,
    -- 5.0以上だったらOKでそれよりも下だったらNGになる
    case
        when score > 5.0 then 'Team-A'
        when score > 4.0 then 'Team-B'
        else 'Team-C'
    end as TeamName
from
    users;

select * from users_with_team;

-- users tableをそのままコピーする
create table uses_copy select * from users;
select * from uses_copy;

-- テーブルの構造だけコピーしたい
create table users_empty like users;
desc users_empty;
