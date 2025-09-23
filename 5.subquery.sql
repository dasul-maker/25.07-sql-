select * from member;

## cross join 
## 전체의 경우의 수가 곱해진다.

select 
	m1.mem_id,
    m1.addr,
    m1.mem_name
from
	member m1
cross join member m2
where m1.mem_id = 'WMN';

-- Error Code: 1248. Every derived table must have its own alias

-- select count(mem_id) from member ;
-- 11

select 
	m1.mem_id,
    m1.addr,
	m1.mem_name,
    b1.price
from
	member m1
cross join buy b1
where m1.mem_id = 'BLK';
-- 전체 카운트 12

select * from buy;
select count(*) from member;

## 11*12 = 132 

## 가격 출처'30'





-- 'WMN','경기','여자친구','30' 
-- 'WMN','경기','여자친구','1000'
-- 'WMN','경기','여자친구','200'
-- 'WMN','경기','여자친구','200'
-- 'WMN','경기','여자친구','50'
-- 'WMN','경기','여자친구','80'
-- 'WMN','경기','여자친구','15'
-- 'WMN','경기','여자친구','15'
-- 'WMN','경기','여자친구','50'
-- 'WMN','경기','여자친구','30'
-- 'WMN','경기','여자친구','15'
-- 'WMN','경기','여자친구','30'


-- '30'
-- '1000'
-- '200'
-- '200'
-- '50'
-- '80'
-- '15'
-- '15'
-- '50'
-- '30'
-- '15'
-- '30'
## 금액이 있는 그룹은?


select 
	m1.mem_id,
    b1.mem_id,
    m1.addr,
	m1.mem_name,
    b1.price
from
	member m1
cross join buy b1;

#### self join
## 자기 자신을 Join
## 동일한 테이블을 join하는 개념 
## 별칭을 사용해야 한다!


## 방금 보여주신 self join과, member a에 member b를 cross join하고 on a.member_id = b.member_id 하는 것과 차이가 있나요?
select 
	a.mem_id,
    b.mem_id
from
	member a
inner join member b on a.mem_id = b.mem_id;

select * from member;    

### 쿼리 안에 또 다른 쿼리, 서브쿼리 
### 쿼리 속 쿼리 
### 서쿼리는 위치에 따라 다양하게 부른다.
### 중첩 서브쿼리  where 절
### 스칼라 서브쿼리  select 절
### 인라인 뷰 서브쿼리  from 절

### 서브쿼리 특징 
### 반드시 (서브쿼리) 감싸서 사용한다.
### 서브쿼리는 실행전 1번만 수행한다. 실행되는 1번 실행된다.
### 비교 연산자와 함께 서브쿼리를 사용하면 서브쿼리를 산자 오른쪽에 작성해야 한다.
### 서브쿼리 내부에는 정렬 구문인 order by 사용할 수 없다! 

-- select 
-- 	b.mem_id
-- from (select * from buy sub where sub.mem_id in ('BLK', 'WMU')) as b ;


### where 절에 사용하는 서브쿼리 - nested subquery 
### 조건문의 일부로 사용을 할 것이다- 서브쿼리는 
### 중첩 서브쿼리는 조건의 값이 나올 확률이 높다!! 
### 조건은 단일값 , 다중값
### 비교 연산자가 나오겠구나!

### 만약 price가 전체 평균 이상인 고객만 추출하고 싶다.

-- select * from buy
-- where price >='142.9167';

select * from buy
where price >=(select avg(price) from buy where prod_name ='아이폰');

select avg(price) from buy where prod_name ='아이폰';

select avg(price) from buy;

select * from buy
where mem_id in ('BLK','MMU');
select * from buy sub where sub.mem_id in ('BLK, WMU');


## 단일행 서브쿼리는 위에 진행하였고 , 단일행 연산자는 대소비교, 같다 아니다. 
## 다중값 서브쿼리 하기전 
### 다중행 연산자
### IN - 임의의 값과 동일한 조건 검색 
### ALL - 모든 값을 만족하는 조건 검색 
### ANY - 존재하는 어느 하나의 값이라도 만족하는 조건 검색
### EXISTS - 결과를 만족하는 값이 존재하는지 여부만 확인 (있냐 없냐!?)