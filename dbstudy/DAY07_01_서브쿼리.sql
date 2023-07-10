/*
    서브쿼리(SUB QUERY)
    1. 메인쿼리에 포함되는 하위커리를 서브쿼리라고 한다.
    2. 서브쿼리를 먼저 실행해서 그 결과를 메인쿼리에 전달한다.
    3. 종류
        1) SELECT 절 : 스칼라 서브쿼리
        2)   FROM 절 : 인라인 뷰(INLINE VIEW)
        3)  WHERE 절 : 단일 행 서브쿼리 (결과가 1개)
                       다중 행 서브쿼리 (결과가 N개)
*/
/*
    단일 행 서브쿼리(SINGLE ROW SUB QUERY)
    1. 결과가 1행이다. (1개이다.)
    2. 단일 행 서브쿼리인 경우
        1) WHERE 절에서 사용한 칼럼이 PK 또는 UNIQUE 칼럼인 경우
        2) 통계 함수를 상용한 경우 EX)SELECT COUNT(*) FROM EMPLOYEES 결과는 107 하나!
    3. 단일 행 서브쿼리 연산자
        비교 연산자 =, !=, >, >=, <, <=
        
    다중 행 서브쿼리(multiple row sub query) -단일 행이 아니면 다중 행이다.
    1. 결과가 N행이다.
    2. 다중 행 서브쿼리 연산자
        IN, ANY, ALL 등
*/
SELECT * 
  FROM EMPLOYEES 
 WHERE DEPARTMENT_ID = 50; -- 50 단일행 서브쿼리 등호 사용 -> 여기가 서브 쿼리가 들어갈 자리 
 
 SELECT * 
  FROM EMPLOYEES 
 WHERE DEPARTMENT_ID IN(50, 60); --50, 60 다중행 서브쿼리 'IN', any, or 등 으로 연결 
 
 
/* WHERE 절의 서브쿼리 */
 -- 1. 사원번호가 101인 사원의 직업과 동일한 직업을 가진 사원을 조회하시오.
 -- WHERE 절에 쓴 쿼리와 서브 SELECT 칼럼 같아야한다!
SELECT *
 FROM EMPLOYEES
 WHERE JOB_ID = (SELECT JOB_ID 
                   FROM EMPLOYEES 
                  WHERE EMPLOYEE_ID = 101); -- 1)EMPLOYEE_ID PK라 중복이 없고, 2)= 사용 -> 단일행이라는 증거!
                  
SELECT *
 FROM EMPLOYEES
 WHERE JOB_ID = (SELECT JOB_ID 
                   FROM EMPLOYEES 
                  WHERE EMPLOYEE_ID = 300); -- 값을 초과하지 않게 주의!! 

-- 2. 부서명이 'IT'인 부서에 근무하는 사원 조회하기

--SELECT *
--  FROM EMPLOYEES
-- WHERE DEPARTMENT_ID = (부서명이 'IT'인 부서의 부서번호)

SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID --> DEPARTMENT_ID PK, UNIQUE 둘다 아님, 부서이름의 중복이 있을 수 있음..다중행
                          FROM DEPARTMENTS
                         WHERE DEPARTMENT_NAME = 'IT');  -- 서브 쿼리의 DEPARTMENT_NANE 칼럼은 중복이 있을 수 있으므로 다중 행 서브쿼리로 처리한다.

-- 3. 'Seattle'에서 근무하는 사원 조회하기
SELECT *
  FROM DEPARTMENTS
 WHERE LOCATION_ID IN (SELECT LOCATION_ID 
                        FROM LOCATIONS 
                        WHERE CITY = 'Seattle');
                        
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                           FROM DEPARTMENTS
                          WHERE LOCATION_ID IN (SELECT LOCATION_ID 
                                                 FROM  LOCATIONS
                                                 WHERE CITY = 'Seattle'));  
                                                 
-- 4. 연봉 가장 높은 사원 조회하기
SELECT *
  FROM EMPLOYEES
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES);
                   
-- 5. 가장 먼저 입사한 사원 조회하기
SELECT *
 FROM EMPLOYEES
 WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE)
                      FROM EMPLOYEES);
            

-- 6. 평균 연봉 이상을 받는 사원 조회하기
SELECT *
 FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY) 
                    FROM EMPLOYEES);
                    
/* FROM 절의 서브쿼리  = 인라인 뷰 */
 -- 뷰 : 테이블(가상) -- SELECT문이 뷰..? 
 -- 정렬 먼저 하고 싶을 때 인라인 뷰를 사용! -ORDER BY 는 마지막에 실행하기 때문에 먼저하고 싶으면 요거 씀(실행 순서 변경)

-- 1. 연봉이 3번째로 높은 사원 조회하기
--1) 높은 연봉 순으로 정렬한다.
--2) 정렬 결과에 행 번호를 붙인다.
--3) 행 번호 3을 가져온다.

SELECT 행번호, EMPLOYEE_ID
 FROM (SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 행번호, EMPLOYEE_ID
        FROM EMPLOYEES)
 WHERE 행번호 = 3;

-- 2. 연봉 11 ~ 20 번째 사원 조회하기
SELECT RN, EMPLOYEE_ID
 FROM(SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS RN, EMPLOYEE_ID FROM EMPLOYEES)
 WHERE RN BETWEEN 11 AND 20;
 
-- 3. 21 ~30 번째로 입사한 사원 조회하기
SELECT HD, EMPLOYEE_ID  -- HD써도 되고 안써도 됨!
 FROM(SELECT ROW_NUMBER() OVER(ORDER BY HIRE_DATE ASC) AS HD, EMPLOYEE_ID FROM EMPLOYEES)
 WHERE HD BETWEEN 21 AND 30;
                  
/* SELECT 절의 서브쿼리 */
-- (비상관)부서번호가 50인 부서에 근무하는 사원번호, 사원명, 부서명 조회하기  - 다중 테이블 문제 JOIN아니면 서브쿼리
SELECT EMPLOYEE_ID
     , FIRST_NAME
     , LAST_NAME
     , (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID= 50) AS DEPT_NAME
      FROM EMPLOYEES
     WHERE DEPARTMENT_ID = 50;
     
--(상관) 부서번호가 50인 부서에 근무하는 사원번호, 사원명, 부서명 조회하기 - 이게 더 나은 쿼리... 숫자 1개, 위에는 2개
SELECT E.EMPLOYEE_ID
     , E.FIRST_NAME
     , E.LAST_NAME
     , (SELECT D.DEPARTMENT_NAME
          FROM DEPARTMENTS D
         WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
           AND D.DEPARTMENT_ID = 50) AS DEPT_NAME
    FROM EMPLOYEES E;

-- 스칼라 서브쿼리 성능 떨어지는 편 / JOIN으로 풀면 더 편함

         