-- select * from users where score >= 3.0 and score <= 6.0;
select * from users where score between  3.0 and  6.0;
select * from users where name in('endu','koji');
-- 2文字目がnのnameを持つ値を取得する
select * from users where name like '_n%';
