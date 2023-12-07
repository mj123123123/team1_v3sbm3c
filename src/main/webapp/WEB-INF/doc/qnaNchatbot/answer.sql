/* Table name: ANSWER */
DROP TABLE ANSWER;

CREATE TABLE ANSWER(
    ANSNO       NUMBER(10)      NOT NULL,
    QUESTNO     NUMBER(10)      NOT NULL,   -- FK
    ANS         VARCHAR(300)    NOT NULL,
    ADMINNO     NUMBER(5)       NOT NULL,   -- FK
    RDATE       DATE            NOT NULL,
    PRIMARY KEY (ANSNO)
);

COMMENT ON TABLE ANSWER is '응답';
COMMENT ON COLUMN ANSWER.ANSNO is '답변 번호';
COMMENT ON COLUMN ANSWER.QUESTNO is '질문 번호';
COMMENT ON COLUMN ANSWER.ANS is '답변 내용';
COMMENT ON COLUMN ANSWER.ADMINNO is '관리자 번호';
COMMENT ON COLUMN ANSWER.RDATE is '등록일';

DROP SEQUENCE ANSWER_SEQ;

CREATE SEQUENCE ANSWER_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 99999            -- 최대값: 99999 --> NUMBER(5) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지


commit;


-- INSERT
INSERT INTO answer(ansno, questno, ans, adminno, rdate) VALUES (answer_seq.nextval, 1, '카드, 무통장입금, 계좌이체 등', 1, sysdate);


-- SELECT
SELECT ansno, questno, ans, adminno, rdate FROM answer ORDER BY ansno DESC;
SELECT ansno, questno, ans, adminno, rdate FROM answer WHERE adminno = 2 ORDER BY ansno DESC;
SELECT ansno, questno, ans, adminno, rdate FROM answer WHERE adminno = 2 AND ans LIKE '%카드%' ORDER BY ansno DESC;

-- DELETE
-- DELETE FROM answer WHERE ansno = 1;
-- DELETE FROM answer;
-- commit;


-- COUNT
SELECT COUNT(*) as cnt FROM answer WHERE ansno = 1;
SELECT COUNT(*) as cnt FROM answer WHERE ansno = 1 AND ans LIKE '%카드%';


-- UPDATE
-- UPDATE answer SET ans = '카드, 무통장입금 등' WHERE ansno = 1;


-- commit;