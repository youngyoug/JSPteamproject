<%@page import="java.io.Console"%>
<%@page import="user.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 헤더 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<link rel="stylesheet" href="style.css">






<!-- 글목록css -->
<style>
#wrapper2 {
background-color: #EBEDF3;
}
body{
	padding-top:87px;
	
}
a {
	color: black;
	text-decoration: none;
}

#content {
margin-top : 0px;
position: relative
}


/* #wrapper{
	position: relative;
} */

#page {
	width: 140px;
	bottom: -60px;
	height: 50px;
	left: 300px;
	background: red;
	position: absolute;
	overflow: hidden;
	display: inline;
}
#pageBtn {

	width: 1000px;
	position: absolute;
	margin-left: -10px;
	

}
#pgNumber {
	border: 1px solid gray;


}

#before {
	border: 1px solid gray;
	width: 50px;
	bottom: -40px;
	height: 30px;
	left: 240px;
	position: absolute;
}

#next {
	border: 1px solid gray;
	width: 50px;
	bottom: -40px;
	height: 30px;
	left: 450px;
	position: absolute;
}

</style>

</head>


<body>
	<%
		String userID = null;
		int loginStudentNum = 0;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			loginStudentNum = (int) session.getAttribute("studentNum");
		}
		if(session.getAttribute("postNum") != null){
			int postNum = (int)session.getAttribute("postNum");
			session.removeAttribute("postNum");
		}
		//게시판 
		String postBoard = request.getParameter("board");
		System.out.println("ㅎㅎ"+postBoard);
		System.out.println("ㅋㅋ");
		
	%>
	<!-- 헤더 -->
	<header class="p-3 text-bg-dark"
		style="position: fixed; top: 0; width: 100%; z-index: 1; background-color: white !important; border-bottom: 1px solid gray;">
		<div class="container">
			<div class="row">
				<div
					class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
					<a href="/"
						class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none"></a>

					<ul
						class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0"
						style="align-items: center;">
						<li><a href="main.jsp"><img src="image/shelter.png"></a></li>
						<li><a href="#" class="nav-link px-2 text-secondary">인기글</a></li>
						<li><a href="anolist.jsp?board=ano"
							class="nav-link px-2 text-secondary">익명 게시판</a></li>
						<li><a href="anolist.jsp?board=mustGo"
							class="nav-link px-2 text-secondary">맛집 게시판</a></li>
						<li><a href="myPage.jsp"
							class="nav-link px-2 text-secondary fw-semibold">My Page</a></li>
					</ul>
					<%--검색 --%>
					<form method="post" action="searchedList.jsp"
						class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
						<input type="search"
							class="form-control form-control-dark text-bg-white"
							placeholder="Search..." aria-label="Search" name="searchWord">
					</form>

					<%
				if(userID == null){
			%>
					<div class="text-end">
						<button type="button" class="btn btn-outline-dark me-2"
							role="button" aria-haspopup="true" aria-expanded="false">
							<a href="login.jsp">로그인</a>
						</button>
						<button type="button" class="btn btn-warning" role="button"
							aria-haspopup="true" aria-expanded="false">
							<a href="join.jsp" id="sign-color">회원 가입</a>
						</button>
					</div>
					<%
				} else {
			%>
					<div class="text-end">
						<button type="button" class="btn btn-outline-light me-2"
							role="button" aria-haspopup="true" aria-expanded="false">
							<a href="logoutAction.jsp">LogOut</a>
						</button>

					</div>
					<%		
				}
			%>

				</div>
			</div>
		</div>
	</header>






	<!-- 글목록 부분 -->
	<%
		//페이지 누르면 값 가져오기

		String postpg = request.getParameter("postpage");
	    //String postbo = request.getParameter("board");
	    //System.out.println("안ㄴ"+postpg+postbo);
		if (postpg == null) {
			postpg = "1";
		}
		int postpage = Integer.parseInt(postpg);
		//1->0 ; 2-> 10
		int index_no = (postpage - 1) * 10;

		//DB연결, post테이블정보 담은 리스트
		Dao dao = Dao.getInstance();
		List<Post> postlist = null;
		int totalPost = 0;
		int lastPostpage = 0;
		String board = null;
		if(postBoard.equals("ano")){
			postlist = dao.selectPostAll(index_no);
			board = "익명게시판";
			//총 게시물 개수
			totalPost = dao.countPostAll(board);
			lastPostpage = (int) Math.ceil((double) totalPost / 10);
		}else if (postBoard.equals("mustGo")){
			postlist = dao.selectFoodPostAll(index_no);
			board = "맛집게시판";
			//총 게시물 개수
			totalPost = dao.countPostAll(board);
			lastPostpage = (int) Math.ceil((double) totalPost / 10);
		}
	%>
	<div class="container-fluid" id="wrapper2">
	<div id="wrapper">
		<section id="content" style="background-color:white">
			<ul>
				<%
					for (int i = 0; i<postlist.size(); i++) {
						Post p = postlist.get(i);
						
				%>
				<li>
					<article>
						<div id="profile">
						<%
						if(postBoard.equals("ano")){%>
						
							<img src="image/blankProfile.jpg" alt="프로필사진">
							<div id="ano">익명</div>

						<%}else if (postBoard.equals("mustGo")){%>
						
							<img src="image/blankProfile.jpg" alt="프로필사진">
							<div id="ano"></div>
							
						<%
						}
						%>
							
							<div id="date"><%=p.getDate()%></div>
						</div>
						<h1>
							<a href="view.jsp?postNum=<%=p.getPostNum()%>">
								<%=p.getTitle()%></a>
						</h1>
						<p>
							<a href="view.jsp?postNum=<%=postlist.get(i).getPostNum()%>">
								<%=p.getContent()%></a>
						</p>
						<div id="like-comment">
							<span id="like"> <%
 	int likeOnOff = dao.LikeOnOff(postlist.get(i).getPostNum(), loginStudentNum);
 		int countLike = dao.countLikePost(postlist.get(i).getPostNum());
 		int countComment = dao.countCommentPost(postlist.get(i).getPostNum());

 		if (likeOnOff == 0) {
 %> <img src="image/OFF.png" alt="좋아요 수">
								<%=countLike%> <%
 	} else {
 %> <img src="image/ON.png" alt="좋아요 수">
								<%=countLike%> <%
 	}
 %>
							</span> <span id="comment"> <img src="image/icon_comment.png"
								alt="댓글 수"> <%=countComment%>
							</span>
						</div>
					</article>
				</li>
				<%
					}
				%>

			</ul>
		


		<!-- 페이징 -->
		
		<div id="page">
		
			<label id="pageBtn">
				<%
					//페이징
					for (int i = 1; i <= lastPostpage; i++) {
						//out.print("<a href='anolist2.jsp?postpage= "+i+"'>"+i+"</a> ");
						//위에처럼 해도 되고 아래처럼 해도 된다 - postpage 값 전달 되도록
				%>
				<button id="pgNumber">
					<a href="anolist.jsp?board=<%=postBoard%>&postpage=<%=i%>"><%=i%></a>
				</button>
				<%
					}
				%>
				</label>
		</div>
		<button id="before">이전</button>
		<button id="next" onclick="next()">다음</button>
		</section>
	</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>

	
	</script>
</body>

</html>