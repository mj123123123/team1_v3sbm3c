package dev.mvc.notice;

public interface NoticeDAOInter {
  /**
   * 등록
   * @param noticeVO
   * @return 등록한 레코드 개수
   */
  public int create(NoticeVO noticeVO);
}
