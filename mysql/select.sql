-- select * from users where score >= 3.0 and score <= 6.0;
select * from users where score between  3.0 and  6.0;
select * from users where name in('endu','koji');
-- 2文字目がnのnameを持つ値を取得する
select * from users where name like '_n%';

-- スコアを小さい順に並べる
select * from users order by score;

-- nullを削除して大きい順にする
select * from users where score is not null order by score desc;

-- 最初の3件だけを取得する
select * from users limit 3;

-- 取得開始地点を3件目にして最初の3件だけを取得する
select * from users limit 3 offset 3;

-- スコアの上位3名を取得する
select * from users order by score desc limit 3;
