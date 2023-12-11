package dev.mvc.question;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.question.QuestionProc")
public class QuestionProc implements QuestionProcInter {
  @Autowired
  private QuestionDAOInter questionDAO;

  @Override
  public int create(QuestionVO questionVO) {
    int cnt = this.questionDAO.create(questionVO);
    return cnt;
  }

  @Override
  public ArrayList<QuestionVO> list_all() {
    ArrayList<QuestionVO> list = this.questionDAO.list_all();
    return list;
  }

  @Override
  public ArrayList<QuestionVO> list_by_tcateno(int tcateno) {
    ArrayList<QuestionVO> list = this.questionDAO.list_by_tcateno(tcateno);
    return list;
  }

  @Override
  public ArrayList<QuestionVO> list_by_memberno(int memberno) {
    ArrayList<QuestionVO> list = this.questionDAO.list_by_memberno(memberno);
    return list;
  }

  @Override
  public ArrayList<QuestionVO> list_by_tcateno_search(HashMap<String, Object> hashMap) {
    ArrayList<QuestionVO> list = this.questionDAO.list_by_tcateno_search(hashMap);
    return list;
  }

  @Override
  public int search_count(HashMap<String, Object> hashMap) {
    int cnt = this.questionDAO.search_count(hashMap);
    return cnt;
  }

  @Override
  public ArrayList<QuestionVO> list_by_tcateno_search_paging(QuestionVO questionVO) {
    ArrayList<QuestionVO> list = this.questionDAO.list_by_tcateno_search_paging(questionVO);
    return list;
  }

  @Override
  public QuestionVO read(int questno) {
    QuestionVO questionVO = this.questionDAO.read(questno);
    return questionVO;
  }

  @Override
  public int delete(int questno) {
    int cnt = this.questionDAO.delete(questno);
    return cnt;
  }

  @Override
  public int update_quest(QuestionVO questionVO) {
    int cnt = this.questionDAO.update_quest(questionVO);
    return cnt;
  }

}
