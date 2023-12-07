package dev.mvc.notice;

public class NoticeVO {
/*
    NOTICENO                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    TITLE                             VARCHAR2(50)     NOT NULL,
    CONTENT                           VARCHAR2(4000)     NOT NULL,
    RDATE                             DATE     NOT NULL,
    CNT                               NUMBER(10)     NULL ,
    ADMINNO                           NUMBER(5)    NULL ,
    FOREIGN KEY (ADMINNO) REFERENCES ADMIN (ADMINNO)
 */
  
  private int noticeno;
  private String title = "";
  private String content = "";
  private String rdate = "";
  private int cnt;
  private int adminno;
  
  public int getNoticeno() {
    return noticeno;
  }
  public void setNoticeno(int noticeno) {
    this.noticeno = noticeno;
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
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  public int getAdminno() {
    return adminno;
  }
  public void setAdminno(int adminno) {
    this.adminno = adminno;
  }
  
  @Override
  public String toString() {
    return "NoticeVO [noticeno=" + noticeno + ", title=" + title + ", content=" + content + ", rdate=" + rdate
        + ", cnt=" + cnt + ", adminno=" + adminno + "]";
  }
}
