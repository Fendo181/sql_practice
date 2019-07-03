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
drop trigger if exists posts_insert_trigger;

-- triggerを作る
-- postsにinsertを走った時にそれぞれのレコードにinsert文を実行する
create
    trigger
        posts_insert_trigger
after insert
    on posts for each row
        insert into logs(msg) values('post add');

insert into posts(title,body)values
    ('title1','Hello!'),
    ('title2','Bye!'),
    ('title3','Yes!'),
    ('title4','Off Course!')
;


select * from posts;
select * from logs;

-- トリガー一覧を表示する
show TRIGGERS \G;
