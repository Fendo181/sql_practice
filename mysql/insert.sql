-- データを挿入する
insert into users(id,name,score)values
    (1,'endu',5.8),
    (2,'koji',5.7),
    (3,'kikuchi',5.9),
    (4,'hoge',null);

insert into users(id,name)values(4,'tanaka');

select * from users;
