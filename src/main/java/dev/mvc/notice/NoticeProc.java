package dev.mvc.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.notice.NoticeProc")
public class NoticeProc implements NoticeProcInter {
  @Autowired
  private NoticeDAOInter noticeDAO;
  
  public int create(NoticeVO noticeVO) {
    int cnt = this.noticeDAO.create(noticeVO);
    return cnt;
  }
}
