##
select * from member;
select * from buy;

## where 문의 조건을 추가적으로 다뤄보기!
# select [열] from [테이블] where [열] =[조건값] 필터 진행
# 비교연산자
# < , >, >= , <= , != 
# !< 조건값보다 작지 않은 것
# !> 조건값보다 크지 않은 것 
# 비교 연산자는 비교 연산을 할 수 있는 스키마 도메인만 가능하다.
# 대부분 수치형의 Int, float 값을 대표적으로 사용할 수 있다.


select * from member;
## 멤버의 수가 4명이상, 9명 보다는 적은데(미만), 키는 160보다 이상 166보다는 미만 그룹의 출신지역은 어디인가!?
select 
	addr
from 
	member
where
	mem_number >=4
and 
	mem_number <9
and 
	height >=160
and 
	height < 166;
-- '경기'
-- '경남'
-- '전남'
-- '서울'
-- '경북'

--    
-- select 
-- 	addr
-- from 
-- 	member
-- where
-- 	mem_number >=4
-- and 
-- 	height >=160
-- or 
-- 	mem_number <9
-- or 
-- 	height < 166;

## 특정 값을 가지고도 비교 할 수 있다.
## 마마무만 출력
select 
	*
from 
    member;
-- where 
-- 	mem_name = '마마무';

# 논리연산자
# 논리 연산자도 연산을 통해 해당 값이 True 출력이고 False 출력이 안 되는 것
# all : 모든 비교 집합이 참인 경우에만 해당 데이터를 조회
# and : 양쪽의 부울 표현식이 모두 참이면 해당 데이터를 조회 
# any : 비교 집합 중에서 하나라도 참이면 해당 데이터를 조회
# between : 피연산자내에서 범위 내에 있으면 데이터 조회
# exists : 하위 쿼리에 행이 포함되면 데이터를 조회
# in : 피연산자가 리스트 중 하나라도 포함되어 있으면 조회
# like : 피연산자가 패턴에 일치하는 경우 데이터 조회
# not : 부울 연산자 반대 역으로 실행 데이터 조회
# or : or 기준으로 한 쪽의 부울 참이면 해당 데이터 조회
# some : 비교 집합 중 일부가 참인 경우 데이터 조회

### between
select * from member
where
	mem_number between 4 and 9;
select 
	*
from 
	member
where
	mem_number >=4
and 
	mem_number <9;
    
## 날짜 포맷 건들기
## 데뷔한 날짜가 2007-01-01 ~ 2011-05-01까지 날짜 중에 데뷔한 멤버

select 
	*
from 
	member
where
	debut_date between '2007-01-01' and '2011-05-01';

## 다중 조건을 만족하는 경우 
## in 
## 경기에 살고 전남에 살고 서울에 살고 
## addr = 서울 and addr =경기 and  addr = 전남
## in (내가 필요한 조건을 적자)
select * from member
where addr in ('서울','경기','전남');


## phone1 031, 02 이고, 서울,경기,전남에 거주하는 경우 

select * from member
where phone1 in('031','02')
and addr in ('서울','경기','전남');

select * from member
where addr in ('서울','경기','전남')
and phone1 in('031','02');

### null값은 어떻게 봐야 하는가~?
select * from member
 where phone1 is null;
## 기존의 값과 비교했을 때 = 비교연산자를 사용해서 비교하면
## null의 경우는 정의되지 않은 값이라 = 표현할 수 없고 is 로 표현해서 Null을 찾아야 한다.

select * from member
 where phone1 is not null;

### order by로 정렬
### select [열] from [테이블] where [열]=[조건값] order by [열] [ASC 또는 DESC] 오름차순, 내림차순으로 정렬 

select * from member
order by mem_number asc , height desc;


select * from member
order by addr asc;


## Limit 내가 원하는 값만 N개 값으로 추려서 추출하는 것
## limit 10, 3  10번째 순서의 값부터 3개만 출력을 해서 값을 보여달라! 
select * from member
order by addr asc
limit 5;


## 와일드카드 문자 
## 문자열을 조회할 때 많이 사용하는 문법
## like
## 문자열의 패턴을 세분화하여 찾을 때 사용하고
## 더 세분화 하면 regexp 사용해서 복잡한 패턴을 찾지만, 우리는 like만 일단 학습

## select [열] from [테이블] where [열] like [조건값]
## %
## '핑크%' -> 핑크로 시작하는 모든 문자열
## '%핑크' -> 핑크로 끝나는 모든 문자열
## '%핑크%' -> 핑크가 모함된 모든 문자열

## _
## 잇_ -> 잇으로 시작하면서 뒤의 글자는 무엇이든 상관이 없으며 전체 글자 수는 2개인 문자열
## _잇 -> 잇으로 끝나면서 앞의 문자는 무엇이든 상관이 없다 전체 글자 수는 2개인 문자열 
## _잇_ -> 세글자로 된 문자열 중 가운데가 잇이며 앞뒤는 무엇이든 상관이 없다.


select * from member
where mem_name like '%핑크';

select * from member
where mem_name like '잇_';

select * from member
where mem_name like '_마_';


select * from member
where mem_name like '%친구';


select * from member
where mem_id like '%E%';
