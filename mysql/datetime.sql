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

select * from posts;
update posts set title = 'title3 updated!' where id = 2;
select * from posts;
