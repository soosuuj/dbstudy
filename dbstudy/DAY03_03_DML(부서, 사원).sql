/*
    DML
    1. Date Manipulation Language
    2. 데이터(행, row)를 조작(삽입, 수정, 삭제)하는 언어이다.
    3. 트랜잭션 대상이다.(작업이 완료되면 COMMIT, 작업을 취소하려면 ROLLBACK이 필요하다.
        1) COMMIT : 작업을 저장한다. COMMIT이 완료된 작업은 ROLLBACK으로 취소할 수 없다.
        2) ROLLBACK : 작업을 취소한다. COMMIT 이후 작업을 취소한다.
    4. 종류
        1) 삽입 : INSERT INTO VALUES
        2) 수정 : UPDATE SET WHERE
        3) 삭제 : DELETE FROM WHERE
*/
--참고.
--자격증에서는 DML의 범주를 INSERT, UPDATE, DELETE + SELECT로 보기도 한다.

--테이블 삭제
DROP TABLE EMPLOYEE_T;
DROP TABLE DEPARTMENT_T;

--DEPARTMENT_TBL 테이블 생성
CREATE TABLE DEPARTMENT_T(
      DEPT_NO    NUMBER               NOT NULL
    , DEPT_NAME  VARCHAR2(15 BYTE)    NOT NULL
    , LOCATION   VARCHAR2(15 BYTE)    NOT NULL
    , CONSTRAINT PK_DEPARTMENT_T PRIMARY KEY(DEPT_NO)
);

--EMPLOYEE_TBL 테이블 생성
CREATE TABLE EMPLOYEE_T(
      EMP_NO    NUMBER            NOT NULL
    , NAME      VARCHAR2(20 BYTE) NOT NULL
    , DEPART    NUMBER            NULL
    , POSITION  VARCHAR2(20 BYTE) NULL
    , GENDER    CHAR(2 BYTE)      NULL
    , HIRE_DATE DATE              NULL
    , SALARY    NUMBER            NULL
    , CONSTRAINT PK_EMPLOYEE_T PRIMARY KEY(EMP_NO)
    , CONSTRAINT FK_DEPARTMENT_T_EMPLOYEE_T FOREIGN KEY(DEPART) REFERENCES DEPARTMENT_T(DEPT_NO) ON DELETE SET NULL
); 
/*
--부서번호를 생성하는 시퀀스 만들기 // 하기 전부 기본값 - 옵션값 안적으면 기본값 사용
CREATE SEQUENCE DEPT_SEQ
    INCREMENT BY 1 --1씩 증가하는 번호를 만든다.(디폴트)
    START WITH 1   -- 1부터 번호를 만든다.(디폴트)
    NOMAXVALUE     -- 번호의 상한선이 없다.(디폴트)
    NOMINVALUE     -- 번호의 하한선이 없다.(디폴트)
    NOCYCLE        -- 번호순환이 없다.(디폴트)
    CACHE 20       -- 한 번에 20개씩 번호를 미리 만들어 둔다.(디폴트)
    NOORDER        -- 번호를 순서대로 사용하지 않는다.(디폴트) 
                   --  ㄴ번호를 순서대로 사용하는ORDER 옵션으로 바꿔서 시퀀스를 생성한다.
;
*/
--시퀀스도 스크립트 작업할 떄 드랍부터 적기
DROP SEQUENCE DEPT_SEQ;

CREATE SEQUENCE DEPT_SEQ ORDER; --DEPT_SEQ(번호뽑는 기계)로부터 1,2,3,4 뽑아보기 밑에 숫자

INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '영업부', '대구'); 
--새로운 번호를 시퀀스로부터 가지고 온다.NEXTVAUL로 번호를 뽑기!
INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '인사부', '서울');
INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '총무부', '대구');
INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '기획부', '서울');

COMMIT; -- INSERT 후 COMMMT하여 저장은 필수!!  롤백 커밋 이후의 작업을 취소하는 것임 - 커밋을 취소하는 것이 아님!!!!!

-- 사원번호 시퀀스...
DROP SEQUENCE EMP_SEQ;
CREATE SEQUENCE EMP_SEQ
    START WITH 1001
    ORDER;

INSERT INTO EMPLOYEE_T VALUES(EMP_SEQ.NEXTVAL, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
INSERT INTO EMPLOYEE_T VALUES(EMP_SEQ.NEXTVAL, '김민서', 1, '사원', 'M', '17-09-01', 5000000);
INSERT INTO EMPLOYEE_T VALUES(EMP_SEQ.NEXTVAL, '이은영', 2, '부장', 'F', '90-09-01', 5000000);
INSERT INTO EMPLOYEE_T VALUES(EMP_SEQ.NEXTVAL, '한성일', 2, '과장', 'M', '93-04-01', 5000000);
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






