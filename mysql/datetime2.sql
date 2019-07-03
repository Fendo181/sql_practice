drop table if exists posts;

create table posts (
    id int unsigned primary key auto_increment,
    title varchar(255),
    body text,
    created datetime default current_timestamp,
  updated datetime default current_timestamp on update current_timestamp
);

insert into posts(title,body)values
    ('title1','Hello!'),
    ('title2','Bye!'),
    ('title3','Yes!'),
    ('title4','Off Course!')
;

update posts set created = '2020-07-05 23:50:00' where id = 2;
select * from posts;

-- 条件指定で抽出する
select * from posts where created >'2020';

-- date_add で日付計算を行う
-- 14日を足す
select created,date_add(created, interval 14 day ) from posts;
-- 2週間追加する
select created,date_add(created, interval 2 week ) from posts;

-- データ・フォーマットを変更する
select created, date_format(created, '%W %M %Y') from posts;;


