<%@page import="webtoon.WebtoonManager"%>
<%@page import="webtoon.WebtoonDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
Class.forName("com.mysql.jdbc.Driver");
request.setCharacterEncoding("euc-kr");
   List<WebtoonDTO> list1 = WebtoonManager.webtoonNaverData();
    request.setAttribute("list1", list1);
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/toonight", "root", "1234");
 
    Statement stmt=conn.createStatement();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>네이버 웹툰</title>
    <meta name="description" content="This is a free Bootstrap landing page theme created for BootstrapZero. Feature video background and one page design." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../css/animate.min.css" />
    <link rel="stylesheet" href="../css/ionicons.min.css" />
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="stylesheet" href="../css/search.css" />
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
                
                <a class="navbar-brand page-scroll" href="../Main.jsp" style="color:#EAEAEA;">TOONIGHT</a>
            </div>
            <div class="navbar-collapse collapse" id="bs-navbar">
            	<ul class="nav navbar-nav navbar-right">
            	<%
                  String id = (String) session.getAttribute("userID");
                  if (id == null) {
               	%>
                    <li>
                        <a class="page-scroll" href="../User/SignUp.jsp" style="color:#EAEAEA;">회원가입</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="../User/Login.jsp" style="color:#EAEAEA;">로그인</a>
                    </li>
                    <%
                  } else {
               %>
                    <li>
                        <a class="page-scroll"  href="../Webtoon/List.jsp" style="color:#EAEAEA;">웹툰</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="../User/MyPage.jsp" style="color:#EAEAEA;">마이페이지</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="../User/Logout.jsp" style="color:#EAEAEA;">로그아웃</a>
                    </li>
                     <%
                  }
               %> 
                </ul>
                
            </div>
        </div>
    </nav>
	<div class="header_content" id="first" style="background-image:url(../Images/header.jpg); width:100%; height:50%"> 
		<p style="position:absolute; top:290px; left:170px; font-size:7em; font-weight:8em; color:#FFFFFF;">WEBTOON</p>
	</div> 
    <section id="one" class="" style="text-align:center; padding-left:20%; padding-right:20%">
    	<img src="../Images/naver_logo2.jpg"  style="width:25em; height:17em; ">
               <!-- 검색창 -->
            <div style="margin-top:4%;">            
         		<form class="search" action="Search.jsp" method="POST">
                  <input type="text" name="search" id="search" style="">
                  <button type="submit" class="btn btn-secondary btn-sm" style="size: 40%;">search</button>
               	</form>    
            </div><br>   
		<ul class = "webtoon_content">
<%
   
       for(int i=0; i<list1.size(); i++){
      
         WebtoonDTO vo2=list1.get(i);
            String sql4="select webtoonID from webtoon where webtoonTitle='"+vo2.getTitle()+"';";
           
            ResultSet rs4=stmt.executeQuery(sql4);
            while (rs4.next()){
               int webtoonID=rs4.getInt(1);
               
%>
              
               <li class="webtoon_li">
              <a class="webtoon_url" href="Detail.jsp?number=<%=webtoonID%>"><%=vo2.getTitle() %></a></li>
   
<%
           }
          
       
      //System.out.println(vo.toString());
   }
   conn.close();
   %>
     </ul>
    
     </section>
     
          <!--scripts loaded here -->
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery.easing.min.js"></script>
    <script src="../js/wow.js"></script>
    <script src="../js/scripts.js"></script>
</body>
</html>