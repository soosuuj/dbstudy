/*
    DML
    1. Data Manipulation Language
    2. 데이터(행, Row)를 조작(삽입, 수정, 삭제)하는 언어이다.
    3. 트랜잭션 대상이다.(작업이 완료되면 COMMIT, 작업을 취소하려면 ROLLBACK이 필요한다.)
        1) COMMIT   : 작업을 저장한다. COMMIT이 완료된 작업은 ROLLBACK으로 취소할 수 없다.
        2) ROLLBACK : 작업을 취소한다. COMMIT 이후 작업을 취소한다.
    4. 종류
        1) 삽입 : INSERT INTO VALUES
        2) 수정 : UPDATE SET WHERE
        3) 삭제 : DELETE FROM WHERE
*/

-- 참고.
-- 자격증에서는 DML의 범주를 INSERT,UPDATE,DELETE + SELECT로 보기도 한다.

-- 테이블 삭제
DROP TABLE EMPLOYEE_T;
DROP TABLE DEPARTMENT_T;

-- DEPARTMENT_T 테이블 생성
CREATE TABLE DEPARTMENT_T (
    DEPT_NO   NUMBER            NOT NULL
  , DEPT_NAME VARCHAR2(15 BYTE) NOT NULL
  , LOCATION  VARCHAR2(15 BYTE) NOT NULL
  , CONSTRAINT PK_DEPART PRIMARY KEY(DEPT_NO)
);

-- EMPLOYEE_T 테이블 생성
CREATE TABLE EMPLOYEE_T (
    EMP_NO    NUMBER            NOT NULL
  , NAME      VARCHAR2(20 BYTE) NOT NULL
  , DEPART    NUMBER            NULL
  , POSITION  VARCHAR2(20 BYTE) NULL
  , GENDER    CHAR(2 BYTE)      NULL
  , HIRE_DATE DATE              NULL
  , SALARY    NUMBER            NULL
  , CONSTRAINT PK_EMPLOYEE PRIMARY KEY(EMP_NO)
  , CONSTRAINT FK_DEPART_EMP FOREIGN KEY(DEPART) REFERENCES DEPARTMENT_T(DEPT_NO) ON DELETE SET NULL
);

-- 부서번호를 생성하는 시퀀스 만들기
/*
CREATE SEQUENCE DEPT_SEQ
    INCREMENT BY 1  -- 1씩 증가하는 번호를 만든다.(디폴트)
    START WITH 1    -- 1부터 번호를 만든다.(디폴트)
    NOMAXVALUE      -- 번호의 상한선이 없다.(디폴트)
    NOMINVALUE      -- 번호의 하한선이 없다.(디폴트)
    NOCYCLE         -- 번호 순환이 없다.(디폴트)
    CACHE 20        -- 20개씩 번호를 미리 만들어 둔다.(디폴트)
    NOORDER         -- 번호를 순서대로 사용하지 않는다.(디폴트) - 번호를 순서대로 사용하는 ORDER 옵션으로 바꿔서 시퀀스를 생성한다.
;
*/
DROP SEQUENCE DEPT_SEQ;
CREATE SEQUENCE DEPT_SEQ ORDER;

INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '영업부', '대구');
INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '인사부', '서울');
INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '총무부', '대구');
INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '기획부', '서울');
COMMIT;


-- 사원번호를 생성하는 시퀀스
DROP SEQUENCE EMP_SEQ;
CREATE SEQUENCE EMP_SEQ
    START WITH 1001
    ORDER;

-- 사원 데이터 입력
INSERT INTO EMPLOYEE_T(EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY) VALUES(EMP_SEQ.NEXTVAL, '구창민', 1, '과장', 'M', '95-05-01', 5000000);  -- 날짜는 하이픈(-) 또는 슬래시(/)로 구분
INSERT INTO EMPLOYEE_T(EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY) VALUES(EMP_SEQ.NEXTVAL, '김민서', 1, '사원', 'M', '17-09-01', 2500000);  -- 날짜는 하이픈(-) 또는 슬래시(/)로 구분
INSERT INTO EMPLOYEE_T(EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY) VALUES(EMP_SEQ.NEXTVAL, '이은영', 2, '부장', 'F', '90/09/01', 5500000);  -- 날짜는 하이픈(-) 또는 슬래시(/)로 구분
INSERT INTO EMPLOYEE_T(EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY) VALUES(EMP_SEQ.NEXTVAL, '한성일', 2, '과장', 'M', '93/04/01', 5000000);  -- 날짜는 하이픈(-) 또는 슬래시(/)로 구분
COMMIT;



