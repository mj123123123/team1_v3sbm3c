/**********************************/
/* Table Name: 공지사항 */
/**********************************/

DROP TABLE NOTICE;

CREATE TABLE NOTICE(
		NOTICENO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		TITLE                         		VARCHAR2(50)		 NOT NULL,
		CONTENT                       		VARCHAR2(4000)		 NOT NULL,
		RDATE                          		DATE		 NOT NULL,
		CNT                           		NUMBER(10)		 NULL ,
		ADMINNO                       		NUMBER(5)		 NULL ,
  FOREIGN KEY (ADMINNO) REFERENCES ADMIN (ADMINNO)
);

COMMENT ON TABLE NOTICE is '공지사항';
COMMENT ON COLUMN NOTICE.NOTICENO is '공지사항 번호';
COMMENT ON COLUMN NOTICE.TITLE is '공지사항 제목';
COMMENT ON COLUMN NOTICE.CONTENT is '공지사항 내용';
COMMENT ON COLUMN NOTICE.DATE is '공지사항 등록일';
COMMENT ON COLUMN NOTICE.CNT is '공지사항 조회수';
COMMENT ON COLUMN NOTICE.ADMINNO is '관리자 번호';

DROP SEQUENCE NOTICE_SEQ;

CREATE SEQUENCE NOTICE_SEQ
  START WITH 1         -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2              -- 2번은 메모리에서만 계산
  NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
  
-- CREATE
INSERT INTO notice(noticeno, title, content, rdate, cnt, adminno) VALUES(notice_seq.nextval, '제목0', '내용0', sysdate, 0, 1);
INSERT INTO notice(noticeno, title, content, rdate, cnt, adminno) VALUES(notice_seq.nextval, '제목1', '내용1', sysdate, 0, 2);
INSERT INTO notice(noticeno, title, content, rdate, cnt, adminno) VALUES(notice_seq.nextval, '제목2', '내용2', sysdate, 0, 3);

-- READ: LIST
SELECT * FROM notice;
SELECT noticeno, title, content, rdate, cnt, adminno FROM notice ORDER BY noticeno ASC;
    NOTICENO NAME                                  CNT RDATE                    SEQNO V
---------- ------------------------------ ---------- ------------------- ---------- -
         1 경기도                                  0 2023-09-13 12:18:46          1 N
         2 강원도                                  0 2023-09-13 12:18:46          1 N
         3 충청남도                                0 2023-09-13 12:18:46          1 N

-- READ
SELECT noticeno, title, content, rdate, cnt, adminno FROM notice WHERE noticeno=1;
    NOTICENO NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 경기도                                  0 2023-09-06 12:09:45
         
-- UPDATE
UPDATE notice SET name='전라도', cnt=1 WHERE noticeno=1;
    NOTICENO NAME                                  CNT RDATE              
---------- ------------------------------ ---------- -------------------
         1 전라도                                  1 2023-09-06 12:09:45

-- DELETE
DELETE FROM notice WHERE noticeno=1;
DELETE FROM notice WHERE noticeno >= 1;

COMMIT;

-- COUNT
SELECT COUNT(*) as cnt FROM notice;
       CNT
----------
         2

-- 우선 순위 높임, 10 등 -> 1 등
UPDATE notice SET seqno = seqno - 1 WHERE noticeno=1;
SELECT noticeno, name, cnt, rdate, seqno FROM notice ORDER BY noticeno ASC;

-- 우선 순위 낮춤, 1 등 -> 10 등
UPDATE notice SET seqno = seqno + 1 WHERE noticeno=1;
SELECT noticeno, name, cnt, rdate, seqno FROM notice ORDER BY noticeno ASC;

-- READ: LIST
SELECT noticeno, name, cnt, rdate, seqno FROM notice ORDER BY seqno ASC;

COMMIT;

-- 카테고리 공개 설정
UPDATE notice SET visible='Y' WHERE noticeno=1;
SELECT noticeno, name, cnt, rdate, seqno, visible FROM notice ORDER BY noticeno ASC;

-- 카테고리 비공개 설정
UPDATE notice SET visible='N' WHERE noticeno=1;
SELECT noticeno, name, cnt, rdate, seqno, visible FROM notice ORDER BY noticeno ASC;

COMMIT;

-- 비회원/회원 SELECT LIST, id: list_all_y
SELECT noticeno, name, cnt, rdate, seqno, visible 
FROM notice 
WHERE visible='Y'
ORDER BY seqno ASC;

    NOTICENO NAME                                  CNT RDATE                    SEQNO V
---------- ------------------------------ ---------- ------------------- ---------- -
         2 강원도                                  0 2023-09-13 12:18:46          1 Y


         






