## CTE Common Table Expression)
## with  ~~ 임시 테이블 만들고 -> 주쿼리에 다시 참조하여 사용하는 방
## 가독성 향상 
## 서브쿼리를 여러번 쓰거나 이런 필요 없이 재사용 가능 
## 다양한 재귀커리 구현 
## 디버깅에도 좋다! 재활용도 좋고! 

## union 
## 두 쿼리의 결과를 합치는 건데 중복을 제거
## union all
## 두 쿼리의 결과를 합치는 건데 중복을 제거하지 않음 (모든 행을 출력)


## custoemr, orders , orderdetails, products 
## 중복인지 중복이아닌지 체크해서 메타데이터에 중복된 정보가 있는지 확인하고, 테이블 로직을 체크하자!

select * from customers;
-- 두 가지 
-- distinct
select count(distinct(customerNumber))
	, count(customerNumber)
from customers; 
-- group by
select 
count(customerNumber)
from customers
group by customerNumber
having count(customerNumber)>1;


## order table 중복 없다!
-- select * from orders;
select count(distinct(orderNumber))
	, count(orderNumber)
from orders; 

select * from orderdetails;

select count(distinct(orderNumber))
	, count(orderNumber)
from orderdetails; 


## 질문!
select * from customers;
select * from orders;
select * from orderdetails;

## status 가 Shipped 된 주문 중에서 -> 가장 높은 주문 금액을 가진 고객의 이름을 그리고 휴대전화번호를 알고 싶다.
## 해당 고객에게 1:1 CRM 연락을 통해 VIP 초청 초대장을 보내고 싶다!

## 내가 원하는 아웃풋 결과물 -> 고객의 이름, 고객의 휴대전화번호
## 조건이 있다: 
## 1. status shipped 된 주문!
## -- 1번의 조건은 orders 테이블의 status = Shipped  
## 2. 가장 높은 주문 금액 
## -- 2번의 조건 orderdetails quantityOrdered * priceEach 전체 주문금액
## 문제는 쿼리를 짜야 한다.
## 내가 필요한 테이블과 컬럼 정하기!
## 필요한 컬럼은 - customers name, customers phone 둘 다 customers 테이블의 존재 
## 1번조건은 -> orders 필요 컬럼은 status
## join 하려면? -> customers.customerNumber join orders.customerNumber 조인해야 한다.
## 2번 조건은 -> orderdetails 컬럼은 orderdetails quantityOrdered * priceEach 전체 주문금액
## join 하려면? -> orders 컬럼 orderNumber, orderDetails orderNumber 조인 해야 한다.

## join 전 중요한 포인트
## left right 어떤 걸 기준으로 두면 좋을까요~?

## 쿼리 join에 대한 검증을 해야 한다!
## 검증 조건은 무엇이 있을까?!
## 1. 전체 행이 틀어졌나?
## max(orders) 행이나, max(customers) 행이나 >= join 행이 넘으면 안 된다.
## = 같은 수가 나오면 완벽히 다 일치하는 것
## 작은 수가 나오면 -> 둘 로직에 따라 하나의 테이블에만 공통인게 존재한 것 
## customer 테이블의 전채 카운팅 122개
## orders 326개 
## 전체 조인 수는 326개 

## 좀 더 뎁스있게 뜯어보자!
## customer join key를 살펴보자!

select count(*) from customers;
select count(*) from orders; 

select 
	count(*)
from 
	orders as o
join 
	customers as c
on o.customerNumber = c.customerNumber;

## 326개 326개 98개 98개
    
-- select 
-- 	*
	-- count(c.customerNumber),
--     count(o.customerNumber),
--     count(distinct o.customerNumber),
--     count(distinct c.customerNumber)
-- from 
-- 	orders as o
-- join 
-- 	customers as c
-- on o.customerNumber = c.customerNumber
-- where o.customerNumber = 114;
        
## 다시 문제를 풀어봅시다!!        
## status 가 Shipped 된 주문 중에서 -> 가장 높은 주문 금액을 가진 고객의 이름을 그리고 휴대전화번호를 알고 싶다.
## 해당 고객에게 1:1 CRM 연락을 통해 VIP 초청 초대장을 보내고 싶다!

