package dev.mvc.fcate;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;

/*
 * 관리자 테이블 들어오면 2차 업데이트 해야함
 */

@Controller
public class FcateCont {
	@Autowired // FcateProcInter interface 구현한 객체를 만들어 자동으로 할당해라.
	@Qualifier("dev.mvc.fcate.FcateProc")
	private FcateProcInter fcateProc;

	@Autowired
	@Qualifier("dev.mvc.admin.AdminProc") // "dev.mvc.admin.AdminProc"라고 명명된 클래스
	private AdminProcInter adminProc; // AdminProcInter를 구현한 AdminProc 클래스의 객체를 자동으로 생성하여 할당

	public FcateCont() {
		System.out.println("-> FcateCont created.");
	}

	// FORM 출력, http://localhost:9093/fcate/create.do
	@RequestMapping(value = "/fcate/create.do", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/fcate/create"); // /WEB-INF/views/fcate/create.jsp

		return mav;
	}

	// FORM 데이터 처리, http://localhost:9093/fcate/create.do
	@RequestMapping(value = "/fcate/create.do", method = RequestMethod.POST)
	public ModelAndView create(FcateVO fcateVO) { // 자동으로 fcateVO 객체가 생성되고 폼의 값이 할당됨
		ModelAndView mav = new ModelAndView();

		int cnt = this.fcateProc.create(fcateVO);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			// mav.addObject("code", "create_success"); // 키, 값
			// mav.addObject("name", fcateVO.getName()); // 카테고리 이름 jsp로 전송
			mav.setViewName("redirect:/fcate/list_all.do"); // 주소 자동 이동
		} else {
			mav.addObject("code", "create_fail");
			mav.setViewName("/fcate/msg"); // /WEB-INF/views/fcate/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//	    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 전체 목록 http://localhost:9093/fcate/list_all.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/fcate/list_all.do", method = RequestMethod.GET)
	public ModelAndView list_all(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		if (this.adminProc.isAdmin(session) == true) {
			mav.setViewName("/fcate/list_all"); // /WEB-INF/views/fcate/list_all.jsp

			ArrayList<FcateVO> list = this.fcateProc.list_all();
			mav.addObject("list", list);

		} else {
			mav.setViewName("/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp

		}

		return mav;
	}

	/**
	 * 조회 http://localhost:9093/fcate/read.do?fcateno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/fcate/read.do", method = RequestMethod.GET)
	public ModelAndView read(int fcateno) { // int fcateno = (int)request.getParameter("fcateno");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/fcate/read"); // /WEB-INF/views/fcate/read.jsp

		FcateVO fcateVO = this.fcateProc.read(fcateno);
		mav.addObject("fcateVO", fcateVO);

		return mav;
	}

	/**
	 * 수정폼 http://localhost:9093/fcate/update.do?fcateno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/fcate/update.do", method = RequestMethod.GET)
	public ModelAndView update(HttpSession session, int fcateno) { // int fcateno =
																	// (int)request.getParameter("fcateno");
		ModelAndView mav = new ModelAndView();

		if (this.adminProc.isAdmin(session) == true) {
			// mav.setViewName("/fcate/update"); // /WEB-INF/views/fcate/update.jsp
			mav.setViewName("/fcate/list_all_update"); // /WEB-INF/views/fcate/list_all_update.jsp

			FcateVO fcateVO = this.fcateProc.read(fcateno);
			mav.addObject("fcateVO", fcateVO);

			ArrayList<FcateVO> list = this.fcateProc.list_all();
			mav.addObject("list", list);

		} else {
			mav.setViewName("/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp

		}

		return mav;
	}

	/**
	 * 수정 처리, http://localhost:9093/fcate/update.do
	 * 
	 * @param fcateVO 수정할 내용
	 * @return
	 */
	@RequestMapping(value = "/fcate/update.do", method = RequestMethod.POST)
	public ModelAndView update(FcateVO fcateVO) { // 자동으로 fcateVO 객체가 생성되고 폼의 값이 할당됨
		ModelAndView mav = new ModelAndView();

		int cnt = this.fcateProc.update(fcateVO); // 수정 처리
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			// mav.addObject("code", "update_success"); // 키, 값
			// mav.addObject("name", fcateVO.getName()); // 카테고리 이름 jsp로 전송
			mav.setViewName("redirect:/fcate/list_all.do");

		} else {
			mav.addObject("code", "update_fail");
			mav.setViewName("/fcate/msg"); // /WEB-INF/views/fcate/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
		mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 삭제폼 http://localhost:9093/fcate/delete.do?fcateno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/fcate/delete.do", method = RequestMethod.GET)
	public ModelAndView delete(HttpSession session, int fcateno) { // int fcateno =
																	// (int)request.getParameter("fcateno");
		ModelAndView mav = new ModelAndView();

		if (this.adminProc.isAdmin(session) == true) {
			// mav.setViewName("/fcate/delete"); // /WEB-INF/views/fcate/delete.jsp
			mav.setViewName("/fcate/list_all_delete"); // /WEB-INF/views/fcate/list_all_delete.jsp

			FcateVO fcateVO = this.fcateProc.read(fcateno);
			mav.addObject("fcateVO", fcateVO);

			ArrayList<FcateVO> list = this.fcateProc.list_all();
			mav.addObject("list", list);

		} else {
			mav.setViewName("/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp

		}

		return mav;
	}

	/**
	 * 삭제 처리, http://localhost:9093/fcate/delete.do?fcateno=1
	 * 
	 * @param fcateno 삭제할 레코드 번호
	 * @return
	 */

	@RequestMapping(value = "/fcate/delete.do", method = RequestMethod.POST)
	public ModelAndView delete_proc(int fcateno) { // 자동으로 fcateVO 객체가 생성되고 폼의 값이 할당됨
		ModelAndView mav = new ModelAndView();

		FcateVO fcateVO = this.fcateProc.read(fcateno); // 삭제할 레코드 정보 읽기

		int cnt = this.fcateProc.delete(fcateno); // 삭제 처리
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			// mav.addObject("code", "delete_success"); // 키, 값
			// mav.addObject("name", fcateVO.getName()); // 카테고리 이름 jsp로 전송
			mav.setViewName("redirect:/fcate/list_all.do");
		} else {
			mav.addObject("code", "delete_fail");
			mav.setViewName("/fcate/msg"); // /WEB-INF/views/fcate/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//	    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 우선 순위 높임, 10 등 -> 1 등,
	 * http://localhost:9093/fcate/update_seqno_forward.do?fcateno=1
	 * 
	 * @param fcateVO 수정할 내용
	 * @return
	 */
	@RequestMapping(value = "/fcate/update_seqno_forward.do", method = RequestMethod.GET)
	public ModelAndView update_seqno_forward(int fcateno) {
		ModelAndView mav = new ModelAndView();

		int cnt = this.fcateProc.update_seqno_forward(fcateno);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			mav.setViewName("redirect:/fcate/list_all.do");

		} else {
			mav.addObject("code", "update_fail");
			mav.setViewName("/fcate/msg"); // /WEB-INF/views/fcate/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
		mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 우선 순위 낮춤, 1 등 -> 10 등,
	 * http://localhost:9093/fcate/update_seqno_backward.do?fcateno=1
	 * 
	 * @param fcateno 수정할 레코드 PK 번호
	 * @return
	 */
	@RequestMapping(value = "/fcate/update_seqno_backward.do", method = RequestMethod.GET)
	public ModelAndView update_seqno_backward(int fcateno) {
		ModelAndView mav = new ModelAndView();

		int cnt = this.fcateProc.update_seqno_backward(fcateno);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			mav.setViewName("redirect:/fcate/list_all.do");

		} else {
			mav.addObject("code", "update_fail");
			mav.setViewName("/fcate/msg"); // /WEB-INF/views/fcate/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
//	    mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 카테고리 공개 설정, http://localhost:9093/fcate/update_visible_y.do?fcateno=1
	 * 
	 * @param fcateno 수정할 레코드 PK 번호
	 * @return
	 */
	@RequestMapping(value = "/fcate/update_visible_y.do", method = RequestMethod.GET)
	public ModelAndView update_visible_y(int fcateno) {
		ModelAndView mav = new ModelAndView();

		int cnt = this.fcateProc.update_visible_y(fcateno);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			mav.setViewName("redirect:/fcate/list_all.do");

		} else {
			mav.addObject("code", "update_fail");
			mav.setViewName("/fcate/msg"); // /WEB-INF/views/fcate/msg.jsp
		}

		mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt);
		mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav;
	}

	/**
	 * 카테고리 비공개 설정, http://localhost:9093/fcate/update_visible_n.do?fcateno=1
	 * 
	 * @param fcateno 수정할 레코드 PK 번호
	 * @return
	 */
	@RequestMapping(value = "/fcate/update_visible_n.do", method = RequestMethod.GET)
	public ModelAndView update_visible_n(int fcateno) {
		ModelAndView mav = new ModelAndView();

		int cnt = this.fcateProc.update_visible_n(fcateno);
		System.out.println("-> cnt: " + cnt);

		if (cnt == 1) {
			mav.setViewName("redirect:/fcate/list_all.do");
		} else {
			mav.addObject("code", "update_fail");
			mav.setViewName("/fcate/msg"); // /WEB-INF/views/fcate/msg.jsp
		}

		mav.addObject("cnt", 0); // request.setAttribute("cnt", cnt);

		return mav; // This line was missing in the provided code
	}

}