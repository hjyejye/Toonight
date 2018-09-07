<%@page import="webtoon.WebtoonManager"%>
<%@page import="webtoon.WebtoonDTO"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
   String number = request.getParameter("number");
    Class.forName("com.mysql.jdbc.Driver");
  
   int webtoonID = Integer.parseInt(number);
   String currentUser = (String) session.getAttribute("userID");
   try {
      Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/toonight", "root", "1234");
      Statement stmt = conn.createStatement();
      String sql="select webtoonTitle, webtoonPoster,webtoonUrl from webtoon where webtoonID="+webtoonID;
      ResultSet result=stmt.executeQuery(sql);
      while(result.next()){
         String title=result.getString(1);
         String poster=result.getString(2);      
         String url=result.getString(3);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title><%=title%> 상세정보</title>
	<meta name="description" content="This is a free Bootstrap landing page theme created for BootstrapZero. Feature video background and one page design." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../css/animate.min.css" />
    <link rel="stylesheet" href="../css/ionicons.min.css" />
    <link rel="stylesheet" href="../css/styles.css" />
</head>
   
<body>
	<nav id="topNav" class="navbar navbar-default navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                
                <a class="navbar-brand page-scroll" href="../Main.jsp">TOONIGHT</a>
            </div>
            <div class="navbar-collapse collapse" id="bs-navbar">
            	<ul class="nav navbar-nav navbar-right">
            	<%
                  String id = (String) session.getAttribute("userID");
                  if (id == null) {
               	%>
                    <li>
                        <a class="page-scroll" href="../User/SignUp.jsp" >회원가입</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="../User/Login.jsp">로그인</a>
                    </li>
                    <%
                  } else {
               %>
                    <li>
                        <a class="page-scroll"  href="../Webtoon/List.jsp">웹툰</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="../User/MyPage.jsp">마이페이지</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="../User/Logout.jsp">로그아웃</a>
                    </li>
                     <%
                  }
               %> 
                </ul>              
            </div>
        </div>
    </nav>

	<section id="one" class="" style="text-align:center; padding-left:20%; padding-right:20%">
		<!-- 웹툰 포스터, 제목, 감정/별점, 좋아요, iframe까지 -->
		<div class="detail_content" style="clear:both">
         <!-- 웹툰 포스터 -->
         	<img alt="" src="<%=poster%>" class="rounded mx-auto d-block" alt="webtoonthumb">
		<!-- 웹툰 제목 -->
        	<h2 style="text-align:center"><a href="https://comic.naver.com/<%=url %>" class="webtoon_title webtoon_url"><%=title%></a></h2><br>
            <div class="btn_wrap" style="text-align:center;">
               <!-- 감정/별점 통계 목록 -->
               <a href="Info.jsp" target="iframe1" class="btn btn-dark webtoon_url">감정/별점목록</a>   
               <!-- 감정/별점 등록 버튼 -->
               <a href="Feeling.jsp" target="iframe1" class="btn btn-dark webtoon_url">감정/별점등록</a>   
               <!-- 좋아요 버튼 -->             
            <%
               }
             String sql1="select count(*) from wishlist where userID= "+currentUser+" and webtoonID= "+webtoonID;
             ResultSet rs1=stmt.executeQuery(sql1);
             while (rs1.next()){
                int count=rs1.getInt(1);
                System.out.println(count);
                if(count==0){
            %>             
               <a href="Like.jsp" class="btn btn-dark webtoon_url" >좋아요 </a>                
             <%             
                }
                else{
             %>   
               <a href="Dislike.jsp" class="btn btn-dark webtoon_url">좋아요 취소</a>
             <%
                }                
             }
             
            %>
                
         </div><br>
          <!--iframe -->
          <div style="text-align:center;">
          	<!-- 웹툰 감정 차트,소개 페이지 / 감정, 별점 선택 페이지 -->
			<iframe src = "Info.jsp" name="iframe1" width="80%" height="450" frameborder="0"></iframe>
          </div>
       </div>
       </section><br>
       <p style="text-align:center;"> Review </p>
        <form action="Comment.jsp" method="POST" style="text-align: center;">
      		<input type="text" class="form-control" name="input_comment" placeholder="comment" style="width: 30em; height: 1.8em; display: inline;">
      		<button type="submit" class="btn btn-secondary btn-sm">등록</button>
   		</form><hr>
   		<section id="one" class="" style="text-align:center; padding-left:20%; padding-right:20%">
   <%
               String sql4 = "select commentID, userID, content from comment where webtoonID=" + webtoonID;
                  ResultSet rs = stmt.executeQuery(sql4);
                  while (rs.next()) {
                     int commentID = rs.getInt(1);
                     String userID = rs.getString(2);
                     String content = rs.getString(3);
                     String cid = Integer.toString(commentID);
                     if (userID != null) {
   %>
   		<table>
            <tr height="25" align="center">
               <td>&nbsp;</td>
               <td><%=userID%>:</td>
               <td align="left"><%=content%></td>
               <%
                  if (currentUser != null) {
                              if (currentUser.equals(userID)) {
               %>
               <td align="left">
                  <form action=CommentDelete.jsp method="POST">
                     <button type="submit" class="btn btn-secondary btn-sm" style="float: right;" formmethod="POST" data-confirm="댓글을 삭제합니다">delete</button>
                  </form></td>
               <%
                  response.addCookie(new Cookie("commentID", cid));
               %>
               <%
                  }
                           }
               %>
            </tr>
            <tr height="1" bgcolor="#D2D2D2">
               <td colspan="6"></td>
            </tr>
        </table>
            <br>
            <hr>
            <%
               }
                  }
                  String id = Integer.toString(webtoonID);
                  response.addCookie(new Cookie("webtoonID", id));
                  rs.close();
                  stmt.close();
                  conn.close();
                  response.addCookie(new Cookie("number",number));
               } catch (SQLException e) {
               }
            %>
</section>
                <!--scripts loaded here -->
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery.easing.min.js"></script>
    <script src="../js/wow.js"></script>
    <script src="../js/scripts.js"></script>
   </body>
</html>