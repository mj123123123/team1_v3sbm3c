package dev.mvc.question;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;


@Controller
public class QuestionCont {
  @Autowired
  @Qualifier("dev.mvc.question.QuestionProc")
  private QuestionProcInter questionProc;

  
  public QuestionCont () {
    System.out.println("-> QuestionCont created.");
  }
}
