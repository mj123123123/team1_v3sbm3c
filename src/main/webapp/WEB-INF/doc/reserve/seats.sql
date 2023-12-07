CREATE TABLE Seats (
    seatno INT PRIMARY KEY,
    routesno INT,
    seat_number INT,
    available NUMBER(1),
    FOREIGN KEY (routesno) REFERENCES Routes(routesno)
);

COMMENT ON TABLE Seats IS '좌석 정보';
COMMENT ON COLUMN Seats.seatno IS '좌석 번호';
COMMENT ON COLUMN Seats.routesno IS '경로 번호 (외래 키)';
COMMENT ON COLUMN Seats.seat_number IS '좌석 번호';
COMMENT ON COLUMN Seats.available IS '좌석 가용 여부 (1: 가용, 0: 불가용)';


DROP SEQUENCE Seats_SEQ;

CREATE SEQUENCE Seats_SEQ
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 99999
  CACHE 2
  NOCYCLE;
  
  -- 등록: 1건 이상
INSERT INTO Seats(seatno, routesno, seat_number, available)
VALUES (Seats_seq.nextval, 1, 101, 1);

INSERT INTO Seats(seatno, routesno, seat_number, available)
VALUES (Seats_seq.nextval, 2, 102, 1);

INSERT INTO Seats(seatno, routesno, seat_number, available)
VALUES (Seats_seq.nextval, 3, 103, 1);

-- 전체 목록
SELECT seatno, routesno, seat_number, available
FROM Seats
ORDER BY seatno ASC;

