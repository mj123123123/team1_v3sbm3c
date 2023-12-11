/**********************************/
/* Table Name: 여행 카테고리 */
/**********************************/
CREATE TABLE TCATE(
		TCATENO                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		NAME                          		VARCHAR2(30)		 NOT NULL,
		SEQNO                         		NUMBER(7)		 NOT NULL,
		VISIBLE                       		CHAR(1)		 NOT NULL
);

COMMENT ON TABLE TCATE is '여행 카테고리';
COMMENT ON COLUMN TCATE.TCATENO is '여행 카테고리 번호';
COMMENT ON COLUMN TCATE.NAME is '카테고리 이름';
COMMENT ON COLUMN TCATE.SEQNO is '출력 순서';
COMMENT ON COLUMN TCATE.VISIBLE is '출력 모드';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE MEMBER(
		MEMBERNO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ID                            		VARCHAR2(30)		 NOT NULL,
		PASSWD                        		VARCHAR2(60)		 NOT NULL,
		MNAME                         		VARCHAR2(30)		 NOT NULL,
		TEL                           		VARCHAR2(14)		 NOT NULL,
		ZIPCODE                       		VARCHAR2(5)		 NULL ,
		ADDRESS1                      		VARCHAR2(80)		 NULL ,
		ADDRESS2                      		VARCHAR2(50)		 NULL ,
		MDATE                         		DATE		 NOT NULL,
		GRADE                         		NUMBER(2)		 NOT NULL
);

COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEMBERNO is '회원 번호';
COMMENT ON COLUMN MEMBER.ID is '아이디';
COMMENT ON COLUMN MEMBER.PASSWD is '패스워드';
COMMENT ON COLUMN MEMBER.MNAME is '성명';
COMMENT ON COLUMN MEMBER.TEL is '전화번호';
COMMENT ON COLUMN MEMBER.ZIPCODE is '우편번호';
COMMENT ON COLUMN MEMBER.ADDRESS1 is '주소1';
COMMENT ON COLUMN MEMBER.ADDRESS2 is '주소2';
COMMENT ON COLUMN MEMBER.MDATE is '가입일';
COMMENT ON COLUMN MEMBER.GRADE is '등급';


