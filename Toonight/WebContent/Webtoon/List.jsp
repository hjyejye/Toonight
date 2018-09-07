<%@page import="webtoon.WebtoonManager"%>
<%@page import="webtoon.WebtoonDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="../DBError.jsp"%>
<%@page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
Class.forName("com.mysql.jdbc.Driver");
request.setCharacterEncoding("euc-kr");
   List<WebtoonDTO> list1 = WebtoonManager.webtoonNaverData();
   List<WebtoonDTO> list2=WebtoonManager.webtoonKToonData();
   List<WebtoonDTO> list3=WebtoonManager.webtoonFoxtoonData();
   List<WebtoonDTO> list4=WebtoonManager.webtoonToomicsData();
   List<WebtoonDTO> list5=WebtoonManager.webtoonPeanutoonData();
    request.setAttribute("list1", list1);
    request.setAttribute("list2", list2);
    request.setAttribute("list3", list3);
    request.setAttribute("list4", list4);
    request.setAttribute("list5", list5);
    Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/toonight", "root", "1234");
   
    String command1 = String.format("insert into webtoon(webtoonTitle,webtoonPoster,webtoonUrl)select ?,?,? where not exists(select * from webtoon where webtoonTitle=?);");
   PreparedStatement pstmt = conn.prepareStatement(command1); 
    WebtoonDTO vo1=list1.get(0); 
    Statement stmt=conn.createStatement();
    for(int i=0; i<list1.size(); i++){
       vo1 =list1.get(i);  
          String webTitle=vo1.getTitle();
          String webPoster=vo1.getPoster();
          String webUrl=vo1.getUrl();
       
          String sql= String.format("create table if not exists webtoon(webtoonID integer not null auto_increment,webtoonTitle longtext,webtoonPoster blob,webtoonUrl longtext, webtoonGrade integer, webtoonFeels varchar (20), primary key(webtoonID))" );
          
          
          stmt.executeUpdate(sql);
          pstmt.setString(1,webTitle);
          pstmt.setString(2, webPoster);
          pstmt.setString(3,webUrl);
          pstmt.setString(4,webTitle);
          pstmt.execute();
    }
    
    
    
    String command2 = String.format("insert into webtoon(webtoonTitle,webtoonPoster,webtoonUrl)select ?,?,? where not exists(select * from webtoon where webtoonTitle=?);");
    PreparedStatement pstmt2 = conn.prepareStatement(command2); 
     WebtoonDTO vo2=list1.get(0); 
     Statement stmt2=conn.createStatement();
     for(int i=0; i<list2.size(); i++){
        vo2 =list2.get(i);  
           String webTitle=vo2.getTitle();
           String webPoster=vo2.getPoster();
           String webUrl=vo2.getUrl();
        
          
           pstmt.setString(1,webTitle);
           pstmt.setString(2, webPoster);
           pstmt.setString(4,webTitle);
           pstmt.setString(3,webUrl);
           pstmt.execute();
     }
     
     
     
     String command3 = String.format("insert into webtoon(webtoonTitle,webtoonPoster,webtoonUrl)select ?,?,? where not exists(select * from webtoon where webtoonTitle=?);");
     PreparedStatement pstmt3 = conn.prepareStatement(command3); 
      WebtoonDTO vo3=list3.get(0); 
      Statement stmt3=conn.createStatement();
      for(int i=0; i<list3.size(); i++){
         vo3 =list3.get(i);  
            String webTitle=vo3.getTitle();
            String webPoster=vo3.getPoster();
            String webUrl=vo3.getUrl();
         
            pstmt.setString(1,webTitle);
            pstmt.setString(2, webPoster);
            pstmt.setString(3,webUrl);
            pstmt.setString(4,webTitle);
            
            pstmt.execute();
      }
      
      String command4 = String.format("insert into webtoon(webtoonTitle,webtoonPoster,webtoonUrl)select ?,?,? where not exists(select * from webtoon where webtoonTitle=?);");
      PreparedStatement pstmt4 = conn.prepareStatement(command4); 
       WebtoonDTO vo4=list4.get(0); 
       Statement stmt4=conn.createStatement();
       for(int i=0; i<list4.size(); i++){
          vo4 =list4.get(i);  
             String webTitle=vo4.getTitle();
             String webPoster=vo4.getPoster();
             String webUrl=vo4.getUrl();
          
             pstmt.setString(1,webTitle);
             pstmt.setString(2, webPoster);
             pstmt.setString(3,webUrl);
             pstmt.setString(4,webTitle);
             pstmt.execute();
       }
       
       
       String command5 = String.format("insert into webtoon(webtoonTitle,webtoonPoster,webtoonUrl)select ?,?,? where not exists(select * from webtoon where webtoonTitle=?);");
       PreparedStatement pstmt5 = conn.prepareStatement(command5); 
        WebtoonDTO vo5=list5.get(0); 
        Statement stmt5=conn.createStatement();
        for(int i=0; i<list5.size(); i++){
           vo5 =list5.get(i);  
              String webTitle=vo5.getTitle();
              String webPoster=vo5.getPoster();
              String webUrl=vo5.getUrl();
           
              pstmt.setString(1,webTitle);
              pstmt.setString(2, webPoster);
              pstmt.setString(3,webUrl);
              pstmt.setString(4,webTitle);
              pstmt.execute();
        }
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>webtoon</title>
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
    <section id="one" class="" style="text-align:center; margin-top:5%; padding-left:20%; padding-right:20%">
		<a href = "Naver_Webtoon.jsp"><img src="../Images/naver_logo2.jpg" style="width:25em; height:17em; padding-bottom:5em;"></a><br>
		<a href = "KToon_Webtoon.jsp"><img src="../Images/ktoon_logo.jpg" style="width:35em; height:17em; padding-bottom:5em;"></a><br>
		<a href = "Foxtoon_Webtoon.jsp"><img src="../Images/foxtoon_logo.jpg" style="width:20em; height:20em; padding-bottom:5em;"></a><br>
		<a href="Toomics_Webtoon.jsp"><img src="../Images/toomic_logo.png" style="width:20em; height:20em; padding-bottom:5em;"></a><br>
	   <a href = "Peanutoon_Webtoon.jsp"><img src="../Images/peanutoon_logo.png" style="width:48em; height:15em; padding-bottom:5em;"></a><br>
	</section>
     <!--scripts loaded here -->
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery.easing.min.js"></script>
    <script src="../js/wow.js"></script>
    <script src="../js/scripts.js"></script>
</body>
</html>