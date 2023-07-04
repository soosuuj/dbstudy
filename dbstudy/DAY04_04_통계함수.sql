/*
    통계 함수
    1. SUM(표현식)   : 합계
    2. AVG(표현식)   : 평균
    3. MAX(표현식)   : 최댓값
    4. MIN(표현식)   : 최솟값
    5. COUNT(표현식) : 갯수
*/
--1. 사원 테이블에서 연봉 합계 조회하기
SELECT SUM(SALARY) AS 연봉합계
  FROM EMPLOYEES;
  
--2. 사원 테이블에서 전체 사원의 커미션 퍼센트의 평균 조회하기
-- 커미션이 없는 사원은 제외하고 조회하기 (모든 함수들은 NULL값을 제외하고 처리함)
SELECT AVG(COMMISSION_PCT) AS 커미션퍼센트평균
  FROM EMPLOYEES;
--WHERE COMMISSION_PCT IS NOT NULL; 이 조건식은 필요하지 않다. AVG함수는 자체적으로 NULL을 제외한다.

-- 3. 사원 테이블에서 전체 사원의 최대 연봉을 받는 사원 조회하기
SELECT MAX(SALARY) AS 최대연봉
  FROM EMPLOYEES;

--4. 사원 데티블에서 전체 사원의 최대 커미션 조회하기 
--커미션 - 연봉 * 커미션퍼센트 SALARY * COMMISSION_PCT
SELECT MAX(SALARY * COMMISSION_PCT) AS 최대커미션
  FROM EMPLOYEES;
  
  
--5. 사원 테이블에서 전체 사원 중 가장 나중에 입사한 사원의 입사일 조회하기
SELECT MAX(HIRE_DATE) AS 가장나중에입사한사원입사일
  FROM EMPLOYEES;
  
--6. 전체 사원 수 조회하기
--1) NOT NULL이 확실한(대표적으로 PK) 칼럼으로 갯수를 구한다.
SELECT COUNT(EMPLOYEE_ID) AS 전체사원수
  FROM EMPLOYEES;
--2) 모든 칼럼으로 갯수를 구한다. //NOT NULL이 확실한 칼럼을 찾는 것보다 * 쓰는게 효율적!!!
SELECT COUNT(*)
   FROM EMPLOYEES;
--7. 사원들이 근무하는 부서의 갯수 조회하기
SELECT COUNT(DISTINCT DEPARTMENT_ID) AS 부서수
  FROM EMPLOYEES;
