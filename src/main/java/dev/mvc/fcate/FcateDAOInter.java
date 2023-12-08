package dev.mvc.fcate;

import java.util.ArrayList;

public interface FcateDAOInter {

	/** 
	 * 등록, 추상 메소드 -> Spring Boot이 구현함.
	 * 
	 * @param fcateVO 객체
	 * @return 등록된 레코드 갯수
	 */
	public int create(FcateVO fcateVO);

	/**
	 * 전체 목록
	 * 
	 * @return
	 */
	public ArrayList<FcateVO> list_all();

	/**
	 * 조회
	 * 
	 * @param fcateno
	 * @return
	 */
	public FcateVO read(int fcateno);

	/**
	 * 수정
	 * 
	 * @param fcateVO
	 * @return 수정된 레코드 갯수
	 */
	public int update(FcateVO fcateVO);

	/**
	 * 삭제
	 * 
	 * @param fcateno 삭제할 레코드 PK 번호
	 * @return 삭제된 레코드 갯수
	 */
	public int delete(int fcateno);

	/**
	 * 우선 순위 높임, 10 등 -> 1 등
	 * 
	 * @param fcateno
	 * @return 수정된 레코드 갯수
	 */
	public int update_seqno_forward(int fcateno);

	/**
	 * 우선 순위 낮춤, 1 등 -> 10 등
	 * 
	 * @param fcateno
	 * @return 수정된 레코드 갯수
	 */
	public int update_seqno_backward(int fcateno);

	/**
	 * 카테고리 공개 설정
	 * 
	 * @param fcateno
	 * @return
	 */
	public int update_visible_y(int fcateno);

	/**
	 * 카테고리 비공개 설정
	 * 
	 * @param fcateno
	 * @return
	 */
	public int update_visible_n(int fcateno);

	/**
	 * 비회원/회원 SELECT LIST
	 * 
	 * @return
	 */
	public ArrayList<FcateVO> list_all_y();

}