--수정
 /*
    UPDATE 테이블
    SET 업데이트할 내용, 업데이트할 내용,...,
    WHERE 조건식(어떤 것들을 업데이트할 것인가 - 유튜브의 조회수를 증가시킨다.)
    EX) 조회수 등
 */
---1. 부서번호가 3인부서의 지역을 '인천'으로 변경하시오.
 UPDATE DEPARTMENT_T
    SET LOCATION = '인천' -- SET절의 등호(=)는 대입연산자
  WHERE DEPT_NO = 3; -- WHERE절의 등호(=) 동등비교연산자(동일한 연산자가 자기가 사용되는절에따라 의미가 달라짐)
-- 한개만 업데이트 -- 1 행 이(가) 업데이트되었습니다.
-- 커밋아직 안해서 취소가능


--ROLLBACK;

---2. 부서번호가 2인 부서의 근무하는 모든 사원들의 연봉을 50000 증가시켜보자

UPDATE EMPLOYEE_T
   SET SALARY = SALARY + 500000
 WHERE DEPART = 2;
 

--삭제  
/*
     DELETE
      FROM 테이블이름
     WHERE 조건식
*/

-- 1. 지역이 '인천'인 부서를 삭제하시오. (인천에 근무하는 사원이 없다.)
DELETE 
  FROM DEPARTMENT_T
 WHERE LOCATION = '인천'; --동등비교 연산

--2. 지역이 '서울'인 부서를 삭제하시오
--(서울에 근무하는 사원이 있다. - ON DELTET SET NULL 옵션에 의해서 부서정보가 NULL처리 된다.) 


DELETE
 FROM DEPARTMENT_T
WHERE LOCATION = '서울';  -- 외래키의 삭제 옵션이 없었으면 삭제를 거부당함



----------------------------------------------------------------------

-- 1. 사원번호가 1001인 사원과 동일한 직급(POSITION)을 가진 사원을 조회하시오.
SELECT *
FROM EMPLOYEE_T
WHERE POSITION = (SELECT POSITION
                  FROM EMPLOYEE_T
                  WHERE EMP_NO = 1001);
                  
SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM EMPLOYEE_T
 WHERE POSITION = (SELECT POSITION
                     FROM EMPLOYEE_T
                    WHERE EMP_NO = 1001);                  


-- 2. 부서번호가 2인 부서와 동일한 지역에 있는 부서를 조회하시오.
SELECT *
  FROM DEPARTMENT_T
 WHERE LOCATION IN (SELECT LOCATION
                    FROM DEPARTMENT_T
                    WHERE DEPT_NO = 2);
                    
                    SELECT DEPT_NO, DEPT_NAME, LOCATION
                    
  FROM DEPARTMENT_T
 WHERE LOCATION = (SELECT LOCATION
                     FROM DEPARTMENT_T
                    WHERE DEPT_NO = 2);

-- 3. 가장 높은 급여를 받는 사원을 조회하시오. // 급여 똑같음
SELECT *
 FROM EMPLOYEE_T
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEE_T);
                   
SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM EMPLOYEE_T
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEE_T);

-- 4. 평균 급여 이하를 받는 사원을 조회하시오.
SELECT *
 FROM EMPLOYEE_T
 WHERE SALARY < (SELECT AVG(SALARY)
                   FROM EMPLOYEE_T);
                   
SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM EMPLOYEE_T
 WHERE SALARY <= (SELECT AVG(SALARY)
                    FROM EMPLOYEE_T);                   

-- 5. 평균 근속 개월 수 이상을 근무한 사원을 조회하시오.
SELECT *
FROM EMPLOYEE_T
WHERE MONTHS_BETWEEN(SYSDATE, TO_DATE(HIRE_DATE, 'YY/MM/DD')) >=
               (SELECT AVG(MONTHS_BETWEEN(SYSDATE, TO_DATE(HIRE_DATE, 'YY/MM/DD')))
                  FROM EMPLOYEE_T);
                  
SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM EMPLOYEE_T
 WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= (SELECT AVG(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
                                                FROM EMPLOYEE_T);                 

-- 6. 부서번호가 2인 부서에 근무하는 사원들의 직급과 일치하는 사원을 조회하시오.
SELECT *
FROM EMPLOYEE_T
WHERE POSITION IN (SELECT POSITION
                    FROM EMPLOYEE_T
                    WHERE DEPART = 2);

SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM EMPLOYEE_T
 WHERE POSITION IN (SELECT POSITION
                      FROM EMPLOYEE_T
                     WHERE DEPART = 2);  -- WHERE절에서 사용한 DEPART 칼럼이 PK/UNIQUE 칼럼이 아니므로 다중 행 서브쿼리로 처리한다.
-- 7. 부서명이 '영업부'인 부서에 근무하는 사원을 조회하시오.

SELECT *
FROM EMPLOYEE_T
WHERE DEPART = (SELECT DEPT_NO
                 FROM DEPARTMENT_T
                 WHERE DEPT_NAME = '영업부');
                 

SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM EMPLOYEE_T
 WHERE DEPART IN (SELECT DEPT_NO
                    FROM DEPARTMENT_T
                   WHERE DEPT_NAME = '영업부');  -- WHERE절에서 사용한 DEPART_NAME 칼럼이 PK/UNIQUE가 아니므로 다중 행 서브쿼리로 처리한다.

-- 참고) 조인으로 풀기
SELECT E.EMP_NO, E.NAME, E.DEPART, E.GENDER, E.POSITION, E.HIRE_DATE, E.SALARY
  FROM DEPARTMENT_T D INNER JOIN EMPLOYEE_T E
    ON D.DEPT_NO = E.DEPART
 WHERE D.DEPT_NAME = '영업부';
 

-- 8. 직급이 '과장'인 사원들이 근무하는 부서 정보를 조회하시오.

SELECT *
 FROM DEPARTMENT_T
 WHERE DEPT_NO IN (SELECT DEPART
                      FROM EMPLOYEE_T
                   WHERE POSITION = '과장');
                   
SELECT DEPT_NO, DEPT_NAME, LOCATION
  FROM DEPARTMENT_T
 WHERE DEPT_NO IN (SELECT DEPART
                     FROM EMPLOYEE_T
                    WHERE POSITION = '과장');  -- WHERE절에서 사용한 POSITION 칼럼이 PK/UNIQUE가 아니므로 다중 행 서브쿼리로 처리한다.

-- 참고) 조인으로 풀기
SELECT D.DEPT_NO, D.DEPT_NAME, D.LOCATION
  FROM DEPARTMENT_T D INNER JOIN EMPLOYEE_T E
    ON D.DEPT_NO = E.DEPART
 WHERE E.POSITION = '과장';                   

-- 9. '영업부'에서 가장 높은 급여를 받는 사람보다 더 높은 급여를 받는 사원을 조회하시오.

SELECT *
FROM EMPLOYEE_T
WHERE SALARY > (SELECT MAX(SALARY)
                  FROM EMPLOYEE_T
                 WHERE DEPART = (SELECT DEPT_NO
                                   FROM DEPARTMENT_T
                                  WHERE DEPT_NAME = '영업부'));
                                  
SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM EMPLOYEE_T
 WHERE SALARY > (SELECT MAX(SALARY)
                   FROM EMPLOYEE_T
                  WHERE DEPART IN (SELECT DEPT_NO
                                     FROM DEPARTMENT_T
                                    WHERE DEPT_NAME = '영업부'));                                  
                                  
-- 10. 3 ~ 4번째로 입사한 사원을 조회하시오.
SELECT *
 FROM (SELECT ROW_NUMBER() OVER(ORDER BY HIRE_DATE ASC) AS RN, NAME, HIRE_DATE
        FROM EMPLOYEE_T)
  WHERE RN BETWEEN 3 AND 4;   

SELECT EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY HIRE_DATE ASC) AS RN, EMP_NO, NAME, DEPART, GENDER, POSITION, HIRE_DATE, SALARY
          FROM EMPLOYEE_T)
 WHERE RN BETWEEN 3 AND 4;
