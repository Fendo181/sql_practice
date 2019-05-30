drop table if exists users;
drop table if exists users_with_team;

create table users (
    id int unsigned primary key auto_increment,
    name varchar(20),
    score float
);

insert into users(name,score)values
    ('endu',5.8),
    ('koji',null),
    ('kikuchi',4.9),
    ('hoge',1.0),
    ('hoge',.28),
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

-- データの集計
select count(score) from users_with_team; -- 5
select count(*) from users_with_team; -- 6
select count(id) from users_with_team; -- 6

--  合計値を求める
SELECT avg(score) from users_with_team; -- 2.996000057458877

--  重複するレコードを除く ユニークな値だけを取得する
select distinct name from users_with_team;
