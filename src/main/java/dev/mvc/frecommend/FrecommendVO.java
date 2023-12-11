package dev.mvc.frecommend;

public class FrecommendVO {
	
	private int frecommendno;
	private int memberno;
	private int fcateno;   
	private int contentsno; 
	private int seq;
	private String rdate;
	
	public int getFrecommendno() {
		return frecommendno;
	}
	public void setFrecommendno(int frecommendno) {
		this.frecommendno = frecommendno;
	}
	public int getMemberno() {
		return memberno;
	}
	public void setMemberno(int memberno) {
		this.memberno = memberno;
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
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	
	@Override
	public String toString() {
		return "FrecommendVO [frecommendno=" + frecommendno + ", memberno=" + memberno + ", fcateno=" + fcateno
				+ ", contentsno=" + contentsno + ", seq=" + seq + ", rdate=" + rdate + "]";
	}
	
	
	
	
}
