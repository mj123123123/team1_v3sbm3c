package dev.mvc.freview;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.festival.FestivalVO;

/**
 * Spring Boot가 자동 구현
 *
 */
public interface FreviewDAOInter {
	/**
	 * 등록, 추상 메소드
	 * 
	 * @param festivalVO
	 * @return
	 */
	public int create(FreviewVO freviewVO);

	/**
	 * 모든 컨텐츠에 등록된 리뷰 목록
	 * 
	 * @return
	 */
	public ArrayList<FreviewVO> list_all();

	/**
	 * 컨텐츠별 등록된 리뷰 목록
	 * 
	 * @param contentsno
	 * @return
	 */
	public ArrayList<FreviewVO> list_by_contentsno(int contentsno);

	/**
	 * 조회
	 * 
	 * @param reviewno
	 * @return
	 */
	public FreviewVO read(int reviewno);

	/**
	 * map 등록, 수정, 삭제
	 * 
	 * @param map
	 * @return 수정된 레코드 갯수
	 */
	public int map(HashMap<String, Object> map);

	/**
	 * 컨텐츠별 검색 목록
	 * 
	 * @param
	 * @return
	 */
	public ArrayList<FreviewVO> list_by_contentsno_search(HashMap<String, Object> hashMap);

	/**
	 * 컨텐츠별 검색된 레코드 갯수
	 * 
	 * @param
	 * @return
	 */
	public int search_count(HashMap<String, Object> hashMap);

	/**
	 * 컨텐츠별 검색 목록 + 페이징
	 * 
	 * @param festivalVO
	 * @return
	 */
	public ArrayList<FreviewVO> list_by_contentsno_search_paging(FreviewVO freviewVO);

	/**
	 * 패스워드 검사
	 * 
	 * @param hashMap
	 * @return
	 */
	public int password_check(HashMap<String, Object> hashMap);

	/**
	 * 글 정보 수정
	 * 
	 * @param freviewVO
	 * @return 처리된 레코드 갯수
	 */
	public int update_text(FreviewVO freviewVO);

	/**
	 * 파일 정보 수정
	 * 
	 * @param freviewVO
	 * @return 처리된 레코드 갯수
	 */
	public int update_file(FreviewVO freviewVO);

	/**
	 * 삭제
	 * 
	 * @param reviewno
	 * @return 삭제된 레코드 갯수
	 */
	public int delete(int reviewno);

	/**
	 * 특정 카테고리에 속한 모든 레코드 삭제
	 * 
	 * @param contentsno
	 * @return 삭제된 레코드 갯수
	 */
	public int delete_by_contentsno(int contentsno);

}
