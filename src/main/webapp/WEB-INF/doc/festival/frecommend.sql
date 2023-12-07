/**********************************/
/* Table Name: 추천 */
/**********************************/
DROP TABLE FRECOMMEND;

CREATE TABLE FRECOMMEND(
        FRECOMMENDNO                           NUMBER(8)         NOT NULL         PRIMARY KEY,
        MEMBERNO                              NUMBER(10)         NULL ,
        FCATENO                                NUMBER(10)         NULL ,
        SEQ                                   NUMBER(2)         DEFAULT 1         NOT NULL,
        RDATE                                 DATE         NOT NULL,
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO),
  FOREIGN KEY (FCATENO) REFERENCES CATE (FCATENO)
);

COMMENT ON TABLE FRECOMMEND is '추천';
COMMENT ON COLUMN FRECOMMEND.FRECOMMENDNO is '추천번호';
COMMENT ON COLUMN FRECOMMEND.MEMBERNO is '회원번호';
COMMENT ON COLUMN FRECOMMEND.FCATENO is '카테고리번호';
COMMENT ON COLUMN FRECOMMEND.seq is '추천 우선순위';
COMMENT ON COLUMN FRECOMMEND.RDATE is '추천 날짜';

DROP SEQUENCE FRECOMMEND_SEQ;

CREATE SEQUENCE FRECOMMEND_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

-- 존재하는 memberno, FCATENO 등록
INSERT INTO frecommend(frecommendno, memberno, FCATENO, seq, rdate)
VALUES(FRECOMMEND_SEQ.nextval, 1, 15, 1, sysdate);

SELECT frecommendno, memberno, FCATENO, seq, rdate 
FROM frecommend 
ORDER BY frecommendno ASC;
-- 1번회원은 1번 카테고리를 추천필요.
FRECOMMENDNO   MEMBERNO     FCATENO        SEQ RDATE              
----------- ---------- ---------- ---------- -------------------
          6          1          1          1 2023-06-15 02:53:32

DELETE FROM FRECOMMEND;
DELETE FROM FRECOMMEND WHERE memberno=1;
COMMIT;