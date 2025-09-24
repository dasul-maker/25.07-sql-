## Join 정리 

select * from buy;

select * from member;

## left join 

select 
-- count(*)
m.mem_id,
b.mem_id,
prod_name
from member as m # 10명 
left join buy as b # 12명인데 4명이 유니크
on m.mem_id = b.mem_id;

# 기존에 buy에 중복인 12 + (전체 Member 10 - buy 유니크한 수 4) = 6
# 18의 근거는 12 + 6 = 18 이거구나!
select 
count(mem_id),
count(distinct mem_id)
from buy b;

select 
mem_id,
count(mem_id),
count(distinct mem_id)
from buy b
group by mem_id;

select 
-- count(mem_id),
mem_id
from buy b;



select 
-- count(*)
m.mem_id,
b.mem_id,
prod_name
from buy as b # 10명 
left join member as m # 12명인데 4명이 유니크
on m.mem_id = b.mem_id;


select 
count(*)
-- m.mem_id,
-- b.mem_id,
-- prod_name
from buy as b # 10명 
left outer join member as m # 12명인데 4명이 유니크
on m.mem_id = b.mem_id;



select 
-- count(*)
m.mem_id,
b.mem_id
-- prod_name
from buy as b # 10명 
left outer join member as m # 12명인데 4명이 유니크
on m.mem_id = b.mem_id;


select 
count(*)
-- m.mem_id,
-- b.mem_id
-- prod_name
from member as m # 10명 
left outer join buy as b # 12명인데 4명이 유니크
on m.mem_id = b.mem_id;

select count(*) from member;
select * from buy;

### BDA 추가
select 
count(*)
-- m.mem_id,
-- b.mem_id,
-- prod_name
from member as m # 11명 
left join buy as b # 12명인데 4명이 유니크
on m.mem_id = b.mem_id;


select 
	*	
-- m.mem_id,
-- b.mem_id,
-- prod_name
from member as m # 10명 
left outer join buy as b # 12명인데 4명이 유니크
on m.mem_id = b.mem_id;


select 
	*	
-- m.mem_id,
-- b.mem_id,
-- prod_name
from member as m # 10명 
inner join buy as b # 12명인데 4명이 유니크
on m.mem_id = b.mem_id;


## left join, left outer 같은 것 아닌가요?

## full outer는 Mysql 작동이 안 된다.

-- select 
-- 	*	
-- -- m.mem_id,
-- -- b.mem_id,
-- -- prod_name
-- from member as m # 10명 
-- full outer join buy as b # 12명인데 4명이 유니크
-- on m.mem_id = b.mem_id;


## 3개를 join해 보자!
select 
	count(*)
from (
select 
	b.mem_id as buy_id,
    m.mem_id as mem_id
from member as m # 11명 
inner join buy as b # 12명인데 4명이 유니크 = member unique 11개 근데 buy 중복 포함 12개 근데 inner join 둘이 같은 것만 4개 => 4명이 12개 중복 
on m.mem_id = b.mem_id) 
as total
right outer join member as m # 11명 
on total.buy_id = m.mem_id; # total 4명 -> 7명이 아직 안 나옴
-- right outer join member as m
-- on m.mem_id = b.mem_id;
## 12+7  = 19

select count(*) from member as m;
## 전체 멤버는 11 - 4 = 7
## 12 + 7 = 19

select 
	*
	-- count(distinct b.mem_id)
	-- b.mem_id as buy_id,
--     m.mem_id as mem_id
from member as m # 10명 
inner join buy as b # 12명인데 4명이 유니크
on m.mem_id = b.mem_id;

select * from member;
select * from buy;
###
-- left , right, left outer, right outer, inner 개념을 이해함!
-- 단 지금은 이해했다. -> 복습!
### 
-- Error Code: 1052. Column 'mem_id' in field list is ambiguous

### 교차조인 CROSS JOIn 
select 
	*
from member as m 
cross join buy as b
 where m.mem_id = 'WMN';

## 왜 cross join 132개지? -> 스스로 과제
## 11 * 12 
## 모두 다 곱 
