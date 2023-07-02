/* 
    테이블(table)
    1.  데이터베이스에서 데이터를 저장하는 객체이다.
    2. 표 형식을 가진다.
    3. 행(row)과 열(column)의 집합 형태이다.
*/

/*
    데이터 타입
    1. NUMBER(p,s) : 정밀도 p, 스케일 s로 표현하는 숫자 형식
        1) 정밀도 p : 전체 유효 숫자의 갯수 (0, 01, 001 - 의미 있는 숫자는 1개)
        2) 스케일 s : 소수부의 유효 숫자의 갯수
                     (소수점만 따로 몇글자 유효한가, 0.1 ->1, 0.01 ->2, 0.10 ->1)
                      0.99 정밀도: 2, 스케일 : 4, number(2,2) 전체 두자리, 소수점 2자리 -> ~0.99
                      백분율로 유사한 숫자들이 사용됨
     2. char(size) : 고정 문자(character)
        1) 글자 수가 고정된 타입(예시 : 핸드폰번호, 주민번호 등)
        2) size : 2000 byte, 1byte(영어나 숫자 한글자)
     3. VARCHAR2(size) : 가변문자
        1) 글자 수가 고정되지 않은 타입(예시 : 이름, 이메일, 주소 등)
        2) size : 최대 4000 byte 
     4. CLOB : 큰 텍스트 타입 
     5. DATE : 날짜와 시간을 동시에 표현하는 타입(년, 월, 일, 시, 분, 초)
     6. TIMESTAMP : 날짜와 시간을 동시에 표현하는 타임(년,월,일,시,분,초,마이크로초(백만분의 1초))
*/

/* 
    테이블 제약 조건 5가지(칼럼)
    1. NOT NULL    : 필수
    2. UNIQUE      : 중복 불가
    3. PRIMARY KEY : 기본키
    4. FOREIGN KEY : 외래키
    5. CHECK       : 값의 제한
*/

/*
CREATE TABLE CUSTOMER_T(
    고객번호    NUMBER NOT NULL PRIMARY KEY
  , 아이디      VARCHAR2(32 BYTE) NOT NULL UNIQUE
  , 이름        VARCHAR2(32 BYTE) NOT NULL
  , 직업        VARCHAR2(32 BYTE) NOT NULL
  , 전화번호    VARCHAR2(11 BYTE) NULL UNIQUE
  , 주민번호    VARCHAR2(13 BYTE) NOT NULL UNIQUE
);
*/


--고객테이블
DROP TABLE CUSTOMER_T; // 없으니까 못지워서 처음은 오류 날 수 있음 - 다시 돌리면 괜춘
CREATE TABLE CUSTOMER_T(
    NO    NUMBER NOT NULL PRIMARY KEY
 ,  ID    VARCHAR2(32 BYTE) NOT NULL UNIQUE
 ,  NAME  VARCHAR2(32 BYTE) NOT NULL 
 ,  JOB   VARCHAR2(32 BYTE) NULL
 ,  PHONE CHAR(13 BYTE) NULL UNIQUE
 , JUBUN  VARCHAR2(14 BYTE) NOT NULL UNIQUE
 );
 
 
