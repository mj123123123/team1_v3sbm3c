package dev.mvc.festival;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
//import dev.mvc.admin.AdminProcInter;
import dev.mvc.fcate.FcateProcInter;
import dev.mvc.fcate.FcateVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class FestivalCont {

	@Autowired
	@Qualifier("dev.mvc.fcate.FcateProc") // @Component("dev.mvc.fcate.FcateProc")
	private FcateProcInter fcateProc;

	@Autowired
	@Qualifier("dev.mvc.admin.AdminProc") // @Component("dev.mvc.admin.AdminProc")
	private AdminProcInter adminProc;

	@Autowired
	@Qualifier("dev.mvc.festival.FestivalProc") // @Component("dev.mvc.festival.festivalProc")
	private FestivalProcInter festivalProc;

	public FestivalCont() {
		System.out.println("-> FestivalCont created.");
	}

	/**
	 * POST ��û�� JSP ���������� JSTL ȣ�� ��� ����, ���ΰ�ħ ����, EL���� param���� ���� POST �� url �� GET ��
	 * ������ ����
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/msg.do", method = RequestMethod.GET)
	public ModelAndView msg(String url) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName(url); // forward

		return mav; // forward
	}

	// ��� ��, contents ���̺��� FK�� fcateno�� �����.
	// http://localhost:9093/festival/create.do X
	// http://localhost:9093/festival/create.do?fcateno=1 // fcateno �������� ������ ����
	// http://localhost:9093/festival/create.do?fcateno=2
	// http://localhost:9093/festival/create.do?fcateno=3
	@RequestMapping(value = "/festival/create.do", method = RequestMethod.GET)
	public ModelAndView create(HttpServletRequest request, int fcateno) {
		ModelAndView mav = new ModelAndView();

		FcateVO fcateVO = this.fcateProc.read(fcateno); // create.jsp�� ī�װ� ������ ����ϱ����� ����
		mav.addObject("fcateVO", fcateVO);
//    request.setAttribute("fcateVO", fcateVO);

		mav.setViewName("/festival/create"); // /webapp/WEB-INF/views/festival/create.jsp

		return mav;
	}

	/**
	 * ��� ó�� http://localhost:9093/festival/create.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/create.do", method = RequestMethod.POST)
	public ModelAndView create(HttpServletRequest request, HttpSession session, FestivalVO festivalVO) {
		ModelAndView mav = new ModelAndView();

		if (adminProc.isAdmin(session)) { // �����ڷ� �α����Ѱ��
			// ------------------------------------------------------------------------------
			// ���� ���� �ڵ� ����
			// ------------------------------------------------------------------------------
			String file1 = ""; // ���� ���ϸ� image
			String file1saved = ""; // ����� ���ϸ�, image
			String thumb1 = ""; // preview image

			String upDir = Festival.getUploadDir(); // ������ ���ε��� ���� �غ�
			System.out.println("-> upDir: " + upDir);

			// ���� ������ ��� file1MF ��ü�� ������.
			// <input type='file' class="form-control" name='file1MF' id='file1MF'
			// value='' placeholder="���� ����">
			MultipartFile mf = festivalVO.getFile1MF();

			file1 = mf.getOriginalFilename(); // ���� ���ϸ� ����, 01.jpg
			System.out.println("-> ���� ���ϸ� ���� file1: " + file1);

			if (Tool.checkUploadFile(file1) == true) { // ���ε� ������ �������� �˻�
				long size1 = mf.getSize(); // ���� ũ��

				if (size1 > 0) { // ���� ũ�� üũ
					// ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
					file1saved = Upload.saveFileSpring(mf, upDir);

					if (Tool.isImage(file1saved)) { // �̹������� �˻�
						// thumb �̹��� ������ ���ϸ� ���ϵ�, width: 200, height: 150
						thumb1 = Tool.preview(upDir, file1saved, 200, 150);
					}

				}

				festivalVO.setFile1(file1); // ���� ���� ���ϸ�
				festivalVO.setFile1saved(file1saved); // ����� ���ϸ�(���ϸ� �ߺ� ó��)
				festivalVO.setThumb1(thumb1); // �����̹��� �����
				festivalVO.setSize1(size1); // ���� ũ��
				// ------------------------------------------------------------------------------
				// ���� ���� �ڵ� ����
				// ------------------------------------------------------------------------------

				// Call By Reference: �޸� ����, Hashcode ����
				int adminno = (int) session.getAttribute("adminno"); // adminno FK
				festivalVO.setAdminno(adminno);
				int cnt = this.festivalProc.create(festivalVO);

				// ------------------------------------------------------------------------------
				// PK�� return
				// ------------------------------------------------------------------------------
				// System.out.println("--> contentsno: " + festivalVO.getFestivalno());
				// mav.addObject("contentsno", contentsno.getContentsno()); // redirect
				// parameter ����
				// ------------------------------------------------------------------------------

				if (cnt == 1) {
					mav.addObject("code", "create_success");
					// fcateProc.increaseCnt(contentsno.getFcateno()); // �ۼ� ����
				} else {
					mav.addObject("code", "create_fail");
				}
				mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

				// System.out.println("--> fcateno: " + festivalVO.getFcateno());
				// redirect�ÿ� hidden tag�� �����͵��� ������ �ȵ����� request�� �ٽ� ����
				mav.addObject("fcateno", festivalVO.getFcateno()); // redirect parameter ����

				mav.addObject("url", "/festival/msg"); // msg.jsp, redirect parameter ����
				mav.setViewName("redirect:/festival/msg.do"); // Post -> Get - param...
			} else {
				mav.addObject("cnt", "0"); // ���ε� �� �� ���� ����
				mav.addObject("code", "check_upload_file_fail"); // ���ε� �� �� ���� ����
				mav.addObject("url", "/festival/msg"); // msg.jsp, redirect parameter ����
				mav.setViewName("redirect:/festival/msg.do"); // Post -> Get - param...
			}
		} else {
			mav.addObject("url", "/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp
			mav.setViewName("redirect:/festival/msg.do");
		}

		return mav; // forward
	}

	/**
	 * ��ü ���, �����ڸ� ��� ���� http://localhost:9093/festival/list_all.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/list_all.do", method = RequestMethod.GET)
	public ModelAndView list_all(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		if (this.adminProc.isAdmin(session) == true) {
			mav.setViewName("/festival/list_all"); // /WEB-INF/views/festival/list_all.jsp

			ArrayList<FestivalVO> list = this.festivalProc.list_all();

			// for���� ����Ͽ� ��ü�� ����, Call By Reference ����� ���� ��ü �� ����
			for (FestivalVO festivalVO : list) {
				String title = festivalVO.getTitle();
				String content = festivalVO.getContent();

				title = Tool.convertChar(title); // Ư�� ���� ó��
				content = Tool.convertChar(content);

				festivalVO.setTitle(title);
				festivalVO.setContent(content);

			}

			mav.addObject("list", list);

		} else {
			mav.setViewName("/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp

		}

		return mav;
	}

	/**
	 * Ư�� ī�װ��� �˻� ��� http://localhost:9093/festival/list_by_fcateno.do?fcateno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/list_by_fcateno.do", method = RequestMethod.GET)
	public ModelAndView list_by_fcateno(int fcateno, String word) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("/festival/list_by_fcateno"); // /WEB-INF/views/festival/list_by_fcateno.jsp

		FcateVO fcateVO = this.fcateProc.read(fcateno); // create.jsp�� ī�װ� ������ ����ϱ����� ����
		mav.addObject("fcateVO", fcateVO);
		// request.setAttribute("fcateVO", fcateVO);

		// �˻����� �ʴ� ���
		// ArrayList<FestivalVO> list = this.festivalProc.list_by_fcateno(fcateno);

		// �˻��ϴ� ���
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("fcateno", fcateno);
		hashMap.put("word", word);

		ArrayList<FestivalVO> list = this.festivalProc.list_by_fcateno_search(hashMap);

		// for���� ����Ͽ� ��ü�� ����, Call By Reference ����� ���� ��ü �� ����
		for (FestivalVO festivalVO : list) {
			String title = festivalVO.getTitle();
			String content = festivalVO.getContent();

			title = Tool.convertChar(title); // Ư�� ���� ó��
			content = Tool.convertChar(content);

			festivalVO.setTitle(title);
			festivalVO.setContent(content);

		}

		mav.addObject("list", list);

		return mav;
	}

	/**
	 * ��� + �˻� + ����¡ ���� �˻����� �ʴ� ���
	 * http://localhost:9093/festival/list_by_fcateno.do?fcateno=2&word=&now_page=1
	 * �˻��ϴ� ���
	 * http://localhost:9093/festival/list_by_fcateno.do?fcateno=2&word=Ž��&now_page=1
	 * 
	 * @param fcateno
	 * @param word
	 * @param now_page
	 * @return
	 */
	@RequestMapping(value = "/festival/list_by_fcateno.do", method = RequestMethod.GET)
	public ModelAndView list_by_fcateno(FestivalVO festivalVO) {
		ModelAndView mav = new ModelAndView();

		// �˻� ���
		ArrayList<FestivalVO> list = festivalProc.list_by_fcateno_search_paging(festivalVO);

		// for���� ����Ͽ� ��ü�� ����, Call By Reference ����� ���� ��ü �� ����
		for (FestivalVO vo : list) {
			String title = vo.getTitle();
			String content = vo.getContent();

			title = Tool.convertChar(title); // Ư�� ���� ó��
			content = Tool.convertChar(content);

			vo.setTitle(title);
			vo.setContent(content);

		}

		mav.addObject("list", list);

		FcateVO fcateVO = fcateProc.read(festivalVO.getFcateno());
		mav.addObject("fcateVO", fcateVO);

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("fcateno", festivalVO.getFcateno());
		hashMap.put("word", festivalVO.getWord());

		int search_count = this.festivalProc.search_count(hashMap); // �˻��� ���ڵ� ���� -> ��ü ������ �Ը� �ľ�
		mav.addObject("search_count", search_count);

		/*
		 * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� ���� ������: 11 / 22 [����] 11 12 13 14 15 16 17
		 * 18 19 20 [����]
		 * 
		 * @param fcateno ī�װ���ȣ
		 * 
		 * @param now_page ���� ������
		 * 
		 * @param word �˻���
		 * 
		 * @param list_file ��� ���ϸ�
		 * 
		 * @return ����¡������ ������ HTML/CSS tag ���ڿ�
		 */
		String paging = festivalProc.pagingBox(festivalVO.getFcateno(), festivalVO.getNow_page(), festivalVO.getWord(),
				"list_by_fcateno.do", search_count);
		mav.addObject("paging", paging);

		// mav.addObject("now_page", now_page);

		mav.setViewName("/festival/list_by_fcateno"); // /festival/list_by_fcateno.jsp

		return mav;
	}

	/**
	 * ��� + �˻� + ����¡ ���� + Grid �˻����� �ʴ� ���
	 * http://localhost:9093/festival/list_by_fcateno_grid.do?fcateno=2&word=&now_page=1
	 * �˻��ϴ� ���
	 * http://localhost:9093/festival/list_by_fcateno_grid.do?fcateno=2&word=Ž��&now_page=1
	 * 
	 * @param fcateno
	 * @param word
	 * @param now_page
	 * @return
	 */
	@RequestMapping(value = "/festival/list_by_fcateno_grid.do", method = RequestMethod.GET)
	public ModelAndView list_by_fcateno_grid(FestivalVO festivalVO) {
		ModelAndView mav = new ModelAndView();

		// �˻� ���
		ArrayList<FestivalVO> list = festivalProc.list_by_fcateno_search_paging(festivalVO);

		// for���� ����Ͽ� ��ü�� ����, Call By Reference ����� ���� ��ü �� ����
		for (FestivalVO vo : list) {
			String title = vo.getTitle();
			String content = vo.getContent();

			title = Tool.convertChar(title); // Ư�� ���� ó��
			content = Tool.convertChar(content);

			vo.setTitle(title);
			vo.setContent(content);

		}

		mav.addObject("list", list);

		FcateVO fcateVO = fcateProc.read(festivalVO.getFcateno());
		mav.addObject("fcateVO", fcateVO);

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("fcateno", festivalVO.getFcateno());
		hashMap.put("word", festivalVO.getWord());

		int search_count = this.festivalProc.search_count(hashMap); // �˻��� ���ڵ� ���� -> ��ü ������ �Ը� �ľ�
		mav.addObject("search_count", search_count);

		/*
		 * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� ���� ������: 11 / 22 [����] 11 12 13 14 15 16 17
		 * 18 19 20 [����]
		 * 
		 * @param fcateno ī�װ���ȣ
		 * 
		 * @param now_page ���� ������
		 * 
		 * @param word �˻���
		 * 
		 * @param list_file ��� ���ϸ�
		 * 
		 * @return ����¡������ ������ HTML/CSS tag ���ڿ�
		 */
		String paging = festivalProc.pagingBox(festivalVO.getFcateno(), festivalVO.getNow_page(), festivalVO.getWord(),
				"list_by_fcateno_grid.do", search_count);
		mav.addObject("paging", paging);

		// mav.addObject("now_page", now_page);

		mav.setViewName("/festival/list_by_fcateno_grid"); // /festival/list_by_fcateno_grid.jsp

		return mav;
	}

	/**
	 * ��ȸ http://localhost:9093/festival/read.do?contentsno=17
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/read.do", method = RequestMethod.GET)
	public ModelAndView read(int contentsno) { // int fcateno = (int)request.getParameter("fcateno");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/festival/read"); // /WEB-INF/views/festival/read.jsp

		FestivalVO festivalVO = this.festivalProc.read(contentsno);

		String title = festivalVO.getTitle();
		String content = festivalVO.getContent();

		title = Tool.convertChar(title); // Ư�� ���� ó��
		content = Tool.convertChar(content);

		festivalVO.setTitle(title);
		festivalVO.setContent(content);

		long size1 = festivalVO.getSize1();
		String size1_label = Tool.unit(size1);
		festivalVO.setSize1_label(size1_label);

		mav.addObject("festivalProc", festivalVO);

		FcateVO fcateVO = this.fcateProc.read(festivalVO.getFcateno());
		mav.addObject("fcateVO", fcateVO);

		return mav;
	}

	/**
	 * �� ���/����/���� �� http://localhost:9093/festival/map.do?contentsno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/map.do", method = RequestMethod.GET)
	public ModelAndView map(int contentsno) {
		ModelAndView mav = new ModelAndView();

		FestivalVO festivalVO = this.festivalProc.read(contentsno); // map ���� �о� ����
		mav.addObject("festivalVO", festivalVO); // request.setAttribute("festivalVO", festivalVO);

		FcateVO fcateVO = this.fcateProc.read(festivalVO.getFcateno()); // �׷� ���� �б�
		mav.addObject("fcateVO", fcateVO);

		mav.setViewName("/festival/map"); // /WEB-INF/views/festival/map.jsp

		return mav;
	}

	/**
	 * MAP ���/����/���� ó�� http://localhost:9093/festival/map.do
	 * 
	 * @param festivalVO
	 * @return
	 */
	@RequestMapping(value = "/festival/map.do", method = RequestMethod.POST)
	public ModelAndView map_update(int contentsno, String map) {
		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("contentsno", contentsno);
		hashMap.put("map", map);

		this.festivalProc.map(hashMap);

		mav.setViewName("redirect:/festival/read.do?contentsno=" + contentsno);
		// /webapp/WEB-INF/views/festival/read.jsp

		return mav;
	}

	/**
	 * Youtube ���/����/���� �� http://localhost:9093/festival/map.do?contentsno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/youtube.do", method = RequestMethod.GET)
	public ModelAndView youtube(int contentsno) {
		ModelAndView mav = new ModelAndView();

		FestivalVO festivalVO = this.festivalProc.read(contentsno); // map ���� �о� ����
		mav.addObject("festivalVO", festivalVO); // request.setAttribute("festivalVO", festivalVO);

		FcateVO fcateVO = this.fcateProc.read(festivalVO.getFcateno()); // �׷� ���� �б�
		mav.addObject("fcateVO", fcateVO);

		mav.setViewName("/festival/youtube"); // /WEB-INF/views/festival/youtube.jsp

		return mav;
	}

	/**
	 * Youtube ���/����/���� ó�� http://localhost:9093/festival/map.do
	 * 
	 * @param contentsno �� ��ȣ
	 * @param youtube    Youtube url�� �ҽ� �ڵ�
	 * @return
	 */
	@RequestMapping(value = "/festival/youtube.do", method = RequestMethod.POST)
	public ModelAndView youtube_update(int contentsno, String youtube) {
		ModelAndView mav = new ModelAndView();

		if (youtube.trim().length() > 0) { // ���� ������ Ȯ��, ������ �ƴϸ� youtube ũ�� ����
			youtube = Tool.youtubeResize(youtube, 640); // youtube ������ ũ�⸦ width ���� 640 px�� ����
		}

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("contentsno", contentsno);
		hashMap.put("youtube", youtube);

		this.festivalProc.youtube(hashMap);

		mav.setViewName("redirect:/festival/read.do?contentsno=" + contentsno);
		// /webapp/WEB-INF/views/festival/read.jsp

		return mav;
	}

	/**
	 * ���� �� http://localhost:9093/festival/update_text.do?contentsno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/update_text.do", method = RequestMethod.GET)
	public ModelAndView update_text(HttpSession session, int contentsno) {
		ModelAndView mav = new ModelAndView();

		if (adminProc.isAdmin(session)) { // �����ڷ� �α����Ѱ��
			FestivalVO festivalVO = this.festivalProc.read(contentsno);
			mav.addObject("festivalVO", festivalVO);

			FcateVO fcateVO = this.fcateProc.read(festivalVO.getFcateno());
			mav.addObject("fcateVO", fcateVO);

			mav.setViewName("/festival/update_text"); // /WEB-INF/views/festival/update_text.jsp
			// String content = "���:\n�ο�:\n�غ�:\n���:\n��Ÿ:\n";
			// mav.addObject("content", content);

		} else {
			mav.addObject("url", "/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp
			mav.setViewName("redirect:/festival/msg.do");
		}

		return mav; // forward
	}

	/**
	 * ���� ó�� http://localhost:9093/festival/update_text.do?contentsno=1
	 * 
	 * @return
	 */
//	@RequestMapping(value = "/festival/update_text.do", method = RequestMethod.POST)
//	public ModelAndView update_text(HttpSession session, FestivalVO festivalVO) {
//		ModelAndView mav = new ModelAndView();
//
//		// System.out.println("-> word: " + festivalVO.getWord());
//
//		if (this.adminProc.isAdmin(session)) { // ������ �α��� Ȯ��
//			HashMap<String, Object> hashMap = new HashMap<String, Object>();
//			hashMap.put("contentsno", festivalVO.getContentsno());
//			hashMap.put("passwd", festivalVO.getPasswd());
//
//			if (this.festivalProc.password_check(hashMap) == 1) { // �н����� ��ġ
//				this.festivalProc.update_text(festivalVO); // �ۼ���
//
//				// mav ��ü �̿�
//				mav.addObject("contentsno", festivalVO.getContentsno());
//				mav.addObject("fcateno", festivalVO.getFcateno());
//				mav.setViewName("redirect:/festival/read.do"); // ������ �ڵ� �̵�
//
//			} else { // �н����� ����ġ
//				mav.addObject("code", "passwd_fail");
//				mav.addObject("cnt", 0);
//				mav.addObject("url", "/festival/msg"); // msg.jsp, redirect parameter ����
//				mav.setViewName("redirect:/festival/msg.do"); // POST -> GET -> JSP ���
//			}
//		} else { // �������� �α����� �ƴ� ��� �α��� ����
//			mav.addObject("url", "/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp
//			mav.setViewName("redirect:/contents/msg.do");
//		}
//
//		mav.addObject("now_page", festivalVO.getNow_page()); // POST -> GET: ������ �н��� �߻������� �ٽ��Ϲ� ������ ���� ��
//
//		// URL�� �Ķ������ ����
//		// mav.setViewName("redirect:/contents/read.do?contentsno=" +
//		// festivalVO.getContentsno() + "&fcateno=" + festivalVO.getFcateno());
//
//		return mav; // forward
//	}

	/**
	 * ���� ���� �� http://localhost:9093/festival/update_file.do?contentsno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/update_file.do", method = RequestMethod.GET)
	public ModelAndView update_file(HttpSession session, int contentsno) {
		ModelAndView mav = new ModelAndView();

		if (adminProc.isAdmin(session)) { // �����ڷ� �α����Ѱ��
			FestivalVO festivalVO = this.festivalProc.read(contentsno);
			mav.addObject("festivalVO", festivalVO);

			FcateVO fcateVO = this.fcateProc.read(festivalVO.getFcateno());
			mav.addObject("fcateVO", fcateVO);

			mav.setViewName("/festival/update_file"); // /WEB-INF/views/festival/update_file.jsp

		} else {
			mav.addObject("url", "/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp
			mav.setViewName("redirect:/festival/msg.do");
		}

		return mav; // forward
	}

	/**
	 * ���� ���� ó�� http://localhost:9093/festival/update_file.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/update_file.do", method = RequestMethod.POST)
	public ModelAndView update_file(HttpSession session, FestivalVO festivalVO) {
		ModelAndView mav = new ModelAndView();

		if (this.adminProc.isAdmin(session)) {
			// ������ ���� ������ �о��, ������ ��ϵ� ���ڵ� �����
			FestivalVO festivalVO_old = festivalProc.read(festivalVO.getContentsno());

			// -------------------------------------------------------------------
			// ���� ���� ����
			// -------------------------------------------------------------------
			String file1saved = festivalVO_old.getFile1saved(); // ���� ����� ���ϸ�
			String thumb1 = festivalVO_old.getThumb1(); // ���� ����� preview �̹��� ���ϸ�
			long size1 = 0;

			String upDir = Festival.getUploadDir(); // C:/kd/deploy/resort_v3sbm3c/festival/storage/

			Tool.deleteFile(upDir, file1saved); // ���� ����� ���ϻ���
			Tool.deleteFile(upDir, thumb1); // preview �̹��� ����
			// -------------------------------------------------------------------
			// ���� ���� ����
			// -------------------------------------------------------------------

			// -------------------------------------------------------------------
			// ���� ���� ����
			// -------------------------------------------------------------------
			String file1 = ""; // ���� ���ϸ� image

			// ���� ������ ��� file1MF ��ü�� ������.
			// <input type='file' class="form-control" name='file1MF' id='file1MF'
			// value='' placeholder="���� ����">
			MultipartFile mf = festivalVO.getFile1MF();

			file1 = mf.getOriginalFilename(); // ���� ���ϸ�
			size1 = mf.getSize(); // ���� ũ��

			if (size1 > 0) { // ������ ���Ӱ� �ø��� ������ �ִ��� ���� ũ��� üũ ��
				// ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
				file1saved = Upload.saveFileSpring(mf, upDir);

				if (Tool.isImage(file1saved)) { // �̹������� �˻�
					// thumb �̹��� ������ ���ϸ� ���ϵ�, width: 250, height: 200
					thumb1 = Tool.preview(upDir, file1saved, 250, 200);
				}

			} else { // ������ ������ �ǰ� ���� �ø��� �ʴ� ���
				file1 = "";
				file1saved = "";
				thumb1 = "";
				size1 = 0;
			}

			festivalVO.setFile1(file1);
			festivalVO.setFile1saved(file1saved);
			festivalVO.setThumb1(thumb1);
			festivalVO.setSize1(size1);
			// -------------------------------------------------------------------
			// ���� ���� �ڵ� ����
			// -------------------------------------------------------------------

			this.festivalProc.update_file(festivalVO); // Oracle ó��

			mav.addObject("contentsno", festivalVO.getContentsno());
			mav.addObject("fcateno", festivalVO.getFcateno());
			mav.setViewName("redirect:/festival/read.do"); // request -> param���� ���� ��ȯ

		} else {
			mav.addObject("url", "/admin/login_need"); // login_need.jsp, redirect parameter ����
			mav.setViewName("redirect:/festival/msg.do"); // GET
		}

		// redirect�ϰԵǸ� ���� �����Ͱ� ���������� mav ��ü�� �ٽ� ����
		mav.addObject("now_page", festivalVO.getNow_page());

		return mav; // forward
	}

	/**
	 * ���� ���� �� http://localhost:9093/festival/delete.do?contentsno=1
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/delete.do", method = RequestMethod.GET)
	public ModelAndView delete(HttpSession session, int contentsno) {
		ModelAndView mav = new ModelAndView();

		if (adminProc.isAdmin(session)) { // �����ڷ� �α����Ѱ��
			FestivalVO festivalVO = this.festivalProc.read(contentsno);
			mav.addObject("festivalVO", festivalVO);

			FcateVO fcateVO = this.fcateProc.read(festivalVO.getFcateno());
			mav.addObject("fcateVO", fcateVO);

			mav.setViewName("/contents/delete"); // /WEB-INF/views/contents/delete.jsp

		} else {
			mav.addObject("url", "/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp
			mav.setViewName("redirect:/festival/msg.do");
		}

		return mav; // forward
	}

	/**
	 * ���� ó�� http://localhost:9093/festival/delete.do
	 * 
	 * @return
	 */
	@RequestMapping(value = "/festival/delete.do", method = RequestMethod.POST)
	public ModelAndView delete(FestivalVO festivalVO) {
		ModelAndView mav = new ModelAndView();

		// -------------------------------------------------------------------
		// ���� ���� ����
		// -------------------------------------------------------------------
		// ������ ���� ������ �о��.
		FestivalVO festivalVO_read = festivalProc.read(festivalVO.getContentsno());

		String file1saved = festivalVO.getFile1saved();
		String thumb1 = festivalVO.getThumb1();

		String uploadDir = Festival.getUploadDir();
		Tool.deleteFile(uploadDir, file1saved); // ���� ����� ���ϻ���
		Tool.deleteFile(uploadDir, thumb1); // preview �̹��� ����
		// -------------------------------------------------------------------
		// ���� ���� ����
		// -------------------------------------------------------------------

		this.festivalProc.delete(festivalVO.getContentsno()); // DBMS ����

		// -------------------------------------------------------------------------------------
		// ������ �������� ������ ���ڵ� �������� ������ ��ȣ -1 ó��
		// -------------------------------------------------------------------------------------
		// ������ �������� ������ 10��° ���ڵ带 ������
		// �ϳ��� �������� 3���� ���ڵ�� �����Ǵ� ��� ���� 9���� ���ڵ尡 ���� ������
		// ���������� 4 -> 3���� ���� ���Ѿ���, ������ �������� ������ ���ڵ� ������ �������� 0 �߻�
		int now_page = festivalVO.getNow_page();

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("fcateno", festivalVO.getFcateno());
		hashMap.put("word", festivalVO.getWord());

		if (festivalProc.search_count(hashMap) % Festival.RECORD_PER_PAGE == 0) {
			now_page = now_page - 1; // ������ DBMS�� �ٷ� ����ǳ� ũ���� ���ΰ�ħ���� �ʿ�� �ܰ谡 �۵� �ؾ���.
			if (now_page < 1) {
				now_page = 1; // ���� ������
			}
		}
		// -------------------------------------------------------------------------------------

		mav.addObject("fcateno", festivalVO.getFcateno());
		mav.addObject("now_page", now_page);
		mav.setViewName("redirect:/festival/list_by_fcateno.do");

		return mav;
	}

	// http://localhost:9093/festival/delete_by_fcateno.do?fcateno=1
	// ���� ���� -> ���ڵ� ����
	@RequestMapping(value = "/festival/delete_by_fcateno.do", method = RequestMethod.GET)
	public String delete_by_fcateno(int fcateno) {
		ArrayList<FestivalVO> list = this.festivalProc.list_by_fcateno(fcateno);

		for (FestivalVO festivalVO : list) {
			// -------------------------------------------------------------------
			// ���� ���� ����
			// -------------------------------------------------------------------
			String file1saved = festivalVO.getFile1saved();
			String thumb1 = festivalVO.getThumb1();

			String uploadDir = Festival.getUploadDir();
			Tool.deleteFile(uploadDir, file1saved); // ���� ����� ���ϻ���
			Tool.deleteFile(uploadDir, thumb1); // preview �̹��� ����
			// -------------------------------------------------------------------
			// ���� ���� ����
			// -------------------------------------------------------------------
		}

		int cnt = this.festivalProc.delete_by_fcateno(fcateno);
		System.out.println("-> count: " + cnt);

		return "";

	}

}
