/*
     M:N 관계
     1. 현실세계에서 빈번히 나타나지만 주의해야하는 관계이다.
     2. M:N 관계를 가진 2개의 테이블은 직접 관계를 맺는 것이 불가능하다.
     3. 관계를 맺기 위해서 별도의 테이블이 추가로 필요하다.
     4. M:N 관계는 1:M관계 2개로 구현 할 수 있다.
*/
/*
노래마다 해시태그 달기

노래      -       노래-해시테그     -   해시태그
A                  A   NEW              NEW
B                  A   HOT              HOT
                   B   NEW
                   
*/
--수강신청 전에는 과목이 만들어져야한다. / 학생과 과목은 관계가 없어 순서 정할 필요 없음

--삭제는 생성의 역순으로 진행
DROP TABLE ENROLL_T;
DROP TABLE SUBJECT_T;
DROP TABLE UNIV_STUDENT_T;


--학생 테이블
CREATE TABLE UNIV_STUDENT_T (
     STU_NO   NUMBER            NOT NULL
   , STU_NAME VARCHAR2(10 BYTE) NOT NULL
   , AGE      NUMBER 
   , CONSTRAINT PK_UNIV_STU PRIMARY KEY(STU_NO)
);

--과목 테이블
CREATE TABLE SUBJECT_T (
    SBJ_CODE  VARCHAR2(5 BYTE)   NOT NULL 
  , SBJ_NAME  VARCHAR2(10 BYTE)  NOT NULL
  , PROFESSOR VARCHAR2(10 BYTE)  NOT NULL
  , CONSTRAINT PK_SUJ PRIMARY KEY(SBJ_CODE)
);

--수강신청 테이블
CREATE TABLE ENROLL_T(
    EN_NO    NUMBER NOT NULL --PRIMARY KEY
  , STU_NO   NUMBER --REFERENCES STUDENT_T(STU_NO)
  , SBJ_CODE VARCHAR2(5 BYTE) --REFERENCES SUBJECT_T(SBJ_CODE)
  , CONSTRAINT PK_EN PRIMARY KEY(EN_NO)
  , CONSTRAINT FK_UNIV_STU_EN FOREIGN KEY(STU_NO) REFERENCES UNIV_STUDENT_T(STU_NO)
  , CONSTRAINT FK_SBJ_EN FOREIGN KEY(SBJ_CODE) REFERENCES SUBJECT_T(SBJ_CODE)
  
);
                   
                   