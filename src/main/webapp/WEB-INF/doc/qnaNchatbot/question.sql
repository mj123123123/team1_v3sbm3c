/* Table name: Question */
DROP TABLE QUESTION;

CREATE TABLE QUESTION(
    QUESTNO     NUMBER(10)      NOT NULL,
    MEMBERNO    NUMBER(10)      NOT NULL,   -- FK
    TCATENO     NUMBER(10)      NOT NULL,   -- FK
    TITLE       VARCHAR(50)     NOT NULL,
    QUEST       VARCHAR(300)    NOT NULL,
    RDATE       DATE            NOT NULL,
    FOREIGN KEY (TCATENO) REFERENCES TCATE (TCATENO),
    FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO),
    PRIMARY KEY (QUESTNO)
);

COMMENT ON TABLE QUESTION is '질문';
COMMENT ON COLUMN QUESTION.QUESTNO is '질문 번호';
COMMENT ON COLUMN QUESTION.MEMBERNO is '회원 번호';
COMMENT ON COLUMN QUESTION.TCATENO is '여행 카테고리 번호';
COMMENT ON COLUMN QUESTION.TITLE is '제목';
COMMENT ON COLUMN QUESTION.QUEST is '질문내용';
COMMENT ON COLUMN QUESTION.RDATE is '등록일';

DROP SEQUENCE QUESTION_SEQ;

CREATE SEQUENCE QUESTION_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 99999            -- 최대값: 99999 --> NUMBER(5) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지


commit;


-- INSERT
INSERT INTO question(questno, memberno, tcateno, title, quest, rdate) VALUES (question_seq.nextval, 1, 1, '제목', '내용', sysdate);

INSERT INTO question(questno, memberno, tcateno, title, quest, rdate) VALUES (question_seq.nextval, 1, 1, '먹거리 추천', '글 어떻게 쓰나요?', sysdate);
INSERT INTO question(questno, memberno, tcateno, title, quest, rdate) VALUES (question_seq.nextval, 1, 2, '해변 휴양 글', '내용이 다릅니다. 수정해주세요.', sysdate);
INSERT INTO question(questno, memberno, tcateno, title, quest, rdate) VALUES (question_seq.nextval, 1, 3, '도심', '호캉스 글 올려도 되나요?', sysdate);
INSERT INTO question(questno, memberno, tcateno, title, quest, rdate) VALUES (question_seq.nextval, 1, 3, '질문이요~', '사진 수정해주세요~', sysdate);

-- SELECT
SELECT questno, memberno, tcateno, title, quest, rdate FROM question ORDER BY questno ASC;
SELECT questno, memberno, tcateno, title, quest, rdate FROM question ORDER BY tcateno ASC;
SELECT questno, memberno, tcateno, title, quest, rdate FROM question ORDER BY memberno ASC;
SELECT questno, memberno, tcateno, title, quest, rdate FROM question WHERE tcateno = 3 ORDER BY questno ASC;
SELECT questno, memberno, tcateno, title, quest, rdate FROM question WHERE tcateno = 2 AND quest LIKE '%내용%' ORDER BY questno ASC;

-- DELETE
DELETE FROM question WHERE questno = 13;
-- DELETE FROM question;
-- commit;


-- COUNT
SELECT COUNT(*) as cnt FROM question WHERE tcateno = 1;
SELECT COUNT(*) as cnt FROM question WHERE tcateno = 3 AND quest LIKE '%사진%';


-- UPDATE
-- UPDATE question SET title = '결제 방법', quest = '결제는 어떻게 하나요' WHERE questno  = 1;


-- commit;
















