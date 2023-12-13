/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE REPLY(
		replyno NUMBER(10) NOT NULL PRIMARY KEY,
		contentsno NUMBER(10),
		MEMBERNO NUMERIC(10),
		content CLOB NOT NULL,
        passwd VARCHAR2(20) NOT NULL,
		rdate DATE NOT NULL,
  FOREIGN KEY (contentsno) REFERENCES festival (contentsno),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE reply is '댓글';
COMMENT ON COLUMN reply.replyno is '댓글번호';
COMMENT ON COLUMN reply.contentsno is '컨텐츠번호';
COMMENT ON COLUMN reply.memberno is '회원 번호';
COMMENT ON COLUMN reply.content is '내용';
COMMENT ON COLUMN reply.passwd is '비밀번호';
COMMENT ON COLUMN reply.rdate is '등록일';

DROP SEQUENCE reply_seq;
CREATE SEQUENCE reply_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지


-- 1) 등록
INSERT INTO reply(replyno, contentsno, memberno, content, passwd, rdate)
VALUES(reply_seq.nextval, 1, 3, '꼭 가보고 싶네요!', '1234', sysdate);
INSERT INTO reply(replyno, contentsno, memberno, content, passwd, rdate)
VALUES(reply_seq.nextval, 1, 3, '작년에 가봤는데 너무 좋았어요!', '1234', sysdate);
INSERT INTO reply(replyno, contentsno, memberno, content, passwd, rdate)
VALUES(reply_seq.nextval, 1, 3, '무료라서 좋네요 꼭 가봐야겠어요!', '1234', sysdate);             

-- 2) 전체 목록
SELECT replyno, contentsno, memberno, content, passwd, rdate
FROM reply
ORDER BY replyno DESC;

 REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD RDATE
 ------- ---------- -------- ------- ------ ---------------------
       3          1        1 댓글3     1234   2019-12-17 16:59:38.0
       2          1        1 댓글2     1234   2019-12-17 16:59:37.0
       1          1        1 댓글1     1234   2019-12-17 16:59:36.0
       
-- 3) reply + member join 목록
SELECT m.id,
          r.replyno, r.contentsno, r.memberno, r.content, r.passwd, r.rdate
FROM member m,  reply r
WHERE m.memberno = r.memberno
ORDER BY r.replyno DESC;

-- 4) reply + member join + 특정 contentsno 별 목록
SELECT m.id,
           r.replyno, r.contentsno, r.memberno, r.content, r.passwd, r.rdate
FROM member m,  reply r
WHERE (m.memberno = r.memberno) AND r.contentsno=5
ORDER BY r.replyno DESC;

 ID    REPLYNO CONTENTSNO MEMBERNO CONTENT                                                                                                                                                                         PASSWD RDATE
 ----- ------- ---------- -------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------ ---------------------
 user1       3          1        1 댓글 3                                                                                                                                                                            123    2019-12-18 16:46:43.0
 user1       2          1        1 댓글 2                                                                                                                                                                            123    2019-12-18 16:46:39.0
 user1       1          1        1 댓글 1      
 

-- 5) 삭제
-- 패스워드 검사
SELECT count(passwd) as cnt
FROM reply
WHERE replyno=1 AND passwd='1234';

 CNT
 ---
   1
   
-- 삭제
DELETE FROM reply
WHERE replyno=1;

-- 6) contentsno에 해당하는 댓글 수 확인 및 삭제
SELECT COUNT(*) as cnt
FROM reply
WHERE contentsno=1;

 CNT
 ---
   1

DELETE FROM reply
WHERE contentsno=1;

-- 7) memberno에 해당하는 댓글 수 확인 및 삭제
SELECT COUNT(*) as cnt
FROM reply
WHERE memberno=1;

 CNT
 ---
   1

DELETE FROM reply
WHERE memberno=1;
 
-- 8) 삭제용 패스워드 검사
SELECT COUNT(*) as cnt
FROM reply
WHERE replyno=1 AND passwd='1234';

 CNT
 ---
   0

-- 9) 삭제
DELETE FROM reply
WHERE replyno=1;