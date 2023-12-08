package dev.mvc.frecommend;

public class FrecommendVO {
	
	private int frecommendno;
	private int memberno;
	private int fcate;                            
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
	public int getFcate() {
		return fcate;
	}
	public void setFcate(int fcate) {
		this.fcate = fcate;
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
		return "FrecommendVO [frecommendno=" + frecommendno + ", memberno=" + memberno + ", fcate=" + fcate + ", seq="
				+ seq + ", rdate=" + rdate + "]";
	}
	

}
