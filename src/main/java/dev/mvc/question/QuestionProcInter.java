package dev.mvc.question;

import java.util.ArrayList;
import java.util.HashMap;

public interface QuestionProcInter {
  /**
   * 질문 등록
   * @param questionVO
   * @return 등록된 레코드
   */
  public int create(QuestionVO questionVO);
  
  /**
   * 모든 질문 목록 - 모든 사람 사용 가능
   * @return
   */
  public ArrayList<QuestionVO> list_all();
  
  /**
   * 특정 카테고리의 등록된 질문 목록 - 모든 사람 사용 가능
   * @param tcateno
   * @return
   */
  public ArrayList<QuestionVO> list_by_tcateno(int tcateno);
  
  
  /**
   * 특정 회원의 등록된 질문 목록 - 관리자만 사용 가능
   * @param memberno
   * @return
   */
  public ArrayList<QuestionVO> list_by_memberno(int memberno);
  
  /**
   * 카테고리별 검색 목록
   * @param map
   * @return
   */
  public ArrayList<QuestionVO> list_by_tcateno_search(HashMap<String, Object> hashMap);
  
  /**
   * 카테고리별 검색된 레코드 갯수
   * @param map
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   * 카테고리별 검색 목록 + 페이징
   * @param questionVO
   * @return
   */
  public ArrayList<QuestionVO> list_by_tcateno_search_paging(QuestionVO questionVO);
  
  /**
   * 조회
   * @param questno
   * @return
   */
  public QuestionVO read(int questno);
  
  /**
   * 삭제
   * @param questno
   * @return
   */
  public int delete(int questno);
  
  /**
   * 글 수정
   * @param questionVO
   * @return
   */
  public int update_quest(QuestionVO questionVO);
}
