/**********************************/
/* Table Name: 축제/행사 카테고리 */
/**********************************/

DROP TABLE FCATE;

CREATE TABLE FCATE(
		FCATENO                        		NUMBER(10)		 NOT NULL PRIMARY KEY,
		NAME                          		VARCHAR2(30)	 NOT NULL,
		CNT                           		NUMBER(7)		 DEFAULT 0 NOT NULL,
		RDATE                         		DATE		     NOT NULL,
    SEQNO                               NUMBER(5)        DEFAULT 1 NOT NULL,
    VISIBLE                             CHAR(1)          DEFAULT 'N' NOT NULL  
);
--
--COMMENT ON TABLE FCATE is '카테고리';
COMMENT ON COLUMN FCATE.FCATENO is '카테고리 번호';
COMMENT ON COLUMN FCATE.NAME is '카테고리 이름';
COMMENT ON COLUMN FCATE.CNT is '관련 자료수';
COMMENT ON COLUMN FCATE.RDATE is '등록일';
COMMENT ON COLUMN FCATE.SEQNO is '출력 순서';
COMMENT ON COLUMN FCATE.VISIBLE is '출력 모드';

DROP SEQUENCE FCATE_SEQ;

CREATE SEQUENCE FCATE_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
  
-- CREATE
INSERT INTO FCATE(FCATEno, name, cnt, rdate) VALUES(FCATE_seq.nextval, '테마별', 0, sysdate); 
INSERT INTO FCATE(FCATEno, name, cnt, rdate) VALUES(FCATE_seq.nextval, '지역별', 0, sysdate); 

-- READ: LIST
SELECT * FROM FCATE;
SELECT FCATEno, name, cnt, rdate, seqno, visible FROM FCATE ORDER BY FCATEno ASC;
    FCATENO NAME                                  CNT RDATE                    SEQNO V
---------- ------------------------------ ---------- ------------------- ---------- -
         1 경기도                                  0 2023-09-13 12:18:46          1 N
         2 강원도                                  0 2023-09-13 12:18:46          1 N
         3 충청남도                                0 2023-09-13 12:18:46          1 N

-- READ
SELECT FCATEno, name, cnt, rdate FROM FCATE WHERE FCATEno=1;
    FCATENO NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 경기도                                  0 2023-09-06 12:09:45
         
-- UPDATE
UPDATE FCATE SET name='전라도', cnt=1 WHERE FCATEno=1;
    FCATENO NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 전라도                                  1 2023-09-06 12:09:45

-- DELETE
DELETE FROM FCATE WHERE FCATEno=7;
DELETE FROM FCATE WHERE FCATEno >= 10;

COMMIT;

-- COUNT
SELECT COUNT(*) as cnt FROM FCATE;
       CNT
----------
         2

-- 우선 순위 높임, 10 등 -> 1 등
UPDATE FCATE SET seqno = seqno - 1 WHERE FCATEno=1;
SELECT FCATEno, name, cnt, rdate, seqno FROM FCATE ORDER BY FCATEno ASC;

-- 우선 순위 낮춤, 1 등 -> 10 등
UPDATE FCATE SET seqno = seqno + 1 WHERE FCATEno=1;
SELECT FCATEno, name, cnt, rdate, seqno FROM FCATE ORDER BY FCATEno ASC;

-- READ: LIST
SELECT FCATEno, name, cnt, rdate, seqno FROM FCATE ORDER BY seqno ASC;

COMMIT;

-- 카테고리 공개 설정
UPDATE FCATE SET visible='Y' WHERE FCATEno=1;
SELECT FCATEno, name, cnt, rdate, seqno, visible FROM FCATE ORDER BY FCATEno ASC;

-- 카테고리 비공개 설정
UPDATE FCATE SET visible='N' WHERE FCATEno=1;
SELECT FCATEno, name, cnt, rdate, seqno, visible FROM FCATE ORDER BY FCATEno ASC;

COMMIT;

-- 비회원/회원 SELECT LIST, id: list_all_y
SELECT FCATEno, name, cnt, rdate, seqno, visible 
FROM FCATE 
WHERE visible='Y'
ORDER BY seqno ASC;

    FCATENO NAME                                  CNT RDATE                    SEQNO V
---------- ------------------------------ ---------- ------------------- ---------- -
         2 강원도                                  0 2023-09-13 12:18:46          1 Y


         






