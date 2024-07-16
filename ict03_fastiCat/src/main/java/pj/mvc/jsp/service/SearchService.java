package pj.mvc.jsp.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface SearchService {
	// 게시글 목록
	public void boardListAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException;

	
    // 상세페이지
	public void searchDetailAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException;
}