select 
c.customerName,
c.phone
-- o.customerNumber
-- 	 o.customerNumber,
--      sum(od.quantityOrdered * od.priceEach) as total_sales
from 
	orders as o
join 
	customers as c
on o.customerNumber = c.customerNumber
join 
	orderdetails as od
on o.orderNumber = od.orderNumber
Where o.status = 'Shipped'
group by o.customerNumber
order by sum(od.quantityOrdered * od.priceEach) desc
limit 1;

--  

-- select * 

-- from
-- (
-- select 
-- 	c.customerName,
-- 	c.phone,
-- 	o.customerNumber,
--     sum(od.quantityOrdered) as total_ord,
--     sum(od.priceEach) as total_pr
-- from 
-- 	orders as o
-- join 
-- 	customers as c
-- on o.customerNumber = c.customerNumber
-- join 
-- 	orderdetails as od
-- on o.orderNumber = od.orderNumber
-- Where o.status = 'Shipped'
-- group by o.customerNumber
-- order by sum(od.quantityOrdered * od.priceEach) desc )


## 왜 더블링이 되냐 ? 중복으로 수가 늘어나는가?
## Ourder number 기준 10100

-- select * from orders
-- where orderNumber = 10100;

-- select * from customers
-- where customerNumber = 363;
-- select * from orderdetails
-- where orderNumber = 10100;
-- SElect * from orders;
-- select
-- 	customerName,
--     phone
-- from
-- 	customers as c;

## union, union all 

## 2003-01 주문수
## 2003-01 그룹바이 집계
## orderDate 문자열 substring
select 
	substring(orderDate,1,7) as ord_ym,
	count(orderNumber) as ord_cnt
    -- '안녕?' as ord_str
from 
	orders
where substring(orderDate,1,7) = '2003-01'
group by substring(orderDate,1,7)

union all

select 
	substring(orderDate,1,7) as ord_ym,
	count(orderNumber) as ord_cnt
from 
	orders
where substring(orderDate,1,7) = '2003-02'
group by substring(orderDate,1,7);


## Error Code: 1222. The used SELECT statements have a different number of columns

## 2003-02 주문수
-- select  * from orders;

## 주문을 상위 5명 주문 수 
## 주문을 하위 5명 주문 수 
## 상위와 하위의 주문 수의 평균 주문 금액이 각각 서로 얼마인지? 출력하는 쿼리를 짜보자!

## CTE 상위 5명 
## CTE 하위 5명
## 상위 table, 하위 table group by -> 평균
## union all로 붙여서 테이블 비교하기 

## CTE 상위 5명 주문 만들기 

with top_5 as (
select 
	'상위5명' as cus_group,
	o.customerNumber,
	sum(od.quantityOrdered * od.priceEach) as total_sales
from 
	orders as o
join 
	customers as c
on o.customerNumber = c.customerNumber
join 
	orderdetails as od
on o.orderNumber = od.orderNumber
Where o.status = 'Shipped'
group by o.customerNumber
order by sum(od.quantityOrdered * od.priceEach) desc
limit 5 ), 
## 하위 5명
bottom_5 as (select 
	'하위5명' as cus_group,
	o.customerNumber,
	sum(od.quantityOrdered * od.priceEach) as total_sales
from 
	orders as o
join 
	customers as c
on o.customerNumber = c.customerNumber
join 
	orderdetails as od
on o.orderNumber = od.orderNumber
Where o.status = 'Shipped'
group by o.customerNumber
order by sum(od.quantityOrdered * od.priceEach) asc
limit 5),
top_5_avg as (
	select 
	cus_group,
    avg(total_sales)
    from 
		top_5
	group by cus_group),
bottom_5_avg as (
	select 
	cus_group,
    avg(total_sales)
    from 
		bottom_5
	group by cus_group)    
select * from bottom_5_avg

union all 

select * from top_5_avg;


-- select * from customers;
-- select * from orders;
