package dev.mvc.festival;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * 개발자가 구현합니다.
 * @author soldesk
 *
 */
public interface FestivalProcInter {
  /**
   * 등록
   * @param festivalVO
   * @return
   */
  public int create(FestivalVO festivalVO);

  /**
   * 모든 카테고리의 등록된 글목록
   * @return
   */
  public ArrayList<FestivalVO> list_all();
 
  /**
   * 카테고리별 등록된 글 목록
   * @param fcateno
   * @return
   */
  public ArrayList<FestivalVO> list_by_fcateno(int fcateno);
  
  /**
   * 조회
   * @param contentsno
   * @return
   */
  public FestivalVO read(int contentsno);
  
  /**
   * map 등록, 수정, 삭제
   * @param map
   * @return 수정된 레코드 갯수
   */
  public int map(HashMap<String, Object> map);

  /**
   * youtube 등록, 수정, 삭제
   * @param youtube
   * @return 수정된 레코드 갯수
   */
  public int youtube(HashMap<String, Object> map);
  
  /**
   * 카테고리별 검색 목록
   * @param map
   * @return
   */
  public ArrayList<FestivalVO> list_by_fcateno_search(HashMap<String, Object> hashMap);
  
  /**
   * 카테고리별 검색된 레코드 갯수
   * @param map
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   * 카테고리별 검색 목록 + 페이징
   * @param festivalVO
   * @return
   */
  public ArrayList<FestivalVO> list_by_fcateno_search_paging(FestivalVO festivalVO);
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param fcateno          카테고리번호 
   * @param now_page      현재 페이지
   * @param word 검색어
   * @param list_file 목록 파일명
   * @param search_count 검색 레코드수   
   * @return 페이징 생성 문자열
   */ 
  public String pagingBox(int fcateno, int now_page, String word, String list_file, int search_count);

  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int password_check(HashMap<String, Object> hashMap);
  
  /**
   * 글 정보 수정
   * @param festivalVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(FestivalVO festivalVO);
  
  /**
   * 파일 정보 수정
   * @param festivalVO
   * @return 처리된 레코드 갯수
   */
  public int update_file(FestivalVO festivalVO);
  
  /**
   * 삭제
   * @param contentsno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int contentsno);
  
  /**
   * FK fcateno 값이 같은 레코드 갯수 산출
   * @param fcateno
   * @return
   */
  public int count_by_fcateno(int fcateno);
  
  /**
   * 특정 카테고리에 속한 모든 레코드 삭제
   * @param fcateno
   * @return 삭제된 레코드 갯수
   */
  public int delete_by_fcateno(int fcateno);
  
}

