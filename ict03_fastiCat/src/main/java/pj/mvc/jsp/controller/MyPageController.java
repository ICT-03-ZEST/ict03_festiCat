package pj.mvc.jsp.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pj.mvc.jsp.service.MyPageService;
import pj.mvc.jsp.service.MyPageServiceImpl;
//회원이 공연/페스티벌 후기 및 자유 게시판 및 댓글을 작성,수정,삭제,조회
// @WebServlet("*.do")
public class MyPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MyPageController() {
        super();
    }
    //1단계. 웹 브라우저가 전송한 HTTP 요청을 받음 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		action(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}
	
	public void action(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		//2단계. 클라이언트 요청 분석
		request.setCharacterEncoding("UTF-8");
		
		String viewPage = "";
		
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String url = uri.substring(contextPath.length());
		
		MyPageService service = new MyPageServiceImpl();
		
		//test(테스트용 세션 아이디 미리 설정)
		request.getSession().setAttribute("sessionID", "test");
		
		// 1.게시판 목록조회 - 공연후기, 페스티벌후기, 자유 메뉴 선택시 해당 목록 전체조회(최신글 부터)
		// test(링크 수정필요)
		if(url.equals("/mypage.do")) {
			System.out.println("<url --> /mypage.do>");
			viewPage = "customer/mypage/myPage.jsp";
		}
		
		// 나의 게시물 목록
		else if (url.equals("/myBoardList.do")) {
			System.out.println("<url --> /myBoardList.do>");
	          
			// 서비스 -> DAO(SELECT)
       	 	service.boardListAction(request, response);
  		
       	 	viewPage= "customer/mypage/myBoardList.jsp";
		} 
		
		// 나의 예매 내역
		else if (url.equals("/myTicketDetail.do")) {
			System.out.println("<url --> /myTicketDetail.do>");
			
			viewPage = "customer/mypage/myTicketDetail.jsp";
		} else if (url.equals("/join.do")) {
			System.out.println("<<< url ==> /join.do >>>");
			
			viewPage = "views/join.jsp";
		} 
		
		// [회원수정 ]	
		// 회원수정 인증
		else if(url.equals("/modifyPwdChk.do")) {
			System.out.println("<<< url ==> /modifyDetailAction.do >>>");
			
			service.modifyPwdChk(request, response);
			
			viewPage = "customer/mypage/modify.jsp";
		}
		
		// 회원수정 처리 페이지
		else if(url.equals("/modifyUserAction.do")) {
			System.out.println("<<< url ==> /modifyUserAction.do >>>");
			
			service.modifyUserAction(request, response);
			
			viewPage = "customer/mypage/modifyAction.jsp";
		}
		
		// [회원탈퇴]
		// 회원탈퇴 인증
		else if(url.equals("/deletePwdChk.do")) {
			System.out.println("<<< url ==> /deletePwdChk.do >>>");
			
			service.deletePwdChk(request, response);
			
			viewPage = "customer/mypage/delete.jsp";
		}
		
		// 회원탈퇴 처리 페이지
		else if(url.equals("/deleteUserAction.do")) {
			System.out.println("<<< url ==> /deleteUserAction.do >>>");
			
			service.deleteUserAction(request, response);
			
			viewPage = "customer/mypage/modify.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}