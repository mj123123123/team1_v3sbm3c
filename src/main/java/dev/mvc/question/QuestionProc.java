package dev.mvc.question;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.question.QuestionProc")
public class QuestionProc implements QuestionProcInter {
  @Autowired
  private QuestionDAOInter questionDAO;

  @Override
  public int create(QuestionVO questionVO) {
    int cnt = this.questionDAO.create(questionVO);
    return cnt;
  }

  @Override
  public ArrayList<QuestionVO> list_all() {
    ArrayList<QuestionVO> list = this.questionDAO.list_all();
    return list;
  }

  @Override
  public ArrayList<QuestionVO> list_by_tcateno(int tcateno) {
    ArrayList<QuestionVO> list = this.questionDAO.list_by_tcateno(tcateno);
    return list;
  }

  @Override
  public ArrayList<QuestionVO> list_by_memberno(int memberno) {
    ArrayList<QuestionVO> list = this.questionDAO.list_by_memberno(memberno);
    return list;
  }

  @Override
  public ArrayList<QuestionVO> list_by_tcateno_search(HashMap<String, Object> hashMap) {
    ArrayList<QuestionVO> list = this.questionDAO.list_by_tcateno_search(hashMap);
    return list;
  }

  @Override
  public int search_count(HashMap<String, Object> hashMap) {
    int cnt = this.questionDAO.search_count(hashMap);
    return cnt;
  }

  @Override
  public ArrayList<QuestionVO> list_by_tcateno_search_paging(QuestionVO questionVO) {
    int begin_of_page = (questionVO.getNow_page() - 1) * Questions.RECORD_PER_PAGE;
    int start_num = begin_of_page + 1;
    int end_num = begin_of_page + Questions.RECORD_PER_PAGE;   
    
    questionVO.setStart_num(start_num);
    questionVO.setEnd_num(end_num);
    
    ArrayList<QuestionVO> list = this.questionDAO.list_by_tcateno_search_paging(questionVO);
    return list;
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param tcateno 카테고리번호 
   * @param now_page  현재 페이지
   * @param search_count 검색 레코드수    
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String pagingBox(int tcateno, int now_page, String list_file, int search_count){
    
    // 전체 페이지 수: (double)1/10 -> 0.1 -> 1 페이지, (double)12/10 -> 1.2 페이지 -> 2 페이지
    int total_page = (int)(Math.ceil((double)search_count / Questions.RECORD_PER_PAGE));
    // 전체 그룹  수: (double)1/10 -> 0.1 -> 1 그룹, (double)12/10 -> 1.2 그룹-> 2 그룹
    int total_grp = (int)(Math.ceil((double)total_page / Questions.PAGE_PER_BLOCK)); 
    // 현재 그룹 번호: (double)13/10 -> 1.3 -> 2 그룹
    int now_grp = (int)(Math.ceil((double)now_page / Questions.PAGE_PER_BLOCK));  
    
    // 1 group: 1, 2, 3 ... 9, 10
    // 2 group: 11, 12 ... 19, 20
    // 3 group: 21, 22 ... 29, 30
    int start_page = ((now_grp - 1) * Questions.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작  페이지  
    int end_page = (now_grp * Questions.PAGE_PER_BLOCK);               // 특정 그룹의 마지막 페이지   
     
    StringBuffer str = new StringBuffer(); // String class 보다 문자열 추가등의 편집시 속도가 빠름 
    
    // style이 java 파일에 명시되는 경우는 로직에 따라 css가 영향을 많이 받는 경우에 사용하는 방법
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
 
    // 이전 10개 페이지로 이동
    // now_grp: 1 (1 ~ 10 page)
    // now_grp: 2 (11 ~ 20 page)
    // now_grp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 마지막 페이지 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 마지막 페이지 20
    int _now_page = (now_grp - 1) * Questions.PAGE_PER_BLOCK;  
    if (now_grp >= 2){ // 현재 그룹번호가 2이상이면 페이지수가 11페이지 이상임으로 이전 그룹으로 갈수 있는 링크 생성 
      str.append("<span class='span_box_1'><A href='"+list_file+"&now_page="+_now_page+"&tcateno="+tcateno+"'>이전</A></span>"); 
    } 
 
    // 중앙의 페이지 목록
    for(int i=start_page; i<=end_page; i++){ 
      if (i > total_page){ // 마지막 페이지를 넘어갔다면 페이 출력 종료
        break; 
      } 
  
      if (now_page == i){ // 목록에 출력하는 페이지가 현재페이지와 같다면 CSS 강조(차별을 둠)
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지는 이동이 가능하도록 링크를 설정
        str.append("<span class='span_box_1'><A href='"+list_file+"&now_page="+_now_page+"&tcateno="+tcateno+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 페이지 5일경우 -> 현재 1그룹: (1 * 10) + 1 = 2그룹의 시작페이지 11
    // 현재 페이지 15일경우 -> 현재 2그룹: (2 * 10) + 1 = 3그룹의 시작페이지 21
    // 현재 페이지 25일경우 -> 현재 3그룹: (3 * 10) + 1 = 4그룹의 시작페이지 31
    _now_page = (now_grp * Questions.PAGE_PER_BLOCK)+1; //  최대 페이지수 + 1 
    if (now_grp < total_grp){ 
      str.append("<span class='span_box_1'><A href='"+list_file+"&now_page="+_now_page+"&tcateno="+tcateno+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }

  @Override
  public QuestionVO read(int questno) {
    QuestionVO questionVO = this.questionDAO.read(questno);
    return questionVO;
  }

  @Override
  public int delete(int questno) {
    int cnt = this.questionDAO.delete(questno);
    return cnt;
  }
  
  @Override
  public int delete_by_tcateno(int tcateno) {
    int cnt = this.questionDAO.delete_by_tcateno(tcateno);
    return cnt;
  }

  @Override
  public int update_quest(QuestionVO questionVO) {
    int cnt = this.questionDAO.update_quest(questionVO);
    return cnt;
  }

}
