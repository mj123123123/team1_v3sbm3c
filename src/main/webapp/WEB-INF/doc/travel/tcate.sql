/* Table name: TCATE */
DROP TABLE TCATE;

CREATE TABLE TCATE(
    TCATENO       NUMBER(10)      NOT NULL,
    NAME    VARCHAR2(30)      NOT NULL,   
    SEQNO      NUMBER(7)     DEFAULT 1   NOT NULL,   
    VISIBLE    CHAR(1)   DEFAULT 'N'     NOT NULL,
    PRIMARY KEY (TCATENO)
);

COMMENT ON TABLE TCATE is '여행 카테고리';
COMMENT ON COLUMN TCATE.TCATENO is '여행 카테고리 번호';
COMMENT ON COLUMN TCATE.NAME is '카테고리 이름';
COMMENT ON COLUMN TCATE.SEQNO is '출력 순서';
COMMENT ON COLUMN TCATE.VISIBLE is '출력 모드';

DROP SEQUENCE TCATE_SEQ;

CREATE SEQUENCE TCATE_SEQ
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 99999            -- 최대값: 99999 --> NUMBER(5) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지

-- CREATE
INSERT INTO tcate(tcateno, name) VALUES(tcate_seq.nextval, '먹거리');
INSERT INTO tcate(tcateno, name) VALUES(tcate_seq.nextval, '해변휴양');
INSERT INTO tcate(tcateno, name) VALUES(tcate_seq.nextval, '도심');
INSERT INTO tcate(tcateno, name) VALUES(tcate_seq.nextval, '문화');
INSERT INTO tcate(tcateno, name) VALUES(tcate_seq.nextval, '레저');
INSERT INTO tcate(tcateno, name) VALUES(tcate_seq.nextval, '캠핑');

-- READ(LIST)
SELECT tcateno, name, seqno, visible 
FROM tcate 
ORDER BY seqno ASC;

-- READ
SELECT tcateno, name
FROM tcate
WHERE tcateno=2;

-- UPDATE
UPDATE tcate 
SET name='음식' 
WHERE tcateno=1;

-- DELETE
DELETE FROM tcate WHERE tcateno=1;
DELETE FROM tcate WHERE tcateno >= 3;