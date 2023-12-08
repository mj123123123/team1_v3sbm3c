package dev.mvc.fcate;

/*  
 * CREATE TABLE festivalcate(
		festivalcateno    NUMBER(10)    NOT NULL   PRIMARY KEY,
		festivalcatename  VARCHAR2(25)  NOT NULL,
		festivalcatecnt   NUMBER(10)    NOT NULL,
		festivalcaterdate DATE          NOT NULL,
        SEQNO                 NUMBER(5),
        VISIBLE               CHAR(1)
	);
 */

public class FcateVO {

	private int fcateno;
	private String name;
	private int cnt;
	private String rdate;
	private int seqno; 
	private String visible;
	public int getFcateno() {
		return fcateno;
	}
	public void setFcateno(int fcateno) {
		this.fcateno = fcateno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public int getSeqno() {
		return seqno;
	}
	public void setSeqno(int seqno) {
		this.seqno = seqno;
	}
	public String getVisible() {
		return visible;
	}
	public void setVisible(String visible) {
		this.visible = visible;
	}
	@Override
	public String toString() {
		return "FcateVO [fcateno=" + fcateno + ", name=" + name + ", cnt=" + cnt + ", rdate=" + rdate + ", seqno="
				+ seqno + ", visible=" + visible + "]";
	}
	
}