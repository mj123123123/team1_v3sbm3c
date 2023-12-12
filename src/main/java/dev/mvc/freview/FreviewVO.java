package dev.mvc.freview;

import org.springframework.web.multipart.MultipartFile;

public class FreviewVO {
	/*
	 * reviewno NUMBER(10) NOT NULL PRIMARY KEY, fcateno NUMBER(10), contentsno
	 * NUMBER(10), MEMBERNO NUMERIC(10), title VARCHAR2(100) NOT NULL, content CLOB
	 * NOT NULL, pwd VARCHAR2(10), rdate DATE NOT NULL, file1 VARCHAR2(200),
	 * file1saved VARCHAR2(400), thumb1 VARCHAR2(200), size1 NUMBER(10), map
	 * VARCHAR2(2000),
	 */

	/** 리뷰 번호 */
	private int reviewno;
	/** 카테고리 번호 */
	private int fcateno;
	/** 컨텐츠 번호 */
	private int contentsno;
	/** 회원 번호 */
	private int memberno;
	/** 회원 별명 */
	private String nickname = "";
	/** 제목 */
	private String title = "";
	/** 내용 */
	private String content = "";
	/** 패스워드 */
	private String pwd = "";
	/** 날짜 */
	private String rdate = "";
	/** cnt */
	private int cnt = 0;
	/** 키워드 */
	private String word = "";
	/** 지도 */
	private String map;

	// 파일 업로드 관련
	// -----------------------------------------------------------------------------------
	/**
	 * 이미지 파일
	 * <input type='file' class="form-control" name='file1MF' id='file1MF' value=''
	 * placeholder="파일 선택">
	 */
	private MultipartFile file1MF;
	/** 메인 이미지 크기 단위, 파일 크기 */
	private String size1_label = "";
	/** 메인 이미지 */
	private String file1 = "";
	/** 실제 저장된 메인 이미지 */
	private String file1saved = "";
	/** 메인 이미지 preview */
	private String thumb1 = "";
	/** 메인 이미지 크기 */
	private long size1;

	// 페이징 관련
	// -----------------------------------------------------------------------------------
	/** 시작 rownum */
	private int start_num;
	/** 종료 rownum */
	private int end_num;
	/** 현재 페이지 */
	private int now_page = 1;

	public int getReviewno() {
		return reviewno;
	}

	public int setReviewno() {
		return reviewno;
	}

	public int getFcateno() {
		return fcateno;
	}

	public void setFcateno(int fcateno) {
		this.fcateno = fcateno;
	}

	public int getContentsno() {
		return contentsno;
	}

	public void setContentsno(int contentsno) {
		this.contentsno = contentsno;
	}

	public int getMemberno() {
		return memberno;
	}

	public void setMemberno(int memberno) {
		this.memberno = memberno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getMap() {
		return map;
	}

	public void setMap(String map) {
		this.map = map;
	}

	public MultipartFile getFile1MF() {
		return file1MF;
	}

	public void setFile1MF(MultipartFile file1mf) {
		file1MF = file1mf;
	}

	public String getSize1_label() {
		return size1_label;
	}

	public void setSize1_label(String size1_label) {
		this.size1_label = size1_label;
	}

	public String getFile1() {
		return file1;
	}

	public void setFile1(String file1) {
		this.file1 = file1;
	}

	public String getFile1saved() {
		return file1saved;
	}

	public void setFile1saved(String file1saved) {
		this.file1saved = file1saved;
	}

	public String getThumb1() {
		return thumb1;
	}

	public void setThumb1(String thumb1) {
		this.thumb1 = thumb1;
	}

	public long getSize1() {
		return size1;
	}

	public void setSize1(long size1) {
		this.size1 = size1;
	}

	public int getStart_num() {
		return start_num;
	}

	public void setStart_num(int start_num) {
		this.start_num = start_num;
	}

	public int getEnd_num() {
		return end_num;
	}

	public void setEnd_num(int end_num) {
		this.end_num = end_num;
	}

	public int getNow_page() {
		return now_page;
	}

	public void setNow_page(int now_page) {
		this.now_page = now_page;
	}

	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
	}

	public String getRdate() {
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@Override
	public String toString() {
		return "FreviewVO [reviewno=" + reviewno + ", fcateno=" + fcateno + ", contentsno=" + contentsno + ", memberno="
				+ memberno + ", nickname=" + nickname + ", title=" + title + ", content=" + content + ", pwd=" + pwd
				+ ", rdate=" + rdate + ", cnt=" + cnt + ", word=" + word + ", map=" + map + ", file1MF=" + file1MF
				+ ", size1_label=" + size1_label + ", file1=" + file1 + ", file1saved=" + file1saved + ", thumb1="
				+ thumb1 + ", size1=" + size1 + ", start_num=" + start_num + ", end_num=" + end_num + ", now_page="
				+ now_page + "]";
	}

}
