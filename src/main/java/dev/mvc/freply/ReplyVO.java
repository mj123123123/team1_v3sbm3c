package dev.mvc.freply;

public class ReplyVO {
	/** 댓글 번호 */
	private int replyno;
	/** 관련 컨텐츠 번호 */
	private int contentsno;
	/** 회원 번호 */
	private int memberno;
	/** 내용 */
	private String content;
	/** 패스워드 */
	private String passwd = "";
	/** 등록일 */
	private String rdate = "";
	/** 공개여부 */
	private String visible;
	
	public int getReplyno() {
		return replyno;
	}
	public void setReplyno(int replyno) {
		this.replyno = replyno;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getVisible() {
		return visible;
	}
	public void setVisible(String visible) {
		this.visible = visible;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [replyno=" + replyno + ", contentsno=" + contentsno + ", memberno=" + memberno + ", content="
				+ content + ", passwd=" + passwd + ", rdate=" + rdate + ", visible=" + visible + "]";
	}

}
