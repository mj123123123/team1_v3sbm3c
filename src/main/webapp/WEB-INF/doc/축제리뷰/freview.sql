/**********************************/
/* Table Name: 축제/행사 리뷰 */
/**********************************/
DROP TABLE FREVIEW;

CREATE TABLE FREVIEW(
		reviewno NUMBER(10) NOT NULL PRIMARY KEY,
        fcateno NUMBER(10),
		contentsno NUMBER(10),
		MEMBERNO NUMERIC(10),
        nickname VARCHAR2(50) NOT NULL,
		title VARCHAR2(100) NOT NULL,
		content CLOB NOT NULL,
        pwd VARCHAR2(10),
		rdate DATE NOT NULL,
        cnt NUMERIC(10),
        word VARCHAR2(100),
		file1 VARCHAR2(200),
        file1saved VARCHAR2(400),
		thumb1 VARCHAR2(200),
		size1 NUMBER(10),
		map VARCHAR2(2000),
    FOREIGN KEY (fcateno) REFERENCES FCATE (fcateno),
    FOREIGN KEY (contentsno) REFERENCES FESTIVAL (contentsno),
    FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

DROP SEQUENCE review_seq;

CREATE SEQUENCE review_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지
  
  
INSERT INTO FREVIEW (reviewno, fcateno, contentsno, MEMBERNO, nickname, title, content, pwd, rdate, cnt, word, file1, file1saved, thumb1, size1, map) 
VALUES (review_seq.nextval, 9, 1, 3, '아로미', '빛 축제', '처음 가봤는데 너무 이쁘고 좋았어요', '1234', sysdate, 0, '서울, 청계천', 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 'sample_map_url');

INSERT INTO FREVIEW (reviewno, fcateno, contentsno, MEMBERNO, nickname, title, content, pwd, rdate,  cnt, word, file1, file1saved, thumb1, size1, map) 
VALUES (review_seq.nextval, 9, 1, 3, '청계천 빛 축제', '투투투', '가족들과 함께 갔는데,,,', '1234', sysdate, 0, '서울, 빛','space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 'sample_map_url');

SELECT reviewno, fcateno, contentsno, MEMBERNO, nickname, title, content, pwd, rdate, cnt, word, file1, file1saved, thumb1, size1, map 
FROM FREVIEW
WHERE contentsno = 1;

commit;
  
  
  
  
  
  
