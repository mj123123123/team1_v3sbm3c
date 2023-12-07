CREATE TABLE Routes (
    routesno INT PRIMARY KEY,
    routesname VARCHAR2(255),
    start_location VARCHAR2(100),
    end_location VARCHAR2(100),
    departure_time TIMESTAMP,
    arrival_time TIMESTAMP
);

COMMENT ON TABLE Routes IS '경로 정보';
COMMENT ON COLUMN Routes.routesno IS '경로 번호';
COMMENT ON COLUMN Routes.routesname IS '경로명';
COMMENT ON COLUMN Routes.start_location IS '출발 위치';
COMMENT ON COLUMN Routes.end_location IS '도착 위치';
COMMENT ON COLUMN Routes.departure_time IS '출발 시간';
COMMENT ON COLUMN Routes.arrival_time IS '도착 시간';

DROP SEQUENCE Routes_SEQ;

CREATE SEQUENCE Routes_SEQ
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 99999
  CACHE 2
  NOCYCLE;

-- 등록: 1건 이상
INSERT INTO Routes(routesno, routesname, start_location, end_location, departure_time, arrival_time)
VALUES (Routes_SEQ.nextval, '경로1', '서울', '대전', TO_TIMESTAMP('2023-12-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Routes(routesno, routesname, start_location, end_location, departure_time, arrival_time)
VALUES (Routes_SEQ.nextval, '경로2', '인천', '부산', TO_TIMESTAMP('2023-12-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-02 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO Routes(routesno, routesname, start_location, end_location, departure_time, arrival_time)
VALUES (Routes_SEQ.nextval, '경로3', '김포', '제주도', TO_TIMESTAMP('2023-12-03 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-03 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
