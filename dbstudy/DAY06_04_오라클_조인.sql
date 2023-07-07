/*
    조인
    
    1. 2개 이상의 테이블을 한 번에 조회하는 방식이다.
    2. 각 테이블의 관계(1:M)를 이용해서 조인 조건을 만든다.
    3. 조인의 종류
        1) 내부 조인 : 2개 테이블에 모두 존재하는 데이터만 조회하는 방식
        2) 외부 조인 : 2개 테이블에 모두 존재하지 않더라도 조회하는 방식
        
        회원(1)      구매(M)         - 1 : M
            id      구매내역
        1   a   1 a  새우깡
        2   b   2 a  맛동산
        3   c   3 b  새우깡
        
구매내역을 뽑아보자( 내부 조인)
a 새우깡
a 맛동산
b 새우깡

구매내역이 없는 사람도 '포함해서' 구매내역을 뽑아보자(외부 조인) - 회원내역 정보를 확인하는 것
a 새우깡
a 맛동산
b 새우깡
c null
*/

/*
    드라이브 테이블 VS 드리븐 테이블
    1. 드라이브 테이블
        1) 조인 관계를 처리하는 메인 테이블
        2) 1:M 관계에서 1에 해당하는 테이블
        3) 일반적으로 데이터의 갯수가 적다.
        4) PK를 조인 조건으로 사용하기 때문에 인덱스(INDEX) 사용이 가능하다.(빠르다는 의미)
    2. 드리븐 테이블
        1) 1:M 관계에서 M에 해당하는 테이블
        2) 일반적으로 데이터 갯수가 많다.
        3) FK를 조인 조건으로 사용하기 때문에 인덱스(INDEX) 사용이 불가능하다.(느리다는 의미)
    3. 드라이브 테이블을 드리븐 테이블보다 먼저 작성하면 성능에 도움이 된다.

    
*/

-- 내부 조인

--1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오.
-- ★두개 이상의 테이블에 모두 같은이름으로 존재하는 칼럼은 반드시 오너(테이블명) 명시해야함@@
-- 사원번호, 사원명, 부서번호 - 사원테이블에 있음/ 부서번호, 부서명은 - 부서테이블에 있음
SELECT E.EMPLOYEE_ID
     , E.FIRST_NAME
     , E.LAST_NAME
     , D.DEPARTMENT_ID      -- E/D 아무거나 적어도 차이 없음!! 
                            -- 2개의 테이블에 모두 있는 칼럼(이름이 같은 칼럼)은 반드시 테이블(오너)을 명시해야 한다.
     , D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E  -- *1:M 1을 앞에, M를 뒤에 쓰기!!!/ 답은 똑같음 성능 차이// 양이적은 것이 앞, 양이 큰게 뒤
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID;
    
-- -> INNER JOIN 대신 콤마(,)를 사용한다. ON 대신 WHERE을 사용한다. - INNER 조인의 오라클 문법!    
    
    
    
-- 부서번호 없는 사람 조회 안됨 / 양쪽 테이블에 전부 있어야 값을 출력할 수 있음. 

--외부조인
--3. 모든 사원들의(부서가 없는 사원도 포함) 사원번호, 사원명, 부서번호, 부서명을 조회하시오.
-- 마지막에 NULL 나옴
SELECT EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS D RIGHT OUTER JOIN EMPLOYEES E  -- 오른쪽 테이블 (EMPLOYEES)틔 모든 데이터를 조회하시오.(부서번호가 없는 사원도 조회하시오.)
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;
    
--2. 사원번호, 사원명, 직업, 직업별 최대연봉, 직업별 최소연봉을 조회하시오.
-- 양 테이블에 JOBS_ID 각 존재
SELECT E.EMPLOYEE_ID
     , E.FIRST_NAME || ' ' || E.LAST_NAME AS FULLNAME
     , J.JOB_ID
     , J.MAX_SALARY
     , J.MIN_SALARY
  FROM JOBS J INNER JOIN EMPLOYEES E
    ON J.JOB_ID = E.JOB_ID;
    
    
