CREATE TABLE GOOD(
		goodno                       NUMBER(10)		 NOT NULL PRIMARY KEY,
		memberno                     NUMBER(10)	     NOT NULL,
		contentsno                   NUMBER(10)	     NOT NULL,
		RDATE                        DATE		     NOT NULL,
        FOREIGN KEY (memberno) REFERENCES member (memberno),
        FOREIGN KEY (contentsno) REFERENCES festival (contentsno)
);

DROP SEQUENCE contents_seq;

CREATE SEQUENCE contents_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지
  
-- 1) 기존에 추천을 했는지 확인하는 쿼리, 1: 좋아요 클릭함, 0: 아직 좋아요 클릭안함.
SELECT COUNT(*) as cnt
FROM good
WHERE memberno = 1 AND contentsno=1;

-- 2) 좋아요 처리
INSERT INTO good(goodno, memberno, contentsno, rdate)
VALUES(good_seq.nextval, 1, 1, sysdata);


SELECT cateno FROM recommend WHERE memberno=1;

SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, adminno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
                     ORDER BY recom DESC
           )          
)
WHERE r >= 1 AND r <= 6;

  