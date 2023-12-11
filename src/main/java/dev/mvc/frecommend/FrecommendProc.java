package dev.mvc.frecommend;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.frecommend.FrecommendProc")
public class FrecommendProc implements FrecommendProcInter {
	@Autowired
	private FrecommendDAOInter frecommendDAO;

	@Override
	public int create(FrecommendVO frecommendVO) {
		// 등록  
		int cnt = this.frecommendDAO.create(frecommendVO);
		return cnt;
	}

	@Override
	public ArrayList<FrecommendVO> list_all() {
		// 전체 목록
		ArrayList<FrecommendVO> list = this.frecommendDAO.list_all();
		return list;
	}

	@Override
	public FrecommendVO read(int frecommendno) {
		// 조회
		FrecommendVO frecommendVO = this.frecommendDAO.read(frecommendno);
		return frecommendVO;
	}

	@Override
	public FrecommendVO read_memberno(int memberno) {
		// 회원번호를 이용한 조회
		FrecommendVO frecommendVO = this.frecommendDAO.read_memberno(memberno);
		return frecommendVO;
	}

	@Override
	public int delete(int frecommendno) {
		// 삭제
		int cnt = this.frecommendDAO.delete(frecommendno);
		return cnt;
	}
	

}