/**********************************/
/* Table Name: 질문 */
/**********************************/
CREATE TABLE QUESTION(
		QNANO                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEMBERNO                      		NUMBER(10)		 NOT NULL,
		TCATENO                       		NUMBER(10)		 NOT NULL,
		TITLE                         		VARCHAR2(50)		 NOT NULL,
		QUEST                         		VARCHAR2(300)		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
  FOREIGN KEY (TCATENO) REFERENCES TCATE (TCATENO),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE QUESTION is '질문';
COMMENT ON COLUMN QUESTION.QNANO is '질문번호';
COMMENT ON COLUMN QUESTION.MEMBERNO is '회원번호';
COMMENT ON COLUMN QUESTION.TCATENO is '여행 카테고리 번호';
COMMENT ON COLUMN QUESTION.TITLE is '제목';
COMMENT ON COLUMN QUESTION.QUEST is '질문내용';
COMMENT ON COLUMN QUESTION.RDATE is '질문날짜';


/**********************************/
/* Table Name: 챗봇 */
/**********************************/
CREATE TABLE CHATBOT(
		CHATBOTNO                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEMBERNO                      		NUMBER(10)		 NOT NULL,
		CHAT                          		VARCHAR2(500)		 NULL ,
		RDATE                         		TIMESTAMP(10)		 NULL ,
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE CHATBOT is '챗봇';
COMMENT ON COLUMN CHATBOT.CHATBOTNO is '챗봇번호';
COMMENT ON COLUMN CHATBOT.MEMBERNO is '회원번호';
COMMENT ON COLUMN CHATBOT.CHAT is '채팅내용';
COMMENT ON COLUMN CHATBOT.RDATE is '채팅날짜';


/**********************************/
/* Table Name: 이효진 */
/**********************************/
CREATE TABLE 이효진(

);

COMMENT ON TABLE 이효진 is '이효진';


/**********************************/
/* Table Name: 관리자 */
/**********************************/
CREATE TABLE ADMIN(
		ADMINNO                       		NUMBER(5)		 NOT NULL		 PRIMARY KEY,
		ID                            		VARCHAR2(20)		 NOT NULL,
		PASSWD                        		VARCHAR2(15)		 NOT NULL,
		MNAME                         		VARCHAR2(20)		 NOT NULL,
		MDATE                         		DATE		 NOT NULL,
		GRADE                         		NUMBER(2)		 NOT NULL
);

COMMENT ON TABLE ADMIN is '관리자';
COMMENT ON COLUMN ADMIN.ADMINNO is '관리자 번호';
COMMENT ON COLUMN ADMIN.ID is '아이디';
COMMENT ON COLUMN ADMIN.PASSWD is '패스워드';
COMMENT ON COLUMN ADMIN.MNAME is '성명';
COMMENT ON COLUMN ADMIN.MDATE is '가입일';
COMMENT ON COLUMN ADMIN.GRADE is '등급';


/**********************************/
/* Table Name: 답변 */
/**********************************/
CREATE TABLE ANSWER(
		ANSNO                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		QNANO                         		NUMBER(10)		 NOT NULL,
		ANS                           		VARCHAR2(300)		 NULL ,
		ADMINNO                       		NUMBER(5)		 NULL ,
		RDATE                         		DATE		 NOT NULL,
  FOREIGN KEY (QNANO) REFERENCES QUESTION (QNANO),
  FOREIGN KEY (ADMINNO) REFERENCES ADMIN (ADMINNO)
);

COMMENT ON TABLE ANSWER is '답변';
COMMENT ON COLUMN ANSWER.ANSNO is '답변번호';
COMMENT ON COLUMN ANSWER.QNANO is '질문번호';
COMMENT ON COLUMN ANSWER.ANS is '답변내용';
COMMENT ON COLUMN ANSWER.ADMINNO is '관리자 번호';
COMMENT ON COLUMN ANSWER.RDATE is '답변날짜';


/**********************************/
/* Table Name: 여행 추천 시스템 */
/**********************************/
CREATE TABLE TRECOM(
		TRECOMNO                      		NUMBER(8)		 NOT NULL		 PRIMARY KEY,
		TCATENO                       		NUMBER(10)		 NULL ,
		MEMBERNO                      		NUMBER(10)		 NULL ,
		SEQ                           		NUMBER(2)		 DEFAULT 1		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
  FOREIGN KEY (TCATENO) REFERENCES TCATE (TCATENO),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE TRECOM is '여행 추천 시스템';
COMMENT ON COLUMN TRECOM.TRECOMNO is '추천 번호';
COMMENT ON COLUMN TRECOM.TCATENO is '여행 카테고리 번호';
COMMENT ON COLUMN TRECOM.MEMBERNO is '회원 번호';
COMMENT ON COLUMN TRECOM.SEQ is '추천 우선순위';
COMMENT ON COLUMN TRECOM.RDATE is '추천 날짜';


/**********************************/
/* Table Name: 여행지 */
/**********************************/
CREATE TABLE TRAVEL(
		TRAVELNO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		TCATENO                       		NUMBER(10)		 NOT NULL,
		REGION                        		VARCHAR2(30)		 NOT NULL,
		CONTENT                       		CLOB(4000)		 NOT NULL,
		REPLY                         		VARCHAR2(100)		 NOT NULL,
		RECOM                         		NUMBER(7)		 NOT NULL,
		MAP                           		VARCHAR2(1000)		 NULL ,
		YOUTUBE                       		VARCHAR2(500)		 NULL ,
		FILE1                         		VARCHAR2(50)		 NULL ,
		FILE1_SAVED                   		VARCHAR2(50)		 NULL ,
		THUMB1                        		VARCHAR2(50)		 NULL ,
  FOREIGN KEY (TCATENO) REFERENCES TCATE (TCATENO)
);

COMMENT ON TABLE TRAVEL is '여행지';
COMMENT ON COLUMN TRAVEL.TRAVELNO is '여행지 번호';
COMMENT ON COLUMN TRAVEL.TCATENO is '여행 카테고리 번호';
COMMENT ON COLUMN TRAVEL.REGION is '여행지 이름';
COMMENT ON COLUMN TRAVEL.CONTENT is '여행지 내용';
COMMENT ON COLUMN TRAVEL.REPLY is '한줄평/댓글';
COMMENT ON COLUMN TRAVEL.RECOM is '좋아요/추천수';
COMMENT ON COLUMN TRAVEL.MAP is '지도';
COMMENT ON COLUMN TRAVEL.YOUTUBE is '유튜브 영상';
COMMENT ON COLUMN TRAVEL.FILE1 is '메인이미지';
COMMENT ON COLUMN TRAVEL.FILE1_SAVED is '실제 저장된 메인이미지';
COMMENT ON COLUMN TRAVEL.THUMB1 is '메인이미지 thumb';


/**********************************/
/* Table Name: 여행지 리뷰 */
/**********************************/
CREATE TABLE TRAVEL_REVIEW(
		REVIEWNO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		TRAVELNO                      		NUMBER(10)		 NOT NULL,
		TITLE                         		VARCHAR2(50)		 NOT NULL,
		CONTENT                       		CLOB(4000)		 NOT NULL,
		RECOM                         		NUMBER(7)		 NOT NULL,
		CNT                           		NUMBER(7)		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
		FILE1                         		VARCHAR2(50)		 NULL ,
		FILE1_SAVED                   		VARCHAR2(50)		 NULL ,
		THUMB1                        		VARCHAR2(50)		 NULL ,
		MEMBERNO                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (TRAVELNO) REFERENCES TRAVEL (TRAVELNO),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE TRAVEL_REVIEW is '여행지 리뷰';
COMMENT ON COLUMN TRAVEL_REVIEW.REVIEWNO is '여행지 리뷰 번호';
COMMENT ON COLUMN TRAVEL_REVIEW.TRAVELNO is '여행지 번호';
COMMENT ON COLUMN TRAVEL_REVIEW.TITLE is '제목';
COMMENT ON COLUMN TRAVEL_REVIEW.CONTENT is '내용';
COMMENT ON COLUMN TRAVEL_REVIEW.RECOM is '추천수';
COMMENT ON COLUMN TRAVEL_REVIEW.CNT is '조회수';
COMMENT ON COLUMN TRAVEL_REVIEW.RDATE is '등록일';
COMMENT ON COLUMN TRAVEL_REVIEW.FILE1 is '메인이미지';
COMMENT ON COLUMN TRAVEL_REVIEW.FILE1_SAVED is '실제 저장된 메인이미지';
COMMENT ON COLUMN TRAVEL_REVIEW.THUMB1 is '메인이미지 thumb';
COMMENT ON COLUMN TRAVEL_REVIEW.MEMBERNO is '회원번호';


/**********************************/
/* Table Name: 가영준 */
/**********************************/
CREATE TABLE 가영준(

);

COMMENT ON TABLE 가영준 is '가영준';


/**********************************/
/* Table Name: 변현수 */
/**********************************/
CREATE TABLE 변현수(

);

COMMENT ON TABLE 변현수 is '변현수';


/**********************************/
/* Table Name: 공지사항 */
/**********************************/
CREATE TABLE NOTICE(
		NOTICENO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		TITLE                         		VARCHAR2(50)		 NOT NULL,
		CONTENT                       		VARCHAR2(4000)		 NOT NULL,
		DATE                          		DATE		 NOT NULL,
		CNT                           		NUMBER(100)		 NULL ,
		ADMINNO                       		NUMBER(5)		 NULL ,
  FOREIGN KEY (ADMINNO) REFERENCES ADMIN (ADMINNO)
);

COMMENT ON TABLE NOTICE is '공지사항';
COMMENT ON COLUMN NOTICE.NOTICENO is '공지사항번호';
COMMENT ON COLUMN NOTICE.TITLE is '공지사항제목';
COMMENT ON COLUMN NOTICE.CONTENT is '공지사항내용';
COMMENT ON COLUMN NOTICE.DATE is '공지사항 등록일';
COMMENT ON COLUMN NOTICE.CNT is '공지사항 조회수';
COMMENT ON COLUMN NOTICE.ADMINNO is '관리자 번호';


/**********************************/
/* Table Name: 여행코스 */
/**********************************/
CREATE TABLE COURSE(
		COURSENO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		TCATENO                       		NUMBER(10)		 NOT NULL,
		NAME                          		VARCHAR2(20)		 NOT NULL,
		CONTENT                       		VARCHAR2(4000)		 NOT NULL,
		ROUTE                         		VARCHAR2(200)		 NOT NULL,
		IMG                           		VARCHAR2(50)		 NOT NULL,
		IMGSAVE                       		VARCHAR2(50)		 NOT NULL,
		REVIEW                        		VARCHAR2(100)		 NOT NULL,
		SEARCH                        		VARCHAR2(20)		 NULL ,
		MAP                           		VARCHAR2(1000)		 NOT NULL,
		YOUTUBE                       		VARCHAR2(1000)		 NOT NULL,
		LIKE                          		INTEGER(10)		 NULL ,
  FOREIGN KEY (TCATENO) REFERENCES TCATE (TCATENO)
);

COMMENT ON TABLE COURSE is '여행코스';
COMMENT ON COLUMN COURSE.COURSENO is '코스 번호';
COMMENT ON COLUMN COURSE.TCATENO is '여행 카테고리 번호';
COMMENT ON COLUMN COURSE.NAME is '코스명';
COMMENT ON COLUMN COURSE.CONTENT is '코스설명';
COMMENT ON COLUMN COURSE.ROUTE is '코스 경로';
COMMENT ON COLUMN COURSE.IMG is '코스이미지';
COMMENT ON COLUMN COURSE.IMGSAVE is '코스 저장된 이미지';
COMMENT ON COLUMN COURSE.REVIEW is '코스 평가';
COMMENT ON COLUMN COURSE.SEARCH is '코스 검색어';
COMMENT ON COLUMN COURSE.MAP is '지도';
COMMENT ON COLUMN COURSE.YOUTUBE is '유튜브';
COMMENT ON COLUMN COURSE.LIKE is '좋아요 수';


/**********************************/
/* Table Name: 여행코스 리뷰 */
/**********************************/
CREATE TABLE COURSEREVIEW(
		COURSEREVIEWNO                		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		COURSENO                      		NUMBER(10)		 NOT NULL,
		TITLE                         		VARCHAR2(50)		 NOT NULL,
		CONTENT                       		VARCHAR2(1000)		 NOT NULL,
		LIKE                          		INTEGER(10)		 NULL ,
		IMG                           		VARCHAR2(50)		 NOT NULL,
		IMGSAVE                       		VARCHAR2(50)		 NULL ,
		MEMBERNO                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (COURSENO) REFERENCES COURSE (COURSENO),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE COURSEREVIEW is '여행코스 리뷰';
COMMENT ON COLUMN COURSEREVIEW.COURSEREVIEWNO is '코스 리뷰 번호';
COMMENT ON COLUMN COURSEREVIEW.COURSENO is '코스 번호';
COMMENT ON COLUMN COURSEREVIEW.TITLE is '코스 리뷰 제목';
COMMENT ON COLUMN COURSEREVIEW.CONTENT is '코스 리뷰 내용';
COMMENT ON COLUMN COURSEREVIEW.LIKE is '코스 리뷰 좋아요 수';
COMMENT ON COLUMN COURSEREVIEW.IMG is '코스 리뷰 이미지';
COMMENT ON COLUMN COURSEREVIEW.IMGSAVE is '코스 리뷰 저장된 이미지';
COMMENT ON COLUMN COURSEREVIEW.MEMBERNO is '회원번호';


/**********************************/
/* Table Name: 김민지 */
/**********************************/
CREATE TABLE 김민지(

);

COMMENT ON TABLE 김민지 is '김민지';


/**********************************/
/* Table Name: 여행경로 */
/**********************************/
CREATE TABLE TRAVELROUTE(
		TRAVELROUTENO                 		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		NAME                          		VARCHAR2(20)		 NOT NULL,
		START                         		VARCHAR2(100)		 NOT NULL,
		STOPOVER                      		VARCHAR2(100)		 NULL ,
		ARRIVE                        		VARCHAR2(100)		 NOT NULL,
		DATE                          		DATE		 NOT NULL,
		COURSEROUTE                   		VARCHAR2(200)		 NOT NULL,
		COURSENO                      		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (COURSENO) REFERENCES COURSE (COURSENO)
);

COMMENT ON TABLE TRAVELROUTE is '여행경로';
COMMENT ON COLUMN TRAVELROUTE.TRAVELROUTENO is '경로번호';
COMMENT ON COLUMN TRAVELROUTE.NAME is '경로명';
COMMENT ON COLUMN TRAVELROUTE.START is '출발지';
COMMENT ON COLUMN TRAVELROUTE.STOPOVER is '경유지';
COMMENT ON COLUMN TRAVELROUTE.ARRIVE is '도착지';
COMMENT ON COLUMN TRAVELROUTE.DATE is '경로 추가일';
COMMENT ON COLUMN TRAVELROUTE.COURSEROUTE is '코스 경로';
COMMENT ON COLUMN TRAVELROUTE.COURSENO is '코스 번호';


/**********************************/
/* Table Name: 좌석 */
/**********************************/
CREATE TABLE SEAT(
		SEATNO                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		POSSIVLE                      		NUMBER(10)		 NOT NULL,
		SEATCOST                      		INTEGER(10)		 NOT NULL,
		ROUTENO                       		INTEGER(10)		 NOT NULL
);

COMMENT ON TABLE SEAT is '좌석';
COMMENT ON COLUMN SEAT.SEATNO is '좌석번호';
COMMENT ON COLUMN SEAT.POSSIVLE is '가능여부';
COMMENT ON COLUMN SEAT.SEATCOST is '좌석 금액';
COMMENT ON COLUMN SEAT.ROUTENO is '노선번호';


/**********************************/
/* Table Name: 서규원 */
/**********************************/
CREATE TABLE 서규원(

);

COMMENT ON TABLE 서규원 is '서규원';


/**********************************/
/* Table Name: 노선 */
/**********************************/
CREATE TABLE ROUTE(
		ROUTENO                       		INTEGER(10)		 NOT NULL		 PRIMARY KEY,
		ROUTENAME                     		VARCHAR2(10)		 NULL ,
		ROUTESTART                    		VARCHAR2(10)		 NULL ,
		ROUTEARRIVE                   		VARCHAR2(10)		 NULL ,
		STARTTIME                     		TIMESTAMP(10)		 NULL ,
		ARRIVETIME                    		TIMESTAMP(10)		 NULL 
);

COMMENT ON TABLE ROUTE is '노선';
COMMENT ON COLUMN ROUTE.ROUTENO is '노선번호';
COMMENT ON COLUMN ROUTE.ROUTENAME is '노선이름';
COMMENT ON COLUMN ROUTE.ROUTESTART is '출발지';
COMMENT ON COLUMN ROUTE.ROUTEARRIVE is '도착지';
COMMENT ON COLUMN ROUTE.STARTTIME is '출발시간';
COMMENT ON COLUMN ROUTE.ARRIVETIME is '도착시간';


/**********************************/
/* Table Name: 예매 */
/**********************************/
CREATE TABLE RESERVE(
		RESERVENO                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ROUTENO                       		INTEGER(10)		 NOT NULL,
		SEATNO                        		INTEGER(10)		 NOT NULL,
		CUSTOMERNO                    		INTEGER(10)		 NOT NULL,
		RESERVETIME                   		TIMESTAMP(10)		 NOT NULL,
		MEMBERNO                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (SEATNO) REFERENCES SEAT (SEATNO),
  FOREIGN KEY (ROUTENO) REFERENCES ROUTE (ROUTENO),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE RESERVE is '예매';
COMMENT ON COLUMN RESERVE.RESERVENO is '예매번호';
COMMENT ON COLUMN RESERVE.ROUTENO is '노선번호';
COMMENT ON COLUMN RESERVE.SEATNO is '좌석번호';
COMMENT ON COLUMN RESERVE.CUSTOMERNO is '고객번호';
COMMENT ON COLUMN RESERVE.RESERVETIME is '얘매시간';
COMMENT ON COLUMN RESERVE.MEMBERNO is '회원번호';


/**********************************/
/* Table Name: 전유빈 */
/**********************************/
CREATE TABLE 전유빈(

);

COMMENT ON TABLE 전유빈 is '전유빈';


/**********************************/
/* Table Name: 축제 카테고리 */
/**********************************/
CREATE TABLE FCATE(
		fcateno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(70)		 NOT NULL,
		cnt                           		NUMBER(10)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		seqno                         		NUMBER(10)		 NOT NULL,
		visible                       		CHAR(1)		 NOT NULL
);

COMMENT ON TABLE FCATE is '축제 카테고리';
COMMENT ON COLUMN FCATE.fcateno is '카테고리 번호';
COMMENT ON COLUMN FCATE.name is '카테고리 이름';
COMMENT ON COLUMN FCATE.cnt is '관련 자료수';
COMMENT ON COLUMN FCATE.rdate is '등록일';
COMMENT ON COLUMN FCATE.seqno is '출력 순서';
COMMENT ON COLUMN FCATE.visible is '출력 모드';


/**********************************/
/* Table Name: 축제/행사 컨텐츠 */
/**********************************/
CREATE TABLE FESTIVAL(
		contentsno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		fcateno                       		NUMBER(10)		 NOT NULL,
		ADMINNO                       		NUMBER(5)		 NOT NULL,
		title                         		VARCHAR2(100)		 NOT NULL,
		content                       		VARCHAR2(50000)		 NOT NULL,
		recom                         		NUMBER(10)		 NOT NULL,
		cnt                           		NUMBER(10)		 NOT NULL,
		replycnt                      		NUMBER(10)		 NOT NULL,
		passwd                        		VARCHAR2(10)		 NOT NULL,
		word                          		VARCHAR2(100)		 NULL ,
		rdate                         		DATE		 NOT NULL,
		file1                         		VARCHAR2(50)		 NULL ,
		file1saved                    		VARCHAR2(50)		 NULL ,
		thumb1                        		VARCHAR2(50)		 NULL ,
		size1                         		NUMBER(10)		 NULL ,
		map                           		VARCHAR2(1000)		 NULL ,
		youtube                       		VARCHAR2(1000)		 NULL ,
  FOREIGN KEY (fcateno) REFERENCES FCATE (fcateno),
  FOREIGN KEY (ADMINNO) REFERENCES ADMIN (ADMINNO)
);

COMMENT ON TABLE FESTIVAL is '축제/행사 컨텐츠';
COMMENT ON COLUMN FESTIVAL.contentsno is '컨텐츠번호';
COMMENT ON COLUMN FESTIVAL.fcateno is '카테고리 번호';
COMMENT ON COLUMN FESTIVAL.ADMINNO is '관리자 번호';
COMMENT ON COLUMN FESTIVAL.title is '제목';
COMMENT ON COLUMN FESTIVAL.content is '내용';
COMMENT ON COLUMN FESTIVAL.recom is '추천수';
COMMENT ON COLUMN FESTIVAL.cnt is '조회수';
COMMENT ON COLUMN FESTIVAL.replycnt is '댓글수';
COMMENT ON COLUMN FESTIVAL.passwd is '패스워드';
COMMENT ON COLUMN FESTIVAL.word is '검색어';
COMMENT ON COLUMN FESTIVAL.rdate is '등록일';
COMMENT ON COLUMN FESTIVAL.file1 is '메인 이미지';
COMMENT ON COLUMN FESTIVAL.file1saved is '실제 저장된 파일명';
COMMENT ON COLUMN FESTIVAL.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN FESTIVAL.size1 is '메인 이미지 크기';
COMMENT ON COLUMN FESTIVAL.map is '지도';
COMMENT ON COLUMN FESTIVAL.youtube is 'Youtube 영상';


/**********************************/
/* Table Name: 축제/행사 추천 */
/**********************************/
CREATE TABLE FRECOMMEND(
		frecommendno                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
		fcateno                       		NUMBER(10)		 NULL ,
		MEMBERNO                      		NUMBER(10)		 NULL ,
		SEQ                           		INTEGER(10)		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
  FOREIGN KEY (contentsno) REFERENCES FESTIVAL (contentsno),
  FOREIGN KEY (fcateno) REFERENCES FCATE (fcateno),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE FRECOMMEND is '축제/행사 추천';
COMMENT ON COLUMN FRECOMMEND.frecommendno is '추천번호';
COMMENT ON COLUMN FRECOMMEND.contentsno is '컨텐츠번호';
COMMENT ON COLUMN FRECOMMEND.fcateno is '카테고리 번호';
COMMENT ON COLUMN FRECOMMEND.MEMBERNO is '회원 번호';
COMMENT ON COLUMN FRECOMMEND.SEQ is '추천 우선순위';
COMMENT ON COLUMN FRECOMMEND.RDATE is '추천 날짜';


/**********************************/
/* Table Name: 축제/행사 리뷰 */
/**********************************/
CREATE TABLE FREVIEW(
		reviewno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		contentsno                    		NUMBER(10)		 NULL ,
		MEMBERNO                      		NUMBER(10)		 NULL ,
		title                         		VARCHAR2(100)		 NOT NULL,
		content                       		VARCHAR2		 NOT NULL,
		cnt                           		NUMBER(10)		 NOT NULL,
		pwd                           		VARCHAR2(10)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		file1                         		VARCHAR2(200)		 NULL ,
		file1saved                    		VARCHAR2(400)		 NULL ,
		thumb1                        		VARCHAR2(200)		 NULL ,
		size1                         		NUMBER(10)		 NULL ,
		map                           		VARCHAR2(1000)		 NULL ,
  FOREIGN KEY (contentsno) REFERENCES FESTIVAL (contentsno),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE FREVIEW is '축제/행사 리뷰';
COMMENT ON COLUMN FREVIEW.reviewno is '리뷰번호';
COMMENT ON COLUMN FREVIEW.contentsno is '컨텐츠번호';
COMMENT ON COLUMN FREVIEW.MEMBERNO is '회원 번호';
COMMENT ON COLUMN FREVIEW.title is '제목';
COMMENT ON COLUMN FREVIEW.content is '내용';
COMMENT ON COLUMN FREVIEW.cnt is '조회수';
COMMENT ON COLUMN FREVIEW.pwd is '패스워드';
COMMENT ON COLUMN FREVIEW.rdate is '등록일';
COMMENT ON COLUMN FREVIEW.file1 is '메인 이미지';
COMMENT ON COLUMN FREVIEW.file1saved is '실제 저장된 파일명';
COMMENT ON COLUMN FREVIEW.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN FREVIEW.size1 is '메인 이미지 크기';
COMMENT ON COLUMN FREVIEW.map is '지도';


/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE REPLY(
		replyno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEMBERNO                      		NUMBER(10)		 NULL ,
		reviewno                      		NUMBER(10)		 NULL ,
		content                       		VARCHAR2(50000)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO),
  FOREIGN KEY (reviewno) REFERENCES FREVIEW (reviewno)
);

COMMENT ON TABLE REPLY is '댓글';
COMMENT ON COLUMN REPLY.replyno is '댓글번호';
COMMENT ON COLUMN REPLY.MEMBERNO is '회원 번호';
COMMENT ON COLUMN REPLY.reviewno is '리뷰번호';
COMMENT ON COLUMN REPLY.content is '내용';
COMMENT ON COLUMN REPLY.rdate is '등록일';


