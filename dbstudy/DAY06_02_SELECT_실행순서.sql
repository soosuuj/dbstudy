/*
    SELECT 문의 실행 순서
    
    SELECT 칼럼       5  
      FROM 테이블     1
     WHERE 조건       2
     GROUP BY 그룹    3
    HAVING 그룹조건   4
     ORDER BY 정렬    6
*/

--사원 테이블에서 부서별 연봉 평균을 조회하시오.

SELECT DEPARTMENT_ID
      ,ROUND(AVG(SALARY), 2)
  FROM EMPLOYEES              
 GROUP BY DEPARTMENT_ID; 
 
 --테이블 별명 -- 별명 붙여 확인 ' '빈칸 다음 쓰면 됨
 SELECT DEPARTMENT_ID
      ,ROUND(AVG(SALARY), 2)
  FROM EMPLOYEES E              -- 1
 GROUP BY E.DEPARTMENT_ID;  -- EMPLOYEE 테이블에 있는  DEPARTMENT_ID
 
 --칼럼 별명 AS 
 SELECT DEPARTMENT_ID AS DEPT_ID
      ,ROUND(AVG(SALARY), 2)
  FROM EMPLOYEES             -- 1
 GROUP BY DEPT_ID;  -- 실행 순서가 맞지 않아 실행 불가 
 
 --사원 테이블에서 부서별 연봉 평균을 조회하시오. 부서별 사원수가 2명 이상인 부서만 조회하시오
SELECT DEPARTMENT_ID
      ,ROUND(AVG(SALARY), 2)
  FROM EMPLOYEES              
 GROUP BY DEPARTMENT_ID
 HAVING COUNT(*) >= 2;
 
  --사원 테이블에서 부서별 연봉 평균과 사원수를 조회하시오. 부서별 사원수가 2명 이상인 부서만 조회하시오
SELECT DEPARTMENT_ID
      ,ROUND(AVG(SALARY), 2)
      ,COUNT(*)
  FROM EMPLOYEES              
 GROUP BY DEPARTMENT_ID
 HAVING COUNT(*) >= 2;
 
   --순서 안맞아 실행 불가
SELECT DEPARTMENT_ID
      ,ROUND(AVG(SALARY), 2)
      ,COUNT(*) AS 부서별사원수
  FROM EMPLOYEES                  -- 1       
 GROUP BY DEPARTMENT_ID           --2
 HAVING 부서별사원수 >= 2;         --3
 
 -- 순서 + 별명 사용
SELECT DEPARTMENT_ID AS DEPT_ID
      ,ROUND(AVG(SALARY), 2)
      ,COUNT(*) AS 부서별사원수
  FROM EMPLOYEES              
 GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 2
 ORDER BY DEPT_ID;
 
 