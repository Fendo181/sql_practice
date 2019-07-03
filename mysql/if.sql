drop table if exists users;

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

-- if文で分岐する
select
    name,
    score,
    -- 5.0以上だったらOKでそれよりも下だったらNGになる
    if (score > 5.0 , 'OK' , 'NG' ) as result
from
    users;

-- case文で分岐する
select
    name,
    score,
    -- 5.0以上だったらOKでそれよりも下だったらNGになる
    case floor(score) % 2
        -- 2で割れたら偶数
        when 0 then '偶数'
        -- 2で割られなかったら奇数
        when 1 then '奇数'
        else NULL
    end as type
from
    users;


-- case文ではwhenの後直接、条件分岐がかける
select
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
