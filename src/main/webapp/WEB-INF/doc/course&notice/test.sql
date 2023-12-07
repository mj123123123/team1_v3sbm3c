/**********************************/
/* Table Name: 공지사항 */
/**********************************/
DROP TABLE CATE;

CREATE TABLE CATE(
		CATENO                        		NUMBER(10)		 NOT NULL PRIMARY KEY,
		NAME                          		VARCHAR2(30)	 NOT NULL,
		CNT                           		NUMBER(7)		 DEFAULT 0 NOT NULL,
		RDATE                         		DATE		     NOT NULL,
        SEQNO                               NUMBER(5)        DEFAULT 1 NOT NULL,
        VISIBLE                             CHAR(1)          DEFAULT 'N' NOT NULL  
);

COMMENT ON TABLE CATE is '카테고리';
COMMENT ON COLUMN CATE.CATENO is '카테고리 번호';
COMMENT ON COLUMN CATE.NAME is '카테고리 이름';
COMMENT ON COLUMN CATE.CNT is '관련 자료수';
COMMENT ON COLUMN CATE.RDATE is '등록일';
COMMENT ON COLUMN CATE.SEQNO is '출력 순서';
COMMENT ON COLUMN CATE.VISIBLE is '출력 모드';

DROP SEQUENCE CATE_SEQ;

CREATE SEQUENCE CATE_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
  
-- CREATE
INSERT INTO cate(cateno, name, cnt, rdate) VALUES(cate_seq.nextval, '경기도', 0, sysdate); 
INSERT INTO cate(cateno, name, cnt, rdate) VALUES(cate_seq.nextval, '강원도', 0, sysdate); 
INSERT INTO cate(cateno, name, cnt, rdate) VALUES(cate_seq.nextval, '충청남도', 0, sysdate); 

-- READ: LIST
SELECT * FROM cate;
SELECT cateno, name, cnt, rdate, seqno, visible FROM cate ORDER BY cateno ASC;
    CATENO NAME                                  CNT RDATE                    SEQNO V
---------- ------------------------------ ---------- ------------------- ---------- -
         1 경기도                                  0 2023-09-13 12:18:46          1 N
         2 강원도                                  0 2023-09-13 12:18:46          1 N
         3 충청남도                                0 2023-09-13 12:18:46          1 N

-- READ
SELECT cateno, name, cnt, rdate FROM cate WHERE cateno=1;
    CATENO NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 경기도                                  0 2023-09-06 12:09:45
         
-- UPDATE
UPDATE cate SET name='전라도', cnt=1 WHERE cateno=1;
    CATENO NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 전라도                                  1 2023-09-06 12:09:45

-- DELETE
DELETE FROM cate WHERE cateno=1;
DELETE FROM cate WHERE cateno >= 1;

COMMIT;

-- COUNT
SELECT COUNT(*) as cnt FROM cate;
       CNT
----------
         2

-- 우선 순위 높임, 10 등 -> 1 등
UPDATE cate SET seqno = seqno - 1 WHERE cateno=1;
SELECT cateno, name, cnt, rdate, seqno FROM cate ORDER BY cateno ASC;

-- 우선 순위 낮춤, 1 등 -> 10 등
UPDATE cate SET seqno = seqno + 1 WHERE cateno=1;
SELECT cateno, name, cnt, rdate, seqno FROM cate ORDER BY cateno ASC;

-- READ: LIST
SELECT cateno, name, cnt, rdate, seqno FROM cate ORDER BY seqno ASC;

COMMIT;

-- 카테고리 공개 설정
UPDATE cate SET visible='Y' WHERE cateno=1;
SELECT cateno, name, cnt, rdate, seqno, visible FROM cate ORDER BY cateno ASC;

-- 카테고리 비공개 설정
UPDATE cate SET visible='N' WHERE cateno=1;
SELECT cateno, name, cnt, rdate, seqno, visible FROM cate ORDER BY cateno ASC;

COMMIT;

-- 비회원/회원 SELECT LIST, id: list_all_y
SELECT cateno, name, cnt, rdate, seqno, visible 
FROM cate 
WHERE visible='Y'
ORDER BY seqno ASC;

    CATENO NAME                                  CNT RDATE                    SEQNO V
---------- ------------------------------ ---------- ------------------- ---------- -
         2 강원도                                  0 2023-09-13 12:18:46          1 Y


         






