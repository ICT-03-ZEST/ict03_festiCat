<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/setting.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="/FastiCat/resources/css/header.css">
</head>
<body>
	<!-- header 시작 -->
	<nav class="navbar">
		<a href="${path }/common/main.jsp"><img
			src="${path }/resources/images/festicat.PNG" width="155px"
			height="50px" id="festicat"></a>
		<ul class="navbar_menu">
			<li><a href="#">국내 이벤트</a>
				<ul class="submenu">
					<li><a href="#">국내공연</a></li>
					<li><a href="#">국내 페스티벌</a></li>
				</ul></li>
			<li><a href="#">장르 별 인기순위</a></li>
			<li><a href="#">게시판</a>
				<ul class="submenu">
					<li><a href="#">공연후기</a></li>
					<li><a href="#">자유게시판</a></li>
					<li><a href="#">공지사항 게시판</a></li>
				</ul>
		</ul>

		<ul id="navbar_icons">
			<li><a href="main.html"><i class="fa-brands fa-twitter"></i></a></li>
			<li><a href="main.html"><i class="fa-brands fa-facebook"></i></a></li>
			<li><a href="${path}/login.do">LOGIN</a></li>
			<li><a href="${path}/join.do">JOIN</a></li>
			<input id="searchInput" class="inputButton" type="search"
				placeholder="" aria-label="Search">
			<input class="inputButton" type="button" value="search"
				; onclick="window.location='${path }/search.sc'">
			<li><a href="${path }/myPage.do"><i
					class="fa-solid fa-user">myPage</i></a></li>
		</ul>
		<!-- 반응형 웹 - (1). 햄버거 아이콘 fontawesome - free - bars -->
		<a href="#" class="navbar_toggleBtn"> <i class="fa-solid fa-bars"></i>
		</a>
	</nav>
	<!-- header 끝 -->
</body>
</html>