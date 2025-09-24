## from 절에 들어가는 서브쿼리 (인라인뷰)
## from에 들어간다 -> table 테이블이 들어간다!
## from에 서브쿼리를 한다 -> 테이블을 만든다.
## 내가 원하는 테이블을 커스텀해서 만들 수 있다.
## 임시 테이블을 만든다 -> 가상의 테이블을 직접 만들어 준다. 

## 복잡한 로직을 미리 짜서 메인 쿼리를 간단하고 명확하게 만든다.
## 집계, 그룹기반의 연산 필요 후 -> 데이터 추출해야 하는 데 집계된 테이블로 조인이나 조회를 해야 한다.
## 순위나 등등 서브쿼리로 필터링이나 정렬 등 진행하고 사용할 수도 있다.
select 
	* 
from member;

select *from buy;

## buy의 테이블의 mem_id별 price sum을 확인하고, amount sum 확인하고 mem_id의 사는 지역과 멤버 수를 알고 싶다.
## buy의 집계 -> group by -> 테이블에 mem_id 사는 지역과 멤버 수 

## 서브쿼리를 사용하지 않고 진행
-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'join member as m  on b.mem_id = m.mem_id' at line 7

select 
	b.mem_id,
    sum(price),
    sum(amount),
    addr,
    mem_number
from buy as b
join member as m on b.mem_id = m.mem_id
group by mem_id;


select 
	m.mem_id,
	m.addr,
    m.mem_number,
    price,
    amount
from 
	member as m
join (
select 
	b.mem_id,
    sum(price) as price,
    sum(amount) as amount
from
	buy as b
group by mem_id
) as b 
on m.mem_id = b.mem_id;

## member 중에서 데뷔 일자가 2015-04-21 멤버를 추출하고 싶고, 그 멤버의 평균 키를 구하고 싶다. 
select 
	avg(height)
from(
	select 
		mem_id,
		height,
        debut_date
	from 
		member
	where debut_date = '2015-04-21'
) as apr_member ;


### 스칼라 서브쿼리
### select 절 - 행이나, 값을 반환하는 느낌
### select 들어가는 서브쿼리 -> 각 행마다 독립적으로 실행되는 쿼리 
### 스칼라 서브쿼리는 하나의 값만 반환해야 한다! , 각 행마다 값을 계산하여 컬럼처럼 붙여 쓴다.
### 셀 하나에 들어갈 값을 쿼리로 계산해서 붙인다!

### Why using scalr
### 1. 행마다 다른 계산이 필요한 경우? 평균, 합산 
### 2. join 하지 않아도 쉽게 간단한 값을 계산할 수 있다.
### 3. 쿼리를 쪼개지 않고 select 안에 바로 사용 가능


select 
	mem_id,
    (select sum(price) from buy as b where )
from buy;
## MEm_id 의 price는 sum, amount sum을 해보자!

## member 테이블에 있는 mem_id의 각각의 주문과 PRICE 알고 싶다!
select 
	m.mem_id,
	(select sum(price) from buy as b where b.mem_id = m.mem_id),
    (select sum(amount) from buy as b where b.mem_id = m.mem_id)
from 
	member as m;

select 
	m.mem_id,
    price,
    amount
from 
	member as m
left join(
select 
	mem_id,
    sum(price) as price,
    sum(amount) as amount
 from buy
group by mem_id
) as b
on m.mem_id = b.mem_id;
	
### 서브쿼리 복습
### 중첩 서브쿼리 - where 값을 비교하는 형태, 값을 비교하는 것 , 단일값과 다중값 -> 단일, 다중을 쿼리로 미리 만들어서 where 안에 비교하는 느낌!
### 인라인 뷰 서브쿼리 - from  테이블 느낌 : 내가 원하는 테이블을 미리 집계하거나, 추출하거나 해서 사용하는 것 -> 주 쿼리 좀 더 효율적으로 사용하기 위해 서브쿼리 먼저 작동
### 스칼라 서브쿼리 - Select : 행마다 다른 계산 필요시 -> 쉽게 join 없이 바로 진행할 수 있었다.

### 머릿 속에서 정리해야 하는 구조
### select 
### from 
### where 


-- select * from buy;
-- select * from member;
## CTE (Common Table Expression, CTE)
## 자주쓰는 테이블은 재활용을 할 수 있다. 
## 계속 동일하게 불러오는 테이블이 존재할 수 있다.
## 고객의 퍼널 분석, 고객의 코호트 분석, 고객의 주문 , 고객의 ㅇ다양한 여정 분석 
## 고객의 주문에 대한 테이블은 꼭 사용!
## CTE는 복잡한 쿼리들을 사용할 때 구조에서 꼭 사용하는 문법

## 문제 
## 멤버가 -> 멤버수가 5명 이상 서울에 거주한 멤버, 경기에 거주하는 멤버 따로따로 추출하고 싶다.
## 멤버들 중에서 아이폰, 맥북프로 구매한 멤버, 이 멤버들의 주문 금액(price)과 amount(주문수량)을 확인하려고 한다.

with s_member as (
	select 
		*
    from 
		member
	where 
		addr = '서울'
	and
		mem_number >=5)
, non_s_member as (
	select 
		*
	from
		member
	where 
		addr != '서울'
	and
		mem_number >=5
)
-- select * from non_s_member
select * from s_member;
        

select * from s_member;
-- select * from buy;
-- select * from member;

USE classicmodels;

select * from customers;
select * from orders;
select * from orderdetails;

-- select 
-- 	(서브쿼리) - 독립적으로 실행 각행 마다
-- 	addr,
--     mem_number
-- from member;

-- 'MMU','전남','4','340','20'
-- 'GRL','서울','8','15','5'
-- 'BLK','경남','4','1080','6'
-- 'APN','경기','6','280','5'


-- 'MMU','전남','4','340','20'
-- 'GRL','서울','8','15','5'
-- 'BLK','경남','4','1080','6'
-- 'APN','경기','6','280','5'
