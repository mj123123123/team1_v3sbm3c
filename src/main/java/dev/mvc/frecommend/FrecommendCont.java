package dev.mvc.frecommend;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.fcate.FcateProcInter;
import dev.mvc.fcate.FcateVO;
import dev.mvc.festival.FestivalProcInter;
import dev.mvc.member.MemberProcInter;

@Controller
public class FrecommendCont {
	@Autowired
	@Qualifier("dev.mvc.frecommend.FrecommendProc")
	private FrecommendProcInter frecommendProc;

	@Autowired
	@Qualifier("dev.mvc.member.MemberProc")
	private MemberProcInter memberProc;

	@Autowired
	@Qualifier("dev.mvc.fcate.FcateProc")
	private FcateProcInter fcateProc;

	@Autowired
	@Qualifier("dev.mvc.festival.FestivalProc")
	private FestivalProcInter festivalProc;

	public FrecommendCont() {
		System.out.println("-> FrecommendCont");

	}

	/**
	 * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근 POST → url → GET →
	 * 데이터 전송
	 * 
	 * @return
	 */
	@RequestMapping(value = "/frecommend/msg.do", method = RequestMethod.GET)
	public ModelAndView msg(String url) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName(url); // forward

		return mav; // forward
	}

	/**
	 * 등록
	 * 
	 * @param frecommendVO
	 * @return
	 */

	// FORM 출력, http://localhost:9093/frecommend/create.do
	@RequestMapping(value = "/frecommend/create.do", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/frecommend/create"); // /WEB-INF/views/frecommend/create.jsp

		return mav;
	}

	// FORM 데이터 처리, http://localhost:9093/frecommend/create.do
	@RequestMapping(value = "/frecommend/create.do", method = RequestMethod.POST)
	public ModelAndView create(FrecommendVO frecommendVO) { // 자동으로 frecommendVO 객체가 생성되고 폼의 값이 할당됨
		ModelAndView mav = new ModelAndView();

		int cnt = this.frecommendProc.create(frecommendVO);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			// mav.addObject("code", "create_success"); // 키, 값
			// mav.addObject("name", frecommendVO.getName()); // 카테고리 이름 jsp로 전송
			mav.setViewName("redirect:/fcate/list_all.do"); // 주소 자동 이동
		} else {
			mav.addObject("code", "create_fail");
			mav.setViewName("/frecommend/msg"); // /WEB-INF/views/frecommend/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//		mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 전체 목록 http://localhost:9093/frecommend/list_all.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/frecommend/list_all.do", method = RequestMethod.GET)
	public ModelAndView list_all(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/frecommend/list_all"); // WEB-INF/views/frecommend/list_all.jsp

		if (this.memberProc.isMember(session) == true) {
			mav.setViewName("/frecommend/list_all"); // /WEB-INF/views/frecommend/list_all.jsp
			ArrayList<FrecommendVO> list = this.frecommendProc.list_all();

			mav.addObject("list", list);

		} else {
			mav.setViewName("/member/login_need"); // /WEB-INF/views/member/login_need.jsp

		}

		return mav;
	}

	/**
	 * 조회 http://localhost:9093/frecommend/read.do?frecommendno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/frecommend/read.do", method = RequestMethod.GET)
	public ModelAndView read(int frecommendno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/frecommend/read");

		FrecommendVO frecommendVO = this.frecommendProc.read(frecommendno);

		mav.addObject("frecommendVO", frecommendVO);

		return mav;
	}

	/**
	 * 회원번호를 기준으로 조회 http://localhost:9093/frecommend/read_memberno.do?memberno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/frecommend/read_memberno.do", method = RequestMethod.GET)
	public ModelAndView read_memberno(int memberno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/frecommend/read");

		FrecommendVO frecommendVO = this.frecommendProc.read_memberno(memberno);

		mav.addObject("frecommendVO", frecommendVO);

		return mav;
	}

	/**
	 * 파일 삭제 폼 http://localhost:9093/frecommend/delete.do?frecommendno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/frecommend/delete.do", method = RequestMethod.GET)
	public ModelAndView delete(HttpSession session, int frecommendno) {
		ModelAndView mav = new ModelAndView();

		if (memberProc.isMember(session)) {
			System.out.println("-> customer");
			FrecommendVO frecommendVO = this.frecommendProc.read(frecommendno);
			mav.addObject("frecommendVO", frecommendVO);

			mav.setViewName("/frecommend/delete");

		} else {
			mav.addObject("url", "/member/login_need");
			mav.setViewName("redirect:/member/msg.do");
		}

		return mav;
	}    

	/**
	 * 삭제 처리 http://localhost:9093/frecommend/delete.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/frecommend/delete.do", method = RequestMethod.POST)
	public ModelAndView delete(FrecommendVO frecommendVO) {
		System.out.println("-> deletedo");
		ModelAndView mav = new ModelAndView();

		FrecommendVO frecommendVO_read = this.frecommendProc.read(frecommendVO.getFrecommendno());
		this.frecommendProc.delete(frecommendVO.getFrecommendno()); // DBMS 삭제

		mav.addObject("frecommendno", frecommendVO.getFrecommendno());
		mav.setViewName("redirect:/frecommend/list_all.do");

		return mav;

	}   

}
