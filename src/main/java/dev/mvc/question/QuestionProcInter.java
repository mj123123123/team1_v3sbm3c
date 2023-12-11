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
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param cateno          카테고리번호 
   * @param now_page      현재 페이지
   * @param word 검색어
   * @param list_file 목록 파일명
   * @param search_count 검색 레코드수   
   * @return 페이징 생성 문자열
   */ 
  public String pagingBox(int tcateno, int now_page, String list_file, int search_count);
  
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
