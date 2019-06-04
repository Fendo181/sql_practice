drop table if exists users;
drop table if exists users_with_team;

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

-- グループごとで集計を取る
select sum(score), TeamName from users_with_team group by TeamName;

--降順 で表示する
select sum(score), TeamName from users_with_team group by TeamName desc;

-- groupe byで集計した値に関してはhavingで条件付けを行う
-- スコアが10よりも大きいチームだけを表示する
select sum(score), TeamName from users_with_team group by TeamName having sum(score) >10;


