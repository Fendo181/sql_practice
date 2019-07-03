-- tableにデータがあったら削除して再度いれる
TRUNCATE table users;

-- データを挿入する
insert into users(name,score)values
    ('endu',5.8),
    ('koji',5.7),
    ('kikuchi',4.9),
    ('hoge',1.0),
    ('tomita',.28),
    ('sakita',3.0)
    ;


select * from users;
