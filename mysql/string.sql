select length('Hello');  -- 5
select substr('Hello', 2); -- ello
select substr('Hello',2,3); -- ell
select upper('Hello'); -- HELLO
select lower('Hello'); -- hello
select concat('endo','futoshi'); -- endofutoshi

-- 名前の文字順で並び替え
select
    length(name) as '文字列の長さ',
    name
from users
    order by
length(name);

