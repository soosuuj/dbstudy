/*
--DUAL은 이름만 빌려주는 테이블.. FROM절이 필요없지만 오라클 문법 때문에 필요할 때 사용!
SELECT 1 + 1 FROM DUAL; 

CREATE SEQUENCE TEST_SEQ ORDER; 
SELECT TEST_SEQ.NEXTVAL FROM DUAL; -- 실행 할 때마다 +1 된 숫자 출력됨.
*/

/*
    DUAL 테이블
    1. DUMMY 칼럼 1개를 가지고 있는 테이블이다.
    2. 'X'값을 가지고 있다.
    3. FROM절이 필요 없는 SELECT문을 사용할 때  DUAL 테이블을 이용한다.
*/

--데이터 타입 변환 : 숫자, 날짜, 문자 등의 데이터 타입을 바꿈

/* 1. 문자를 숫자로 변환하기
        TO_NUMBER(문자)
*/
SELECT TO_NUMBER('123')
  FROM DUAL;

/*
    2. 숫자를 문자로 변환하가ㅣ
        TO_CHAR(숫자, [형식]) -- 형식은 생략 가능
*/

SELECT TO_CHAR(1234)            -- '1234'
     , TO_CHAR(1234, '999999')  -- '  1234' - 출력되는 문자의 폭 조절 가능!
     -- 공백 2개 들어있음, 999999 - 6자리로 숫자를 나타내라는 뜻! 
     , TO_CHAR(1234, '000000')  -- '001234' 앞자리에 0을 채워서 출력
     , TO_CHAR(1234, '9,999')   -- '1,234' 천단위 구분 기호가 붙음
     , TO_CHAR(12345, '99,999') -- '12,345'
     , TO_CHAR(12345, '9,999')  -- '#####'  숫자는 5자리인데, 형식은 4자리만 지정되었다. 
  FROM DUAL;
  
  /*
  3. 날짜를 문자로 변환하기
      TO_CHAR(날짜, [형식])
      
      * 날짜/시간 형식
      1) YY   : 년도 2자리
      2) YYYY : 년도 4자리
      3) MM   : 월 2자리(01~12)
      4) DD   : 일 2자리(01~31)
      5) AM   : 오전 / 오후     - 5번, 6번 세뚜
      6) HH   : 12시각(01~12)
      7) HH24 : 24시각(01~23)   - 시간만 표시
      8) MI   : 분(00~59)
      9) SS   : 초(00~59)
  */

SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
  FROM EMPLOYEES;
  
/*
    4. 문자 -> 날짜로 변환하기
    TO_DATE(문자, [형식])  - 형식은 생략 가능
*/
--현재 날짜와 시간을 사용하는 함수
SELECT SYSDATE        -- '23/07/04'
      ,SYSTIMESTAMP   -- '23/07/04 14:46:44.303000000 +09:00'
  FROM DUAL;

-- 현재 날짜와 시간 - 형식 지정
SELECT TO_CHAR(SYSDATE,      'YYYY-MM-DD AM HH:MI:SS')  -- 날짜도 함께 사용 가넝
     , TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')
  FROM DUAL;

--문자로 된 날짜/시간을 실제 날짜/시간 타입으로 변환하기
SELECT TO_DATE('23/07/04')             --'년/월/일' 형식으로 해석
     , TO_DATE('23/07/04', 'DD/MM/YY') --'일/월/년' 형식으로 해석
   FROM DUAL;

-- 예제 데이터 작성
DROP TABLE EXAMPLE_T;
CREATE TABLE EXAMPLE_T(
      DT1 DATE
    , DT2 TIMESTAMP
);
INSERT INTO EXAMPLE_T(DT1, DT2) VALUES(SYSDATE, SYSTIMESTAMP);
COMMIT;

--DT1이 '23년/07/04'인 데이터를 조회하기(안 됨) 안되는게 맞는거임!
SELECT * 
  FROM EXAMPLE_T
 WHERE DT1 = '23/07/04';

-- DT1DL '23/07/04'인 데이터를 조회하기(안 됨)
SELECT *
   FROM EXAMPLE_T
   WHERE DT1 = TO_DATE('23/07/04', 'YY/MM/DD');

-- DT1이 '23/07/04'인 데이터를 조회하기(됨)
SELECT *
  FROM EXAMPLE_T
 WHERE TO_DATE(DT1, 'YY/MM/DD') = TO_DATE('23/07/04', 'YY/MM/DD');
 

   
   