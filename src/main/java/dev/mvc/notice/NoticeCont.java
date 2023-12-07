package dev.mvc.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class NoticeCont {
  @Autowired
  @Qualifier("dev.mvc.notice.NoticeProc")
  private NoticeProcInter noticeProc;
  
  
  
  public NoticeCont() {
    System.out.println("-> NoticeCont created.");
  }
  
  // FORM 출력, http://localhost:9093/notice/create.do
  @RequestMapping(value="/notice/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/create");  // WEB-INF/views/notice/create.jsp
    
    return mav;
  }
  
  // http://localhost:9093/notice/create.do
  @RequestMapping(value="/notice/create.do", method = RequestMethod.POST)
  public ModelAndView create(NoticeVO noticeVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.noticeProc.create(noticeVO);
    System.out.println("-> cnt: " + cnt);
    
    if (cnt == 1) {
      mav.setViewName("redirect:/notice/list_all.do");
    } else {
      mav.addObject("cnt", cnt);
      mav.setViewName("notice/msg");
    }
    
    mav.addObject("cnt", cnt);
    
    return mav;
  }
}
