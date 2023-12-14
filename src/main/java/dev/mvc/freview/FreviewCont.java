package dev.mvc.freview;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.fcate.FcateProcInter;
import dev.mvc.fcate.FcateVO;
import dev.mvc.festival.Festival;
import dev.mvc.festival.FestivalProcInter;
import dev.mvc.festival.FestivalVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class FreviewCont {
	@Autowired
	@Qualifier("dev.mvc.fcate.FcateProc") // @Component("dev.mvc.fcate.FcateProc")
	private FcateProcInter fcateProc;

	@Autowired
	@Qualifier("dev.mvc.festival.FestivalProc") // @Component("dev.mvc.festival.festivalProc")
	private FestivalProcInter festivalProc;

	@Autowired
	@Qualifier("dev.mvc.freview.FreviewProc") // @Component("dev.mvc.freview.FreviewProc")
	private FreviewProcInter freviewProc;

	@Autowired
	@Qualifier("dev.mvc.member.MemberProc") // @Component("dev.mvc.member.MemberProc")
	private MemberProcInter memberProc;

	public FreviewCont() {
		System.out.println("-> FreviewCont created.");
	}

	/**
	 * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근 POST → url → GET →
	 * 데이터 전송
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/msg.do", method = RequestMethod.GET)
	public ModelAndView msg(String url) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName(url); // forward

		return mav; // forward
	}

	// 등록 폼, freview 테이블은 FK로 contentsno를 사용함.
	// http://localhost:9093/freview/create.do X
	// http://localhost:9093/freview/create.do?contentsno=1 // contentsno 변수값을 보내는
	// 목적
	// http://localhost:9093/freview/create.do?contentsno=2
	// http://localhost:9093/freview/create.do?contentsno=3
	@RequestMapping(value = "/freview/create.do", method = RequestMethod.GET)
	public ModelAndView create(HttpSession session, int contentsno) {
		ModelAndView mav = new ModelAndView();
		
		if (memberProc.isMember(session)) {
			FestivalVO festivalVO = this.festivalProc.read(contentsno); // create.jsp에 카테고리 정보를 출력하기위한 목적
			mav.addObject("festivalVO", festivalVO);

			mav.setViewName("/freview/create"); // /webapp/WEB-INF/views/freview/create.jsp
			
		} else {
			mav.setViewName("/member/login_need"); // /WEB-INF/views/admin/login_need.jsp

		}

		return mav;
	}

	/**
	 * 등록 처리 http://localhost:9093/freview/create.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/create.do", method = RequestMethod.POST)
	public ModelAndView create(HttpServletRequest request, HttpSession session, FreviewVO freviewVO) {
		ModelAndView mav = new ModelAndView();

		if (memberProc.isMember(session)) { //
			// ------------------------------------------------------------------------------
			// 파일 전송 코드 시작
			// ------------------------------------------------------------------------------
			String file1 = ""; // 원본 파일명 image
			String file1saved = ""; // 저장된 파일명, image
			String thumb1 = ""; // preview image

			String upDir = Freview.getUploadDir(); // 파일을 업로드할 폴더 준비
			System.out.println("-> upDir: " + upDir);

			// 전송 파일이 없어도 file1MF 객체가 생성됨.
			// <input type='file' class="form-control" name='file1MF' id='file1MF'
			// value='' placeholder="파일 선택">
			MultipartFile mf = freviewVO.getFile1MF();

			file1 = mf.getOriginalFilename(); // 원본 파일명 산출, 01.jpg
			System.out.println("-> 원본 파일명 산출 file1: " + file1);

			if (Tool.checkUploadFile(file1) == true) { // 업로드 가능한 파일인지 검사
				long size1 = mf.getSize(); // 파일 크기

				if (size1 > 0) { // 파일 크기 체크
					// 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
					file1saved = Upload.saveFileSpring(mf, upDir);

					if (Tool.isImage(file1saved)) { // 이미지인지 검사
						// thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
						thumb1 = Tool.preview(upDir, file1saved, 200, 150);
					}

				}

				freviewVO.setFile1(file1); // 순수 원본 파일명
				freviewVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
				freviewVO.setThumb1(thumb1); // 원본이미지 축소판
				freviewVO.setSize1(size1); // 파일 크기
				// ------------------------------------------------------------------------------
				// 파일 전송 코드 종료
				// ------------------------------------------------------------------------------

				// Call By Reference: 메모리 공유, Hashcode 전달
				int memberno = (int) session.getAttribute("memberno"); // memberno FK
				freviewVO.setMemberno(memberno);
				int cnt = this.freviewProc.create(freviewVO);

				// ------------------------------------------------------------------------------
				// PK의 return
				// ------------------------------------------------------------------------------
				// System.out.println("--> reviewno: " + freviewVO.getReviewno());
				// mav.addObject("reviewno", freviewVO.getReviewno()); // redirect
				// parameter 적용
				// ------------------------------------------------------------------------------

				if (cnt == 1) {
					mav.addObject("code", "create_success");
					// fcateProc.increaseCnt(freviewVO.getReviewno()); // 글수 증가
				} else {
					mav.addObject("code", "create_fail");
				}
				mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

				// System.out.println("--> contentsno: " + freviewVO.getContentsno());
				// redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
				mav.addObject("contentsno", freviewVO.getContentsno()); // redirect parameter 적용

				mav.addObject("url", "/freview/msg"); // msg.jsp, redirect parameter 적용
				mav.setViewName("redirect:/freview/msg.do"); // Post -> Get - param...
			} else {
				mav.addObject("cnt", "0"); // 업로드 할 수 없는 파일
				mav.addObject("code", "check_upload_file_fail"); // 업로드 할 수 없는 파일
				mav.addObject("url", "/freview/msg"); // msg.jsp, redirect parameter 적용
				mav.setViewName("redirect:/freview/msg.do"); // Post -> Get - param...
			}
		} else {
			mav.addObject("url", "/member/login_need"); // /WEB-INF/views/member/login_need.jsp
			mav.setViewName("redirect:/freview/msg.do");
		}

		return mav; // forward
	}

	/**
	 * 전체 리뷰 목록, 모두 사용 가능 http://localhost:9093/freview/list_all.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/list_all.do", method = RequestMethod.GET)
	public ModelAndView list_all() {
		System.out.println("-> list_all");
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/freview/list_all"); // /WEB-INF/views/freview/list_all.jsp

		ArrayList<FreviewVO> list = this.freviewProc.list_all();

		// for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
		for (FreviewVO freviewVO : list) {
			String title = freviewVO.getTitle();
			String content = freviewVO.getContent();

			title = Tool.convertChar(title); // 특수 문자 처리
			content = Tool.convertChar(content);

			freviewVO.setTitle(title);
			freviewVO.setContent(content);
		}
		mav.addObject("list", list);

		return mav;
	}

	/**
	 * 목록 + 검색 + 페이징 지원 검색하지 않는 경우
	 * http://localhost:9093/freview/list_by_contentsno.do?contentsno=2&word=&now_page=1
	 * 검색하는 경우
	 * http://localhost:9093/freview/list_by_contentsno.do?contentsno=2&word=탐험&now_page=1
	 * 
	 * @param contentsno
	 * @param word
	 * @param now_page
	 * @return
	 */
	@RequestMapping(value = "/freview/list_by_contentsno.do", method = RequestMethod.GET)
	public ModelAndView list_by_contentsno(FreviewVO freviewVO) {
		ModelAndView mav = new ModelAndView();

		// 검색 목록
		ArrayList<FreviewVO> list = freviewProc.list_by_contentsno_search_paging(freviewVO);

		// for문을 사용하여 객체를 추출, Call By Reference 기반의 원본 객체 값 변경
		for (FreviewVO vo : list) {
			String title = vo.getTitle();
			String content = vo.getContent();

			title = Tool.convertChar(title); // 특수 문자 처리
			content = Tool.convertChar(content);

			vo.setTitle(title);
			vo.setContent(content);

		}

		mav.addObject("list", list);

		FestivalVO festivalVO = festivalProc.read(freviewVO.getContentsno());
		mav.addObject("festivalVO", festivalVO);

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("contentsno", freviewVO.getContentsno());
		hashMap.put("word", freviewVO.getWord());

		int search_count = this.freviewProc.search_count(hashMap); // 검색된 레코드 갯수 -> 전체 페이지 규모 파악
		mav.addObject("search_count", search_count);

		/*
		 * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
		 * 18 19 20 [다음]
		 * 
		 * @param contentsno 컨텐츠번호
		 * 
		 * @param now_page 현재 페이지
		 * 
		 * @param word 검색어
		 * 
		 * @param list_file 목록 파일명
		 * 
		 * @return 페이징용으로 생성된 HTML/CSS tag 문자열
		 */
		String paging = freviewProc.pagingBox(freviewVO.getContentsno(), freviewVO.getNow_page(), freviewVO.getWord(),
				"list_by_contentsno.do", search_count);
		mav.addObject("paging", paging);

		// mav.addObject("now_page", now_page);

		mav.setViewName("/freview/list_by_contentsno"); // /freview/list_by_contentsno.jsp

		return mav;
	}

	/**
	 * 조회 http://localhost:9093/freview/read.do?reviewno=17
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/read.do", method = RequestMethod.GET)
	public ModelAndView read(int reviewno) { // int reviewno = (int)request.getParameter("reviewno");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/freview/read"); // /WEB-INF/views/freview/read.jsp

		FreviewVO freviewVO = this.freviewProc.read(reviewno);

		String title = freviewVO.getTitle();
		String nickname = freviewVO.getNickname();
		String content = freviewVO.getContent();

		title = Tool.convertChar(title); // 특수 문자 처리
		nickname = Tool.convertChar(nickname); // 특수 문자 처리
		content = Tool.convertChar(content);

		freviewVO.setTitle(title);
		freviewVO.setNickname(nickname);
		freviewVO.setContent(content);

		long size1 = freviewVO.getSize1();
		String size1_label = Tool.unit(size1);
		freviewVO.setSize1_label(size1_label);

		mav.addObject("freviewVO", freviewVO);

		FestivalVO festivalVO = this.festivalProc.read(freviewVO.getContentsno());
		mav.addObject("festivalVO", festivalVO);

		return mav;
	}

	/**
	 * 맵 등록/수정/삭제 폼 http://localhost:9093/freview/map.do?reviewno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/map.do", method = RequestMethod.GET)
	public ModelAndView map(int reviewno) {
		ModelAndView mav = new ModelAndView();

		FreviewVO freviewVO = this.freviewProc.read(reviewno); // map 정보 읽어 오기
		mav.addObject("freviewVO", freviewVO); // request.setAttribute("freviewVO", freviewVO);

		FestivalVO festivalVO = this.festivalProc.read(freviewVO.getContentsno()); // 그룹 정보 읽기
		mav.addObject("festivalVO", festivalVO);

		mav.setViewName("/freview/map"); // /WEB-INF/views/freview/map.jsp

		return mav;
	}

	/**
	 * MAP 등록/수정/삭제 처리 http://localhost:9093/freview/map.do
	 * 
	 * @param festivalVO
	 * @return
	 */
	@RequestMapping(value = "/freview/map.do", method = RequestMethod.POST)
	public ModelAndView map_update(int reviewno, String map) {
		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("reviewno", reviewno);
		hashMap.put("map", map);

		this.freviewProc.map(hashMap);

		mav.setViewName("redirect:/freview/read.do?reviewno=" + reviewno);
		// /webapp/WEB-INF/views/freview/read.jsp

		return mav;
	}

	/**
	 * 수정 폼 http://localhost:9093/freview/update_text.do?reviewno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/update_text.do", method = RequestMethod.GET)
	public ModelAndView update_text(HttpSession session, int reviewno) {
		ModelAndView mav = new ModelAndView();

		if (memberProc.isMember(session)) { // 회원 로그인한경우
			FreviewVO freviewVO = this.freviewProc.read(reviewno);
			mav.addObject("freviewVO", freviewVO);

			FestivalVO festivalVO = this.festivalProc.read(freviewVO.getContentsno());
			mav.addObject("festivalVO", festivalVO);

			mav.setViewName("/freview/update_text"); // /WEB-INF/views/freview/update_text.jsp
			// String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
			// mav.addObject("content", content);

		} else {
			mav.addObject("url", "/member/login_need"); // /WEB-INF/views/member/login_need.jsp
			mav.setViewName("redirect:/freview/msg.do");
		}

		return mav; // forward
	}

	/**
	 * 수정 처리 http://localhost:9093/freview/update_text.do?reviewno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/update_text.do", method = RequestMethod.POST)
	public ModelAndView update_text(HttpSession session, FreviewVO freviewVO) {
		ModelAndView mav = new ModelAndView();

		// System.out.println("-> word: " + freviewVO.getWord());

		if (this.memberProc.isMember(session)) { // 회원 로그인 확인
			HashMap<String, Object> hashMap = new HashMap<String, Object>();
			hashMap.put("reviewno", freviewVO.getReviewno());
			hashMap.put("pwd", freviewVO.getPwd());

			if (this.freviewProc.password_check(hashMap) == 1) { // 패스워드 일치
				this.freviewProc.update_text(freviewVO); // 글수정

				// mav 객체 이용
				mav.addObject("reviewno", freviewVO.getReviewno());
				mav.addObject("contentsno", freviewVO.getContentsno());
				mav.setViewName("redirect:/freview/read.do"); // 페이지 자동 이동

			} else { // 패스워드 불일치
				mav.addObject("code", "passwd_fail");
				mav.addObject("cnt", 0);
				mav.addObject("url", "/freview/msg"); // msg.jsp, redirect parameter 적용
				mav.setViewName("redirect:/freview/msg.do"); // POST -> GET -> JSP 출력
			}
		} else { // 정상적인 로그인이 아닌 경우 로그인 유도
			mav.addObject("url", "/member/login_need"); // /WEB-INF/views/member/login_need.jsp
			mav.setViewName("redirect:/freview/msg.do");
		}

		mav.addObject("now_page", freviewVO.getNow_page()); // POST -> GET: 데이터 분실이 발생함으로 다시한번 데이터 저장 ★

		// URL에 파라미터의 전송
		// mav.setViewName("redirect:/freviewVO/read.do?reviewno=" +
		// freviewVO.getReviewno() + "&contentsno=" + freviewVO.getContentsno());

		return mav; // forward
	}

	/**
	 * 파일 수정 폼 http://localhost:9093/freview/update_file.do?reviewno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/update_file.do", method = RequestMethod.GET)
	public ModelAndView update_file(HttpSession session, int reviewno) {
		ModelAndView mav = new ModelAndView();

		if (memberProc.isMember(session)) { // 회원 로그인한경우
			FreviewVO freviewVO = this.freviewProc.read(reviewno);
			mav.addObject("freviewVO", freviewVO);

			FestivalVO festivalVO = this.festivalProc.read(freviewVO.getContentsno());
			mav.addObject("festivalVO", festivalVO);

			mav.setViewName("/freview/update_file"); // /WEB-INF/views/freview/update_file.jsp

		} else {
			mav.addObject("url", "/member/login_need"); // /WEB-INF/views/member/login_need.jsp
			mav.setViewName("redirect:/freview/msg.do");
		}

		return mav; // forward
	}

	/**
	 * 파일 수정 처리 http://localhost:9093/freview/update_file.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/update_file.do", method = RequestMethod.POST)
	public ModelAndView update_file(HttpSession session, FreviewVO freviewVO) {
		ModelAndView mav = new ModelAndView();

		if (this.memberProc.isMember(session)) {
			// 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
			FreviewVO freviewVO_old = freviewProc.read(freviewVO.getReviewno());

			// -------------------------------------------------------------------
			// 파일 삭제 시작
			// -------------------------------------------------------------------
			String file1saved = freviewVO_old.getFile1saved(); // 실제 저장된 파일명
			String thumb1 = freviewVO_old.getThumb1(); // 실제 저장된 preview 이미지 파일명
			long size1 = 0;

			String upDir = Freview.getUploadDir(); // C:/kd/deploy/team1_v3sbm3c/Freview/storage/

			Tool.deleteFile(upDir, file1saved); // 실제 저장된 파일삭제
			Tool.deleteFile(upDir, thumb1); // preview 이미지 삭제
			// -------------------------------------------------------------------
			// 파일 삭제 종료
			// -------------------------------------------------------------------

			// -------------------------------------------------------------------
			// 파일 전송 시작
			// -------------------------------------------------------------------
			String file1 = ""; // 원본 파일명 image

			// 전송 파일이 없어도 file1MF 객체가 생성됨.
			// <input type='file' class="form-control" name='file1MF' id='file1MF'
			// value='' placeholder="파일 선택">
			MultipartFile mf = freviewVO.getFile1MF();

			file1 = mf.getOriginalFilename(); // 원본 파일명
			size1 = mf.getSize(); // 파일 크기

			if (size1 > 0) { // 폼에서 새롭게 올리는 파일이 있는지 파일 크기로 체크 ★
				// 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
				file1saved = Upload.saveFileSpring(mf, upDir);

				if (Tool.isImage(file1saved)) { // 이미지인지 검사
					// thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
					thumb1 = Tool.preview(upDir, file1saved, 250, 200);
				}

			} else { // 파일이 삭제만 되고 새로 올리지 않는 경우
				file1 = "";
				file1saved = "";
				thumb1 = "";
				size1 = 0;
			}

			freviewVO.setFile1(file1);
			freviewVO.setFile1saved(file1saved);
			freviewVO.setThumb1(thumb1);
			freviewVO.setSize1(size1);
			// -------------------------------------------------------------------
			// 파일 전송 코드 종료
			// -------------------------------------------------------------------

			this.freviewProc.update_file(freviewVO); // Oracle 처리

			mav.addObject("reviewno", freviewVO.getReviewno());
			mav.addObject("contentsno", freviewVO.getContentsno());
			mav.setViewName("redirect:/freview/read.do"); // request -> param으로 접근 전환

		} else {
			mav.addObject("url", "/member/login_need"); // login_need.jsp, redirect parameter 적용
			mav.setViewName("redirect:/freview/msg.do"); // GET
		}

		// redirect하게되면 전부 데이터가 삭제됨으로 mav 객체에 다시 저장
		mav.addObject("now_page", freviewVO.getNow_page());

		return mav; // forward
	}
	
	/**
	 * 파일 삭제 폼 http://localhost:9093/freview/delete.do?reviewno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/delete.do", method = RequestMethod.GET)
	public ModelAndView delete(HttpSession session, int reviewno) {
		ModelAndView mav = new ModelAndView();

		if (memberProc.isMember(session)) { // 관리자로 로그인한경우
			FreviewVO freviewVO = this.freviewProc.read(reviewno);
			mav.addObject("freviewVO", freviewVO);

			FestivalVO festivalVO = this.festivalProc.read(freviewVO.getContentsno());
			mav.addObject("festivalVO", festivalVO);

			mav.setViewName("/freview/delete"); // /WEB-INF/views/freview/delete.jsp

		} else {
			mav.addObject("url", "/member/login_need"); // /WEB-INF/views/member/login_need.jsp
			mav.setViewName("redirect:/freview/msg.do");
		}

		return mav; // forward
	}

	/**
	 * 삭제 처리 http://localhost:9093/freview/delete.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/freview/delete.do", method = RequestMethod.POST)
	public ModelAndView delete(FreviewVO freviewVO) {
		ModelAndView mav = new ModelAndView();

		// -------------------------------------------------------------------
		// 파일 삭제 시작
		// -------------------------------------------------------------------
		// 삭제할 파일 정보를 읽어옴.
		FreviewVO freviewVO_read = freviewProc.read(freviewVO.getReviewno());

		String file1saved = freviewVO.getFile1saved();
		String thumb1 = freviewVO.getThumb1();
		

		String uploadDir = Freview.getUploadDir();
		Tool.deleteFile(uploadDir, file1saved); // 실제 저장된 파일삭제
		Tool.deleteFile(uploadDir, thumb1); // preview 이미지 삭제
		// -------------------------------------------------------------------
		// 파일 삭제 종료
		// -------------------------------------------------------------------

		this.freviewProc.delete(freviewVO.getReviewno()); // DBMS 삭제

		// -------------------------------------------------------------------------------------
		// 마지막 페이지의 마지막 레코드 삭제시의 페이지 번호 -1 처리
		// -------------------------------------------------------------------------------------
		// 마지막 페이지의 마지막 10번째 레코드를 삭제후
		// 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
		// 페이지수를 4 -> 3으로 감소 시켜야함, 마지막 페이지의 마지막 레코드 삭제시 나머지는 0 발생
		int now_page = freviewVO.getNow_page();

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("contentsno", freviewVO.getContentsno());
		hashMap.put("word", freviewVO.getWord());

		if (freviewProc.search_count(hashMap) % Festival.RECORD_PER_PAGE == 0) {
			now_page = now_page - 1; // 삭제시 DBMS는 바로 적용되나 크롬은 새로고침등의 필요로 단계가 작동 해야함.
			if (now_page < 1) {
				now_page = 1; // 시작 페이지
			}
		}
		// -------------------------------------------------------------------------------------

		mav.addObject("contentsno", freviewVO.getContentsno());
		mav.addObject("now_page", now_page);
		mav.setViewName("redirect:/freview/list_by_contentsno.do");

		return mav;
	}

	// http://localhost:9093/freview/delete_by_contentsno.do?contentsno=1
	// 파일 삭제 -> 레코드 삭제
	@RequestMapping(value = "/freview/delete_by_contentsno.do", method = RequestMethod.GET)
	public String delete_by_contentsno(int contentsno) {
		ArrayList<FreviewVO> list = this.freviewProc.list_by_contentsno(contentsno);

		for (FreviewVO freviewVO : list) {
			// -------------------------------------------------------------------
			// 파일 삭제 시작
			// -------------------------------------------------------------------
			String file1saved = freviewVO.getFile1saved();
			String thumb1 = freviewVO.getThumb1();

			String uploadDir = Freview.getUploadDir();
			Tool.deleteFile(uploadDir, file1saved); // 실제 저장된 파일삭제
			Tool.deleteFile(uploadDir, thumb1); // preview 이미지 삭제
			// -------------------------------------------------------------------
			// 파일 삭제 종료
			// -------------------------------------------------------------------
		}

		int cnt = this.freviewProc.delete_by_contentsno(contentsno);
		System.out.println("-> count: " + cnt);

		return "";

	}

}
