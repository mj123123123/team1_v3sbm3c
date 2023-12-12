/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE REPLY(
		replyno NUMBER(10) NOT NULL PRIMARY KEY,
		reviewno NUMBER(10),
		MEMBERNO NUMERIC(10),
		content CLOB NOT NULL,
		rdate DATE NOT NULL,
  FOREIGN KEY (reviewno) REFERENCES REVIEW (reviewno),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

DROP SEQUENCE reply_seq;

CREATE SEQUENCE reply_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지
  
  
INSERT INTO reply (replyno, reviewno, MEMBERNO, content, rdate
) VALUES (1, 1, 101, '...', SYSDATE);

UPDATE reply SET content = '수정된 댓글 내용'
WHERE replyno = 1;

DELETE FROM reply
WHERE replyno = 1;








