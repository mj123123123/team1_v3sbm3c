-- 테이블 드랍 시키기 --
DROP TABLE MEMBER;
DROP TABLE ADMIN;
DROP TABLE TERMS;
DROP TABLE TERMSAGREE;
DROP TABLE LOG;
----------------------

-- 테이블 생성하기 --
CREATE TABLE MEMBER (
    memberno NUMERIC(10) PRIMARY KEY,
    mname VARCHAR(50),
    id VARCHAR(50),
    password VARCHAR(250),
    birthdate VARCHAR(15),
	email VARCHAR(50),
    address1 VARCHAR(50),
    address2 VARCHAR(50),
    joindate DATETIME,
    grade NUMERIC(2)
);

CREATE TABLE ADMIN (
    adminno NUMERIC(5) PRIMARY KEY,
    aname VARCHAR(50),
    id VARCHAR(50),
    password VARCHAR(250),
);

CREATE TABLE TERMS (
    termsno NUMERIC(10) PRIMARY KEY,
    title VARCHAR(50),
    content VARCHAR(250),
    termsdate VARCHAR(15)
);

CREATE TABLE TERMSAGREE (
    termsagreeno NUMERIC(10) PRIMARY KEY,
    memberno NUMERIC(10),
    termsno NUMERIC(10),
    agreedate VARCHAR(15)
);

CREATE TABLE LOG (
    memberno NUMERIC(20),
    id VARCHAR(50),
    password VARCHAR(250),
    joindate DATETIME,
	passwordchangedate DATETIME,
    lastlogindate DATETIME,
    lastloginno INT
);
----------------------

-- 테이블 및 컬럼 이름 설명하기 --
COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEMBERNO is '회원 번호';
COMMENT ON COLUMN MEMBER.MNAME is '성명';
COMMENT ON COLUMN MEMBER.ID is '아이디';
COMMENT ON COLUMN MEMBER.PASSWORD is '패스워드';
COMMENT ON COLUMN MEMBER.BIRTHDATE is '생년월일';
COMMENT ON COLUMN MEMBER.EMAIL is '이메일';
COMMENT ON COLUMN MEMBER.ADDRESS1 is '주소1';
COMMENT ON COLUMN MEMBER.ADDRESS2 is '주소2';
COMMENT ON COLUMN MEMBER.JOINDATE is '가입일';
COMMENT ON COLUMN MEMBER.GRADE is '등급';
----------------------

-- 테이블 및 컬럼 이름 지정하기 --
INSERT INTO ADMIN (adminno, name, id, password, joindate)
VALUES (1, '관리자1', 'admin1', '1234', '2023-12-06');
