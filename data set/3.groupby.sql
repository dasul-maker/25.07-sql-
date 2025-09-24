select * from member;

select * from buy;

## gruopby 문법을 사용해서 주문 테이블에서 mem_id 별로 count() 를 통해 몇 개의 값이 있는지 확인하자!
## 23:14:21	select  * from   buy group by mem_id LIMIT 0, 1000	Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'market_db.buy.num' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	0.0015 sec

## 주의해야 할 점
## groupby 할시 묶은 컬럼으로 지정을 해서 값을 봐야한다. 
## 지정하지 않은 컬럼을 select에 적으면 에러가 난다!

select
	mem_id
	-- prod_name
from 
	buy
group by mem_id, prod_name;
# Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'market_db.buy.prod_name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

select
	mem_id,
    price
	-- prod_name
from 
	buy
group by mem_id;

## Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'market_db.buy.price' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

-- select
-- 	*
-- from 
-- 	buy
-- group by mem_id;


## mem_id 카운팅

select 
	mem_id,
    count(*),
    sum(price),
    avg(price)
from
		buy
group by mem_id;

## 2개 이상 그룹바이 가능하다.

select 
	mem_id,
    prod_name,
    count(*),
    sum(price),
    avg(price)
from 
	buy
group by mem_id, prod_name;


## having 추가
## count() 2개 이상인 경우만 추출! 
select 
	mem_id,
    prod_name,
    count(*),
    sum(price),
    avg(price)
from 
	buy
group by mem_id, prod_name
having count(*)>1;

## price, amount를 곱해서 tot amount를 만들기!
## (tot amount) 주문금액이 특정 금액 이상인 경우, 특정 Mem_id만 추출해서 값을 확인하자!
select 
	mem_id,
	sum(price * amount)  as total_amount
from 
	buy
group by 
 	mem_id
having 
	total_amount>1000 
and 
	mem_id like '%B%';



### inner join
### 저희 주문 데이터를 지역별로 봤을 때 지역별로 total amount 금액은 얼마입니까!?
### 1. 공통된 컬럼은 mem_id 
### 2. 내가 원하는 컬럼은? price, amount 곱해서 total_amount 필요함 -> buy테이블에 있음
### 2. 지역에 대한 컬럼은? addr -> member 테이블에 있음
### 어떤 테이블을 기준으로 잡는 게 좋을까!?
### -> 추가질문 
### -> 공통된 컬럼 둘다 유니크하니? -> 중복값 존재하니!?
### member 
select * from member;
select * from buy;

## Error Code: 1052. Column 'mem_id' in field list is ambiguous

select 
	m.mem_id,
	m.addr,
    b.price,
    b.amount
from member as m
inner join buy as b 
on m.mem_id = b.mem_id;


select * from buy;
-- '1','BLK','지갑',NULL,'30','2'
-- '2','BLK','맥북프로','디지털','1000','1'
-- '3','APN','아이폰','디지털','200','1'
-- '4','MMU','아이폰','디지털','200','5'
-- '5','BLK','청바지','패션','50','3'
-- '6','MMU','에어팟','디지털','80','10'
-- '7','GRL','혼공SQL','서적','15','5'
-- '8','APN','혼공SQL','서적','15','2'
-- '9','APN','청바지','패션','50','1'
-- '10','MMU','지갑',NULL,'30','1'
-- '11','APN','혼공SQL','서적','15','1'
-- '12','MMU','지갑',NULL,'30','4'

## 추가 마무리를 하기 위해서는
select 
	m.addr,
--     b.price,
--     b.amount,
    sum(b.price * b.amount) as total_amount
from member as m
inner join buy as b 
on m.mem_id = b.mem_id
group by m.addr
having total_amount >1000;



select 
	count(*)
from member as m
inner join buy as b 
on m.mem_id = b.mem_id;

select count(*) from member;

select count(*) from buy;


select 
	*
from member as m
left join buy as b 
on m.mem_id = b.mem_id;


-- select * from customers;