--2. 사원번호, 사원명, 직업, 연봉, 직업별 최대연봉, 직업별 최소연봉을 조회하시오.
-- 양 테이블에 JOBS_ID 각 존재
 SELECT EMPLOYEE_ID
      , FIRST_NAME || ' ' || LAST_NAME AS FULLNAME
      , J.JOB_ID
      , SALARY
      , MAX_SALARY
      , MIN_SALARY
   FROM JOBS J INNER JOIN EMPLOYEES E
     ON J.JOB_ID = E.JOB_ID;   

-- INNER JOIN 오라클 문법으로 변경     
 SELECT EMPLOYEE_ID
      , FIRST_NAME || ' ' || LAST_NAME AS FULLNAME
      , J.JOB_ID
      , SALARY
      , MAX_SALARY
      , MIN_SALARY
   FROM JOBS J, EMPLOYEES E
  WHERE J.JOB_ID = E.JOB_ID;        
    
--4. 사원번호, 사원명, 부서번호, 부서명을 조회하시오, 사원이 근무하지 않는 유령 부서도 조회하시오.
-- 외부 조인 위에 3번
-- 3-1 FROM 테이블 양 옆 변경
--모든 사원들의(부서가 없는 사원도 포함) 사원번호, 사원명, 부서번호, 부서명을 조회하시오.(사원이 근무하지 않는 부서도 존회하시오.)
SELECT EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM EMPLOYEES E RIGHT OUTER JOIN DEPARTMENTS D  -- 오른쪽 테이블 (EMPLOYEES)의 모든 데이터를 조회하시오.(부서번호가 없는 사원도 조회하시오.)
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;
    
-- 120 ~ 270번 부서정보는 있지만 사원은 NULL 값.. 

--오라클 문법으로 수정
SELECT E.EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS D,  EMPLOYEES E  -- 오른쪽 테이블 (EMPLOYEES)의 모든 데이터를 조회하시오.(부서번호가 없는 사원도 조회하시오.)
 WHERE D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID; --RIGHT OUTER JOIN은 반대반향(LEFT)에 (+)를 추가한다.

--4. 수정

SELECT EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E -- 왼쪽 테이블 (EMPLOYEES)의 모든 데이터를 조회하시오.(부서번호가 없는 사원도 조회하시오.)
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID(+); -- LEFT OUTER JOIN은 반대방향(RIGHT)에 (+)를 추가한다.

--------------------------
-- 3개 이상 테이블 조인하기

--5. 사원번호, 사원명, 부서번호, 부서명, 근무지역을 조회하시오
 ---사원번호, 사원명, 부서번호 EMPLOYEE
---부서번호, 부서명 DEPARTMENT
---근무지역 - LOCATION
SELECT EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
     , L.LOCATION_ID
     , CITY
 FROM LOCATIONS L INNER JOIN DEPARTMENTS D  -- FROMW절 ON절 INNER 앞 은 이미 하나의 테이블 
   ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E
   ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

--수정
SELECT EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , D.DEPARTMENT_ID
     , DEPARTMENT_NAME
     , L.LOCATION_ID
     , CITY
  FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E  -- FROMW절 ON절 INNER 앞 은 이미 하나의 테이블 
 WHERE L.LOCATION_ID = D.LOCATION_ID
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;


--6. 부서번호, 부서명, 근무지역도시, 근무국가를 조회하시오.
SELECT DEPARTMENT_ID
     , DEPARTMENT_NAME
     , CITY
     , C.COUNTRY_NAME
 FROM COUNTRIES C INNER JOIN LOCATIONS L
   ON C.COUNTRY_ID = L.COUNTRY_ID INNER JOIN DEPARTMENTS D
   ON L.LOCATION_ID = D.LOCATION_ID;

SELECT DEPARTMENT_ID
     , DEPARTMENT_NAME
     , CITY
     , C.COUNTRY_NAME
 FROM COUNTRIES C, LOCATIONS L, DEPARTMENTS D
WHERE C.COUNTRY_ID = L.COUNTRY_ID
  AND L.LOCATION_ID = D.LOCATION_ID;



