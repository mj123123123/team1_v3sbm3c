package dev.mvc.frecommend;

import java.util.ArrayList;

public interface  FrecommendDAOInter {

	/**
	 * 등록
	 * 
	 * @param frecommendVO
	 * @return  
	 */
	public int create(FrecommendVO frecommendVO);

	/**
	 * 전체 목록
	 * 
	 * @return
	 */
	public ArrayList<FrecommendVO> list_all();

	/**
	 * 조회
	 * 
	 * @param frecommendno
	 * @return
	 */
	public FrecommendVO read(int frecommendno);

	/**
	 * 회원번호를 이용한 조회
	 * 
	 * @param frecommendno
	 * @return
	 */
	public FrecommendVO read_memberno(int memberno);

	/**
	 * 삭제
	 * 
	 * @param frecommendno
	 * @return 삭제된 레코드 개수
	 */
	public int delete(int frecommendno);
}
