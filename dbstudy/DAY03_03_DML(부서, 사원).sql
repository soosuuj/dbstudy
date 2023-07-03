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
