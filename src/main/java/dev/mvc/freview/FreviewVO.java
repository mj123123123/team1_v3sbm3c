package dev.mvc.freview;

public class FreviewVO {
	/*
	 * reviewno NUMBER(10) NOT NULL PRIMARY KEY,
		contentsno NUMBER(10),
		MEMBERNO NUMERIC(10),
		title VARCHAR2(100) NOT NULL,
		content CLOB NOT NULL,
        pwd VARCHAR2(10),
		rdate DATE NOT NULL,
		file1 VARCHAR2(200),
        file1saved VARCHAR2(400),
		thumb1 VARCHAR2(200),
		size1 NUMBER(10),
		map VARCHAR2(2000),
	 */
	
	private int reviewno;
	private int contentsno;
	private int memberno;
	private String title;
	private String content;
	private String pwd;
	private String file1;
	private String file1saved;
	private String thumb1;
	private String size1;
	private String map;
	
	public int getReviewno() {
		return reviewno;
	}
	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
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
	public String getSize1() {
		return size1;
	}
	public void setSize1(String size1) {
		this.size1 = size1;
	}
	public String getMap() {
		return map;
	}
	public void setMap(String map) {
		this.map = map;
	}
	
	@Override
	public String toString() {
		return "FreivewVO [reviewno=" + reviewno + ", contentsno=" + contentsno + ", memberno=" + memberno + ", title="
				+ title + ", content=" + content + ", pwd=" + pwd + ", file1=" + file1 + ", file1saved=" + file1saved
				+ ", thumb1=" + thumb1 + ", size1=" + size1 + ", map=" + map + "]";
	}
	

}
