package dev.mvc.answer;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.question.QuestionProc;
import dev.mvc.question.QuestionProcInter;
import dev.mvc.question.QuestionVO;
//import dev.mvc.tcate.TcateVO;
import dev.mvc.tool.Tool;

@Controller
public class AnswerCont {
  @Autowired
  @Qualifier("dev.mvc.answer.AnswerProc")
  private AnswerProcInter answerProc;
  
  @Autowired
  @Qualifier("dev.mvc.question.QuestionProc")
  private QuestionProcInter questionProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;
  
  public AnswerCont () {
    System.out.println("-> AnswerCont created.");
  }
  
  /**
   * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
   * POST → url → GET → 데이터 전송
   * @return
   */
  @RequestMapping(value="/answer/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  
  //http://localhost:9093/answer/create.do?questno=1
  @RequestMapping(value="/answer/create.do", method = RequestMethod.GET)
  public ModelAndView create(int questno) {
    ModelAndView mav = new ModelAndView();

    AnswerVO answerVO = this.answerProc.read(questno);
    mav.addObject("answerVO", answerVO);
   
    mav.setViewName("/answer/create"); // /webapp/WEB-INF/views/answer/create.jsp
    
    return mav;
  }
 
   /**
    * 등록 처리 http://localhost:9093/answer/create.do
    * 
    * @return
    */
   @RequestMapping(value="/answer/create.do", method = RequestMethod.POST)
   public ModelAndView create(HttpServletRequest request, HttpSession session, AnswerVO answerVO) {
     ModelAndView mav = new ModelAndView();
   
     if(adminProc.isAdmin(session)) { //관리자 로그인 - 관리자 제작 시 테스트
       // Call By Reference: 메모리 공유, Hashcode 전달
       int adminno = (int)session.getAttribute("adminno"); // adminno FK
       answerVO.setAdminno(adminno);
       int cnt = this.answerProc.create(answerVO); 
       
       if(cnt == 1) {
         mav.addObject("code", "create_success");
       } else {
         mav.addObject("code", "create_fail");
       }
       mav.addObject("cnt", cnt);
       mav.addObject("ansno", answerVO.getAnsno());
       
       mav.addObject("url", "/answer/msg.do");
       mav.setViewName("redirect:/answer/msg.do"); 
     
     
     } else {
       mav.addObject("url", "/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp
       mav.setViewName("redirect:/answer/msg.do"); 
     }
        
     return mav;
   }
 
   
   /**
    * 수정 폼
    * http://localhost:9093/answer/update_answer.do?ansno=1
    * 
    * @return
    */
   @RequestMapping(value = "/answer/update_answer.do", method = RequestMethod.GET)
   public ModelAndView update_answer(HttpSession session, int ansno) {
     ModelAndView mav = new ModelAndView();
     
     if (adminProc.isAdmin(session)) { // 멤버로 로그인한경우
       AnswerVO answerVO = this.answerProc.read(ansno);
       mav.addObject("answerVO", answerVO);
       
       mav.setViewName("/answer/update_answer"); // /WEB-INF/views/answer/update_quest.jsp
  
     } else {
       mav.addObject("url", "/admin/login_need"); // /WEB-INF/views/member/login_need.jsp
       mav.setViewName("redirect:/answer/msg.do"); 
     }
  
     return mav; // forward
   }
   
   /**
    * 수정 처리
    * http://localhost:9093/answer/update_answer.do?ansno=1
    * 
    * @return
    */
   @RequestMapping(value = "/answer/update_answer.do", method = RequestMethod.POST)
   public ModelAndView update_answer(HttpSession session, AnswerVO answerVO) {
     ModelAndView mav = new ModelAndView();
     
     if (this.adminProc.isAdmin(session)) { // 회원 로그인 확인
       HashMap<String, Object> hashMap = new HashMap<String, Object>();
       hashMap.put("ansno", answerVO.getAnsno());
       
       this.answerProc.update_answer(answerVO); // 글수정  
       
       // mav 객체 이용
       mav.addObject("ansno", answerVO.getAnsno());
       //mav.setViewName("redirect:/question/read.do"); // 페이지 자동 이동
     } else { // 정상적인 로그인이 아닌 경우 로그인 유도
       mav.addObject("url", "/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp
       mav.setViewName("redirect:/answer/msg.do"); 
     }
     
     //mav.addObject("now_page", answerVO.getNow_page()); // POST -> GET: 데이터 분실이 발생함으로 다시하번 데이터 저장 ★     
     
     return mav; // forward
   }
   
   /**
    * 삭제 폼
    * http://localhost:9093/answer/delete.do?ansno=1
    * 
    * @return
    */
   @RequestMapping(value = "/answer/delete.do", method = RequestMethod.GET)
   public ModelAndView delete(HttpSession session, int ansno) {
     ModelAndView mav = new ModelAndView();
     
     if (adminProc.isAdmin(session)) { // 회원 로그인 경우
       AnswerVO answerVO = this.answerProc.read(ansno);
       mav.addObject("answerVO", answerVO);
       
       mav.setViewName("/answer/delete"); // /WEB-INF/views/answer/delete.jsp
       
     } else {
       mav.addObject("url", "/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp
       mav.setViewName("redirect:/answer/msg.do"); 
     }
  
  
     return mav; // forward
   }
   
   /**
    * 삭제 처리 http://localhost:9093/answer/delete.do
    * 
    * @return
    */
   @RequestMapping(value = "/answer/delete.do", method = RequestMethod.POST)
   public ModelAndView delete(AnswerVO answerVO) {
     ModelAndView mav = new ModelAndView();
     
     // -------------------------------------------------------------------
     // 파일 삭제 시작
     // -------------------------------------------------------------------
     // 삭제할 파일 정보를 읽어옴.
     AnswerVO answerVO_read = answerProc.read(answerVO.getAnsno());
     
     this.answerProc.delete(answerVO.getAnsno()); // DBMS 삭제
     
     HashMap<String, Object> hashMap = new HashMap<String, Object>();
     hashMap.put("ansno", answerVO.getAnsno());
  
     mav.addObject("ansno", answerVO.getAnsno());
     mav.setViewName("redirect:../question/list_all.do");  //답변 삭제 후 해당 질문 글로 이동
     
     return mav;
   }
}
