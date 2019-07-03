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

-- グループごとで集計を取る
-- サブクエリを使って新しくテーブルを作らずに集計する
select
    sum(t.score),
    t.TeamName
from
    (
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
        users
    ) as t
group by
  t.TeamName;
