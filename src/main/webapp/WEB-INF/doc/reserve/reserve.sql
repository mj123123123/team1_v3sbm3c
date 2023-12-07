CREATE TABLE Reserve (
    Reserveno INT PRIMARY KEY,
    routesno INT,
    seatno INT,
    customerno INT,
    reserve_time TIMESTAMP,
    FOREIGN KEY (routesno) REFERENCES Routes(routesno),
    FOREIGN KEY (seatno) REFERENCES Seats(seatno),
    FOREIGN KEY (customerno) REFERENCES Customer(customerno)
);

COMMENT ON TABLE Reserve IS '예약 정보';
COMMENT ON COLUMN Reserve.Reserveno IS '예약 번호';
COMMENT ON COLUMN Reserve.routesno IS '경로 번호 (외래 키)';
COMMENT ON COLUMN Reserve.seatno IS '좌석 번호 (외래 키)';
COMMENT ON COLUMN Reserve.customerno IS '고객 번호 (외래 키)';
COMMENT ON COLUMN Reserve.reserve_time IS '예약 시간';

DROP SEQUENCE Reserve_SEQ;
CREATE SEQUENCE Reserve_SEQ
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 99999
  CACHE 2
  NOCYCLE;