package dev.mvc.answer;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.answer.AnswerProc")
public class AnswerProc implements AnswerProcInter {
  @Autowired
  private AnswerDAOInter answerDAO;
  
  @Override
  public int create(AnswerVO answerVO) {
    int cnt = this.answerDAO.create(answerVO);
    return cnt;
  }
  
  @Override
  public AnswerVO read(int ansno) {
    AnswerVO answerVO = this.answerDAO.read(ansno);
    return answerVO;
  }

  @Override
  public int update_answer(AnswerVO answerVO) {
    int cnt = this.answerDAO.update_answer(answerVO);
    return cnt;
  }
  
  @Override
  public int delete(int ansno) {
    int cnt = this.answerDAO.delete(ansno);
    return cnt;
  }

}
