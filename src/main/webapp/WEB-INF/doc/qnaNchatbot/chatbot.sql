/* Table name: CHATBOT */
DROP TABLE CHATBOT;

CREATE TABLE CHATBOT(
    CHATBOTNO       NUMBER(10)      NOT NULL,
    MEMBERNO        NUMBER(10)      NOT NULL,   -- FK
    PRIMARY KEY (CHATBOTNO)
);

COMMENT ON TABLE CHATBOT is '응답';
COMMENT ON COLUMN CHATBOT.CHATBOTNO is '챗봇 번호';
COMMENT ON COLUMN CHATBOT.MEMBERNO is '회원 번호';

DROP SEQUENCE CHATBOT_SEQ;

CREATE SEQUENCE CHATBOT_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 99999            -- 최대값: 99999 --> NUMBER(5) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지


------------------------------------------------------------------------------------
/*AWS-kd의 CHATTING 테이블*/
-- 조회
-- 2023-11-24일자 채팅만 출력
SELECT chattingno, memberno, msg, rdate
FROM chatting
WHERE memberno=1 and SUBSTR(rdate, 1, 10) = '2023-11-24';

-- 시분초 일치하지 않음, 조회안됨
SELECT chattingno, memberno, msg, rdate
FROM chatting
WHERE memberno=1 and rdate = TO_DATE('2023-11-24', 'YYYY-MM-DD');

-- 문열로 변경하는 가능함
SELECT chattingno, memberno, msg, rdate
FROM chatting
WHERE memberno=1 and TO_CHAR(rdate, 'YYYY-MM-DD') = '2023-11-24';

-- LIKE
SELECT chattingno, memberno, msg, rdate
FROM chatting
WHERE memberno=1 and msg LIKE '%안녕%';





