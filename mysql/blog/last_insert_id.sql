drop table if exists posts;

create table posts (
    id int unsigned primary key auto_increment,
    title varchar(255),
    body text
);

insert into posts(title,body)values
    ('title1','Hello!'),
    ('title2','Bye!'),
    ('title3','Yes!')
;

drop table if exists comments;

create table comments (
    id int unsigned primary key auto_increment,
    post_id int unsigned not null,
    body text
);

insert into comments(post_id,body)values
    (1,'first comment! for'),
    (1,'Secound comment! for post1'),
    (3,'Third comment3')
;

select * from comments;
select * from posts;

-- postsからid2のレコードを削除する
delete from posts where id = 2;

INSERT into posts (title,body) VALUES
(
    'new title',
    'new body'
);

INSERT into comments (post_id,body) values
(
    last_insert_id(), 'first comment for new post'
)
;

select * from comments;
select posts.id, title, comments.body from posts inner join comments on posts.id = comments.post_id;
