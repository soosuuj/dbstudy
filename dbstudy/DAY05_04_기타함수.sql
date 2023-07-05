--1. 순위 구하기
-- RANK() OVER(ORDER BY 칼럼 ASC)  : 낮은 값이 1등
-- RANK() OVER(ORDER BY 칼럼 DESC) : 높은 값이 1등
SELECT EMPLOYEE_ID
     , SALARY
     , RANK() OVER(ORDER BY SALARY DESC) AS 연봉순위 -- 연봉 내림차순 정렬 후 순위 매기기(동점자는 같은 순위를 가짐)
 FROM EMPLOYEES;
 
 SELECT EMPLOYEE_ID
     , HIRE_DATE
     , RANK() OVER(ORDER BY HIRE_DATE) AS 입사순위 -- 고용일 오름차순(옛날 입사자 1등) 정렬 후 순위 매기기
 FROM EMPLOYEES;
 
 --2. 행 번호 구하기
SELECT EMPLOYEE_ID
    , SALARY 
    , ROW_NUMBER() OVER(ORDER BY SALARY DESC) -- 연봉내림차순 정렬 후 번호매기기(동점자 처리 방식 없음)
 FROM EMPLOYEES;
 
-- 3. 암호화 함수
SELECT STANDARD_HASH('1111', 'SHA1')   -- 암호화 알고리즘 이름 SHA1
     , STANDARD_HASH('1111', 'SHA256') -- 암호화 알고리즘 SHA256
     , STANDARD_HASH('1111', 'SHA384') -- 암호화 알고리즘 SHA384
     , STANDARD_HASH('1111', 'SHA512') -- 암호화 알고리즘 SHA512
     , STANDARD_HASH('1111', 'MD5')    -- 암호화 알고리즘 MD5
  FROM DUAL;
  
  ﻿
--4. 분기 처리 함수

SELECT EMPLOYEE_ID
     , DEPARTMENT_ID
     , DECODE(DEPARTMENT_ID
     , 10, 'Administration'
     , 20, 'Marketing'
     , 30, 'purchasing'
     , 40, 'Human Resource'
     , 50, 'Shipping'
     , 60, 'IT') AS DEPARTMENT_NAME
  FROM EMPLOYEES;

--5. 분기처리 표현식
SELECT EMPLOYEE_ID
    , DEPARTMENT_ID
    , CASE
      WHEN DEPARTMENT_ID = 10 THEN 'Administration'
      WHEN DEPARTMENT_ID = 10 THEN 'Marketing'
      WHEN DEPARTMENT_ID = 10 THEN 'purchasing'
      WHEN DEPARTMENT_ID = 10 THEN 'Human Resource'
      WHEN DEPARTMENT_ID = 10 THEN 'Shipping'
      WHEN DEPARTMENT_ID = 10 THEN 'IT'      
      ELSE 'Unknown'
    END AS DEPARTMENT_NAME
      FROM EMPLOYEES;  
      

      

 