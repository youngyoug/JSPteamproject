<%@page import="java.io.File"%>
<%@page import="user.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); //한글깨짐 방지
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%--부트스트랩 cdn --%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">

<!-- 글목록css -->
<style>
#wrapper {
	border: 1px solid rgb(243, 242, 242);
	max-width: 800px; /*800이하 시 줄어듦*/
	height: 100%;
	margin: 0 auto;
	padding: 0 auto;
}

#userInfo {
	/*border: 1px solid blue;*/
	max-width: 800px;
	background-color: rgb(243, 242, 242);
	padding: 20px;
	height: 300px;
	
}

#img{
	width: 150px;
	height: 150px;
	margin: 10px auto;
	display: block;
	object-fit: cover; /*이미지의 종횡비를 유지하면서 박스를가득채움.*/
}

#userInfo div {
	margin: 5px auto;
	text-align: center;
}

#userInfo div a {
	text-decoration-line: none;
}

#userID a {
	color: black;
	font-weight: bold;
	
}
#nickName a, #studentNum a {
	color: grey;
}

/*여기서부터 안건듦*/
#content {
	border: 2px solid #bddbd2;
	max-width: 800px;
	padding: 0;
	padding:0 auto;
	
	
}
#myPageList {
	display: flex;
	margin: 0 auto;
	
}
#myPageList div{
	display: inline-block;
	width: 35%;
	text-align: center;
}
#myPageList button{
	width: 100%;
	/*border: 1px solid #333;*/
	border: 1px solid #bddbd2;
	
}

#content ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

#content li {
	/* border: 1px solid red; */
	margin-top: 10px;
	padding: 5px;
	background-color: rgb(243, 242, 242);
	overflow: hidden;
}

#content article {
	height: 100px;
}

#content a {
	color: black;
	text-decoration: none;
}

#profile {
	/* border: 1px solid black; */
	height: 25px;
	margin: 3px 0;
	position: relative;
}

#profile img {
	width: 25px;
	height: 25px;
}

#profile #ano {
	/* border: 1px solid blue; */
	position: absolute;
	margin: 0;
	margin-left: 5px;
	padding: 0;
	display: inline-block;
	height: 25px;
	line-height: 25px;
}

#profile #date {
	/* border: 1px solid blue; */
	position: absolute;
	margin: 0;
	margin-left: 50px;
	padding: 0;
	display: inline-block;
	height: 25px;
	line-height: 25px;
	color: grey;
}

#content h1 {
	/* border: 1px solid blue; */
	font-size: 25px;
	margin-top: 10px;
	margin-bottom: 0px;
	padding: 0;
	display: block;
	max-width: 800px;
	white-space: nowrap; /*여러줄을 한줄로*/
	overflow: hidden; /*넘치는 글 숨김*/
	text-overflow: ellipsis; /*...*/
}

#content p {
	/* border: 1px solid black; */
	font-size: 15px;
	margin: 0;
	/*padding-top: 10px;
padding-bottom: 10px;*/
	padding: 0;
	height: 25px;
	display: block;
	max-width: 800px;
	white-space: nowrap; /*여러줄을 한줄로*/
	overflow: hidden; /*넘치는 글 숨김*/
	text-overflow: ellipsis; /*...*/
}

#like-comment {
	float: right; /*오른쪽 정렬*/
	font-size: 15px;
	height: 15px;
	margin: 3px;
}

#like-comment img {
	width: 15px;
	height: 15px;
}

#like {
	color: #FF0000;
}

#comment {
	color: #0055FF;
}
</style>

</head>

<body>
<%
	String userID = null;
	int studentNum = 0;
	if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
	studentNum = (int) session.getAttribute("studentNum");
	}

	Dao dao = Dao.getInstance();
	
//임의로 studentNum 정함.
	User user = dao.selectUserOne(studentNum);
	
%>
	
	<div id="wrapper">
	<form action="profimgAction.jsp" method="post" enctype="multipart/form-data" name="signform">
		<div id="userInfo">
		<%
		//프로필 사진(경로에 사진 없으면 기본이미지)
			String real = "C:\\JavaProgramming\\source\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\team0110\\image";
			File viewImg = new File(real+"\\"+studentNum+"프로필사진.jpg");
			if(viewImg.exists()){
		%>
			<img id="img" src="image/<%=studentNum %>프로필사진.jpg" alt="프로필사진" onclick="clickBtn()" class="rounded">
			<%} else { %>
				<img id="img" src="image/blankProfile.jpg" alt="프로필사진" onclick="clickBtn()" class="rounded">
			<%} %>
			<input type="file" name="fileName" id="profimg" style="display: none;" onchange="changeValue(this)" />
				<input type="hidden" name = "target_url">
			
			<div id="userID"><a href="myinfoUpdate.jsp?studentNum=<%=user.getStudentNum() %>"><%=user.getUserID() %></a></div>
			<div id="nickName"><a href="myinfoUpdate.jsp?studentNum=<%=user.getStudentNum() %>">닉네임: <%=user.getNickName() %></a></div>
			<div id="studentNum"><a href="myinfoUpdate.jsp?studentNum=<%=user.getStudentNum() %>">학번: <%=user.getStudentNum() %></a></div>
		</div>
	</form>
	
	
		<section id="content">
			
			<div id="myPageList" class="btn-group" role="group" aria-label="Basic radio toggle button group">
				<div>
					<button id="exePost" class="bg-success p-2 text-dark bg-opacity-25">내가 쓴 글</button>
				</div>
				<div>
					<button id="exeComment" class="bg-success p-2 text-dark bg-opacity-25">댓글 단 글</button>
				</div>
				<div>
					<button id="exeLike" class="bg-success p-2 text-dark bg-opacity-25">좋아요 한 글</button>
				</div>
			</div>
			<div id="showList"></div>

		</section>
	</div>


	<script src="https://code.jquery.com/jquery-3.0.0.min.js"></script>
	
	<%--프로필사진 클릭 이벤트 --%>
	<script>
		function clickBtn() {
			$('#profileAction').submit();
		}
		$("#img").click(function(e){
			document.signform.target_url.value = document.getElementById('img').src;
			e.preventDefault();
			$("#profimg").click();
		});
		
		function changeValue(obj) {
			document.signform.submit();
		}
	</script>
	
	<%--버튼 클릭 이벤트 --%>
	<script>
		$(function() {
			$("#exePost").click(function() {
				$.ajax({
					url : 'myPost.jsp',
					success : function(x) {
						$('#showList').html(x);
					}
				})
			});
			$("#exeComment").click(function() {
				$.ajax({
					url : 'myComment.jsp',
					success : function(x) {
						$('#showList').html(x);
					}
				})
			});
			$("#exeLike").click(function() {
				$.ajax({
					url : 'myLike.jsp',
					success : function(x) {
						$('#showList').html(x);
					}
				})
			});
		});
	</script>
</body>

</html>