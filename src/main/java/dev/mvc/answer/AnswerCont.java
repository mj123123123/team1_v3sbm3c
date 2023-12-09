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
}
