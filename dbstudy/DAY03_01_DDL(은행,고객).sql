/*
    DDL
    1. Date Difinition Language
    2. 데이터베이스 객체를 다루는 언어
    3. 트랜잭션 대상이 아니다.(작업을 취소할 수 없다.- 저장도할 수 없다.)
       ㄴ트랜잭션 : 반드시 한 번에 수행이 마무리 되어야하는 작업
                    (ex)은행이체 출금 + 입금, 두 가지가 반드시 성공해야 이체가 진행됨)
    4. 종류
        1) CREATE   : 생성
        2) ALTER    : 수정
        3) DROP     : 삭제
        4) TRUNCATE : 삭제(내용만 삭제) - 테이블로 따지면 모든 행만 지움(열은 그대로)
*/

--테이블 삭제
DROP TABLE CUSTOMER_TBL;
DROP TABLE BANK_TBL;

--BANK_TBL 테이블 생성
CREATE TABLE BANK_TBL(
      BANK_CODE VARCHAR2(20 BYTE) NOT NULL
    , BANK_NAME VARCHAR2(30 BYTE) NULL
    , CONSTRAINT PK_BANK PRIMARY KEY(BANK_CODE)
);
--CUSTOMER_TBL 테이블 생성
CREATE TABLE CUSTOMER_TBL(
      NO        NUMBER               NOT NULL
    , NAME      VARCHAR2(30 BYTE)    
    , PHONE     VARCHAR2(30 BYTE)    UNIQUE
    , AGE       NUMBER               CHECK(AGE BETWEEN 0 AND 1000) -- 100도 들어감
    , BANK_CODE VARCHAR2(20 BYTE)    
    , CONSTRAINT PK_CUST PRIMARY KEY(NO)
    , CONSTRAINT FK_BANK_CUST FOREIGN KEY(BANK_CODE) REFERENCES BANK_TBL (BANK_CODE)
);

/*
ALTER 거의 쓸일 없음
    테이블 수정하기
    1. 칼럼 추가   : ALTER TABLE 테이블명 ADD 칼럼명 데이터타입[제약조건]
    2. 컬럼 수정   : ALTER TABLE 테이블명 MODIFY 칼럼명 데이터타임[제약조건]
    3. 칼럼 삭제   : ALTER TABLE 테이블명 DROP COLUMN 칼럼명
    4. 칼럼 이름   : ALTER TABLE 테이블명 RENAME COLUMN 기존칼럼명 TO 신규 칼럼명
    5. 테이블 이름 : ALTER TABLE 테이블명 RENAME TO 신규테이블명
    6. PK/FK제약조건 : 
        1)PK
            (1) 추가 
                ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 PRIMARY KEY(칼럼)
            (2) 삭제
                ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명 
                ALTET TABLE 테이블명 DRPO PRIMARY KEY 
        2) FK
            (1) 추가
                ALTER TABLE 자식테이블명ADD CONSTRAINT 제약조건명 FOREIGN KEY(칼럼) REFERENCES 부모테이블(참조할 칼럼)
            (2) 삭제
                ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명
*/

--실습.

--1. 은행 테이블에 연락처(BANK_TEL) 칼럼을 추가하시오.
ALTER TABLE BANK_TBL ADD BANK_TEL VARCHAR2(15 BYTE) NOT NULL;   

--2. 은행 테이블의 은행명(BANK_NAME) 칼럼의 데이터타입을 VARCHAR2(15 BYTE)로 변경하시오
ALTER TABLE BANK_TBL MODIFY BANK_NAME VARCHAR2(15 BYTE);

--3. 고객테이블의 나이(AGE) 칼럼을 삭제하시오.
ALTER TABLE CUSTOMER_TBL DROP COLUMN AGE;

--4. 고객 테이블의 고객변호(NO) 칼럼명을 CUST_NO으로 변경하시오.
ALTER TABLE CUSTOMER_TBL RENAME COLUMN NO TO CUST_NO;

--5. 고객 테이블에 GRADE 칼럼을 추가하시오. ('VIP','GOLD','SLIVER','BRONZE'중 하나의 값을 가지도록 한다.) /CHECK 제약 조건
 -- 문자 ' " 혼합해서 사용 가능 - 일반적으로 ' 작은 따옴표 사용 (5번 둘 중 하나만 실행)
ALTER TABLE CUSTOMER_TBL ADD GRADE VARCHAR2(6 BYTE) CHECK(GRADE = 'VIP' OR GRADE = 'GOLD' OR GRADE = 'SLIVER' OR GRADE = 'BRONZE');
--ALTER TABLE CUSTOMER_TBL ADD GRADE VARCHAR2(6 BYTE) CHECK(GRADE IN('VIP','GOLD','SLIVER','BRONZE'));

--6. 고객 테이블의 고객명(NAME)과 연락처(PHONE) 칼럼 이름을 CUST_MANE, CUST_PHON으로 변경하시오.
ALTER TABLE CUSTOMER_TBL RENAME COLUMN NAME TO CUST_NAME;
ALTER TABLE CUSTOMER_TBL RENAME COLUMN PHONE TO CUST_PHON;

--7. 고객테이블의 고객연락처(CUST_PHONE)칼럼을 필수칼럼으로 변경하시오. ㅜNOT NULL
ALTER TABLE CUSTOMER_TBL MODIFY CUST_PHON VARCHAR2(30 BYTE) NOT NULL;

--8. 고객테이블의 고객명(CUST_NAME)칼럼의 필수 제약조건을 없애시오.
ALTER TABLE CUSTOMER_TBL MODIFY CUST_NAME VARCHAR2(30 BYTE) NOT NULL; -- 반드시 NULL을 명시해야한다.

-- 테이블 구조 확인하기  -> 네글자 써서 실행 가능
--DESCRIBE BANK_TBL;

-- 테이블 구조 확인하기  -> 네글자 써서 실행 가능
DESC BANK_TBL;

