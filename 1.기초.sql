USE market_db;

select * from buy;
select * from member;


##### member 테이블을 가지고 살펴보자!

### 데이터를 추출하고 싶습니다. 
### 경기에 사는 멤버들 중 5명 이상의 멤버 넘버인 멤버의 이름은 누구인가요!?
### and 조건으로 추가해야 하는 문
### 다중 조건들은 where 다음은 and 조건인 경우 이어나가면 된다.

### 추가적으로 mem_name과 debut_date 궁금해!
select 
	mem_name,
    debut_date
from 
	member
where
	addr ='경기'
and 
	mem_number >=5
and 
	height >=165;

### select from where orderby
### 정렬의 개념
### 값을 정렬, 오름차순 내림차순을 통해서 정렬이 된다.

select * from member;
### mem_number에 따라 정렬을 하고 싶다!
### 디폴트는 오름차순 asc 
### 내림차순 desc
### 만약 다양한 컬럼으로 정렬을 나누고 싶다면
### mem_number, height 둘로 정렬을 하는 것
### 먼저 쓴 것이 기준이고 그다음 컬럼 기준
select 
	*
from 
	member
order by mem_number desc, height asc;


select 
	*
from 
	member
where 
	addr ='서울';
-- order by mem_number desc, height desc;


### SQL 문법의 순서 
### SQL 문법이 기본적으로 꼭 지켜야 하는 순서가 있다.
### select  -> 열 : 큰 줄기
### from -> 테이블 : 큰 줄기
### where  -> 조건에 따른 작은 줄기를 찾는 것
### group by -> 큰 줄기에서 -> 작은 줄기로 필터한 테이블을 집계하여 무언가 새롭게 만드는 것 -> 작은 줄기들을 엮어서 새롭게 집계하는 것 
### having -> 작은 줄기들을 엮어서 그룹으로 만들었는데 거기서 다시 where 조건처럼 작은 줄기를 다시 찾고 싶을 때 
### order by -> 기준에 따른 데이터 정렬 
### limit -> 행 요약해서 출력하는 것

### join 

### select  -> 열 : 큰 줄기
### from -> 테이블 : 큰 줄기
### where  -> 조건에 따른 작은 줄기를 찾는 것
### group by -> 큰 줄기에서 -> 작은 줄기로 필터한 테이블을 집계하여 무언가 새롭게 만드는 것 -> 작은 줄기들을 엮어서 새롭게 집계하는 것 
### having -> 작은 줄기들을 엮어서 그룹으로 만들었는데 거기서 다시 where 조건처럼 작은 줄기를 다시 찾고 싶을 때 
### order by -> 기준에 따른 데이터 정렬 
### limit -> 행 요약해서 출력하는 것
### --- join 
### select  -> 열 : 큰 줄기
### from -> 테이블 : 큰 줄기
### where  -> 조건에 따른 작은 줄기를 찾는 것
### group by -> 큰 줄기에서 -> 작은 줄기로 필터한 테이블을 집계하여 무언가 새롭게 만드는 것 -> 작은 줄기들을 엮어서 새롭게 집계하는 것 
### having -> 작은 줄기들을 엮어서 그룹으로 만들었는데 거기서 다시 where 조건처럼 작은 줄기를 다시 찾고 싶을 때 
### order by -> 기준에 따른 데이터 정렬 
### limit -> 행 요약해서 출력하는 것


# Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from   member' at line 4

#Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'order by mem_number desc, height desc' at line 6

-- select 
-- 	*
-- from 
-- 	member
-- limit 5
-- order by mem_number desc, height desc;

### and or 조건의 차이 
select 
	mem_name,
    debut_date
from 
	member
where
	addr ='경기'
and 
	mem_number >=5
and 
	height >=165;
    
    
select 
	mem_name,
    debut_date
from 
	member
where
	addr ='경기'
and 
	mem_number >=5
or 
	height >=165;   
    
select 
	mem_name,
    debut_date
from 
	member
where
	addr ='경기'
or 
	mem_number >=5
or 
	height >=165;   