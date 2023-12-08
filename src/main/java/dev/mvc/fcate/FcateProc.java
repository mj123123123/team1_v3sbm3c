package dev.mvc.fcate;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

// Controller가 사용하는 이름
@Component("dev.mvc.fcate.FcateProc")
public class FcateProc implements FcateProcInter {
	@Autowired // FcateDAOInter interface를 구현한 클래스의 객체를 만들어 자동으로 할당해라.
	private FcateDAOInter fcateDAO;
 
	@Override
	public int create(FcateVO fcateVO) {
		int cnt = this.fcateDAO.create(fcateVO);

		return cnt;
	}

	@Override
	public ArrayList<FcateVO> list_all() {
		ArrayList<FcateVO> list = this.fcateDAO.list_all();

		return list;
	}

	@Override
	public FcateVO read(int fcateno) {
		FcateVO fcateVO = this.fcateDAO.read(fcateno);

		return fcateVO;
	}

	@Override
	public int update(FcateVO fcateVO) {
		int cnt = this.fcateDAO.update(fcateVO);

		return cnt;
	}

	@Override
	public int delete(int fcateno) {
		int cnt = this.fcateDAO.delete(fcateno);

		return cnt;
	}

	@Override
	public int update_seqno_forward(int fcateno) {
		int cnt = this.fcateDAO.update_seqno_forward(fcateno);
		return cnt;
	}

	@Override
	public int update_seqno_backward(int fcateno) {
		int cnt = this.fcateDAO.update_seqno_backward(fcateno);
		return cnt;
	}

	@Override
	public int update_visible_y(int fcateno) {
		int cnt = this.fcateDAO.update_visible_y(fcateno);
		return cnt;
	}

	@Override
	public int update_visible_n(int fcateno) {
		int cnt = this.fcateDAO.update_visible_n(fcateno);
		return cnt;
	}

	@Override
	public ArrayList<FcateVO> list_all_y() {
		ArrayList<FcateVO> list = this.fcateDAO.list_all_y();
		return list;
	}

}
