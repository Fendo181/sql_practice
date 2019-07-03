drop table if exists posts;
drop table if exists logs;

create table posts (
    id int unsigned primary key auto_increment,
    title varchar(255),
    body text
);

create table logs(
    id int unsigned primary key auto_increment,
    msg varchar(255)
);

-- triggerを削除する
drop trigger if exists posts_update_trigger;

-- 区切り文字(//)を変更する
delimiter //
create
    trigger
        posts_update_trigger
after update
    on posts for each row
begin
     insert into logs(msg) values('post updated!');
    --  更新前のメッセージと更新後のメッセージを入れる
     insert into logs(msg) values(concat(old.title, '->',new.title));
end;
//

delimiter ;

insert into posts(title,body)values
    ('title1','Hello!'),
    ('title2','Bye!'),
    ('title3','Yes!'),
    ('title4','Off Course!')
;
-- triggerが出る
update posts set title = 'title2 updated!' where id = 2;

select * from posts;
select * from logs;
