drop table if exists posts;

create table posts (
    id int unsigned primary key auto_increment,
    title varchar(255),
    body text
);

insert into posts(title,body)values
    ('title1','Hello!'),
    ('title2','Bye!'),
    ('title3','Yes!'),
    ('title4','Off Course!')
;

drop table if exists comments;

create table comments (
    id int unsigned primary key auto_increment,
    post_id int not null,
    body text
);

insert into comments(post_id,body)values
    (1,'comment1!'),
    (2,'comment2'),
    (3,'comment3'),
    (4,'comment4')
;

select * from posts;
select * from comments;


