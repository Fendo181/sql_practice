-- データを挿入する
insert into users(name,score)values
    ('endu',5.8),
    ('koji',5.7),
    ('kikuchi',5.9),
    ('hoge',null);

insert into users(name)values('tanaka');
-- Duplicate entry 'tanaka' for key 'name'
insert into users(name)values('kenichi');

select * from users;
