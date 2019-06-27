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
    (3,'Third comment3'),
    (4,'Yes!Yes!It me 4')
;

-- 外部キー制約を付与させる
alter table comments add constraint fk_comments FOREIGN key (post_id) REFERENCES posts(id);
select * from comments;
