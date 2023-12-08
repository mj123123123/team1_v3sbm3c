package dev.mvc.question;

/*
 * CREATE TABLE QUESTION(
    QUESTNO     NUMBER(10)      NOT NULL,
    MEMBERNO    NUMBER(10)      NOT NULL,   -- FK
    TCATENO     NUMBER(10)      NOT NULL,   -- FK
    TITLE       VARCHAR(50)     NOT NULL,
    QUEST       VARCHAR(300)    NOT NULL,
    RDATE       DATE            NOT NULL,
    PRIMARY KEY (QUESTNO)
);
 */

public class QuestionVO {
  private int questno;
  private int memberno;
  private int tcateno;
  private String title = "";
  private String quest = "";
  private String rdate = "";
  
  //페이징 관련
  // -----------------------------------------------------------------------------------
  /** 시작 rownum */
  private int start_num;    
  /** 종료 rownum */
  private int end_num;    
  /** 현재 페이지 */
  private int now_page = 1;
  //-----------------------------------------------------------------------------------
  
  public int getQuestno() {
    return questno;
  }
  public void setQuestno(int questno) {
    this.questno = questno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public int getTcateno() {
    return tcateno;
  }
  public void setTcateno(int tcateno) {
    this.tcateno = tcateno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getQuest() {
    return quest;
  }
  public void setQuest(String quest) {
    this.quest = quest;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
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
  
  @Override
  public String toString() {
    return "QuestionVO [questno=" + questno + ", memberno=" + memberno + ", tcateno=" + tcateno + ", title=" + title
        + ", quest=" + quest + ", rdate=" + rdate + ", start_num=" + start_num + ", end_num=" + end_num + ", now_page="
        + now_page + "]";
  }
}
