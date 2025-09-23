## where 서브쿼리  중첩서브쿼리 
## 다중행연산자
## 다중값 서브쿼리 하기전 
### 다중행 연산자
### IN - 임의의 값과 동일한 조건 검색 
### ALL - 모든 값을 만족하는 조건 검색 
### ANY - 존재하는 어느 하나의 값이라도 만족하는 조건 검색
### EXISTS - 결과를 만족하는 값이 존재하는지 여부만 확인 (있냐 없냐!?) 

select avg(price) from buy;
select * from buy
where price > 50;

## 단일행
## 1행만 반환되는 쿼리 

select * from buy
where price > (select avg(price) from buy);

##단일행 꼭 필요한 경우 = 
## 가장 적게 주문을 한 mem_id buy 에서 추출
## mem_id 별로 주문을 몇 개 한거야!?\
## 집계 -> group by 
-- select min(mem_id) from buy;
select * from buy
where mem_id = ( 
	select 
	mem_id
	from 
		buy
	group by mem_id
	order by count(mem_id) asc
	limit 1);
    

## select * from buy;
### 다중행 
## Error Code: 1242. Subquery returns more than 1 row
## in 다중행 비교 연산자 바꾸기

-- Error Code: 1235. This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'

select * from buy
where mem_id in ( 
	select 
	mem_id
	from 
		buy
	group by mem_id
	order by count(mem_id) asc);

## 다른 테이블 값을 다중행 서브쿼리로 사용
## 멤버 중에 멤버수가 4명 이상인 사람들의 주문 제품을 알고 싶다!
## not in 은 반대의 값
select * from buy
where mem_id in (
select 
	mem_id
from 
	member
where mem_number >=4
);


## any 
## 서브 쿼리 결과에서 하나라도 만족하는 조건으로 데이터를 조회할 수 있다.
## 비교 연산자를 잘못 사용한 것 같이 보일 수 있지만 -> any 사용하면 결과 값이 여러 개여도 일치하는 모든 행을 주 쿼리에서 실행할 수 있다.
-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'any( select mem_id from member where mem_number <=5) -- select  --  mem_id     -' at line 2

select * from buy
where mem_id = any (
select mem_id from member
where mem_number <=5);
-- select 
-- 	mem_id    
-- from 
-- 	member
-- where mem_number >=4;

## EXISTS - 결과를 만족하는 값이 존재하는지 여부만 확인 (있냐 없냐!?) 
## 서브쿼리의 결과값이 있는지 없는지 확인을 한다. 서브쿼리 결과가 1행 이라도 있어 True 없다 False 
## 주 쿼리 여부가 출력이 된다.

select mem_id, mem_name from member
where not exists(select * from buy
where price >= 8000);

select mem_id, mem_name from member
where exists(select * from buy
where price <= 8000);



## 주문한 사람이 8,000원 이상이 있으면 그럼 주 쿼리를 실행해!
-- select * from buy
-- where price >= 8000;

## 전체 주문한 금액이 평균 주문 금액 이상인 mem_id 데뷔 일자를 출력하시오!
## buy - 전체 주문금액 중 평균 주문금액 이상인 mem_id 
## -> mem_id  Join -> member -> debut_date 필요하다.
select * from buy;
select * from member;

-- Error Code: 1054. Unknown column 'debut_date' in 'field list'
-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'join member as m on b.mem_id = m.mem_id' at line 6
select 
	b.mem_id,
    m.debut_date
from (
select
	b.mem_id as mem_id
from buy as b
where price >= (select avg(price) from buy) 
) as b
join member as m 
on m.mem_id = b.mem_id;