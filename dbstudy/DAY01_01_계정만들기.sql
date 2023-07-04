
-- 한줄 주석(설명)
--여러 줄 주석(설명)
/*

    SQL DEVELOPER 쿼리문 실행 하는 방법
    1. 커서를 두고 CTRL + ENTER: 커서가 있는 커리문만 실행된다.
    2. 블록을 잡고 CTRL + ENTER : 블록이 잡힌 모든 쿼리문이 실행된다.
    3. 그냥 F5                   : 전체 스크립트가 실행된다.

*/

/*  
 관리자 계정
 1. SYS, SYSTEM 계정이다.
 2. 관리자 계정으로 접속해서 수업에서 사용할 사용할 계정을 만든다.
 3. 관리자 계정으로 작업하지 않도록 주의한다.
 
 */
 /* 새로운 계정을 만드는 방법
    1. CREATE USER 계정명 IDENRIFIED BY 비밀번호;
    2. GRANT 권한 TO 계정명; 
*/

--CREATE USER C##GD IDENTIFIED BY 1111;
--GRANT CONNECT TO C##GD;

/*
    기존 계정을 삭제하는 방법
    1. 계정이 가진 데이터가 없을 때 : DPOP USER 계정명;
    2. 계정이 가진 데이터가 있을 때 : DROP USER 계정명 CASCADE;
*/

--DROP USER C##GD;

--새로운 계정을 만드는 전체 스크립트
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
DROP USER GD CASCADE; --객체가 있는 사용자 지울 때 사용
CREATE USER GD IDENTIFIED BY 1111;
GRANT DBA TO GD;

