<%@ page language="java" contentType="text/html; charset=EUC-KR" errorPage="../DBError.jsp"%>
<%@page import="java.sql.*"%>


<%
Class.forName("com.mysql.jdbc.Driver");
request.setCharacterEncoding("euc-kr");
Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/toonight", "root", "1234");
    
String userID = (String) session.getAttribute("userID");
String sql2 = "select name,userImage from user where userID="+userID;
Statement stmt = conn.createStatement();
ResultSet rs2 = stmt.executeQuery(sql2);
while(rs2.next()){
	String name=rs2.getString(1);
	Blob image=rs2.getBlob(2);
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>마이 페이지</title>
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
      <!-- 헤더 로고 -->
      <a class="navbar-brand page-scroll" href="../Main.jsp">TOONIGHT</a>
            </div>
            <div class="navbar-collapse collapse" id="bs-navbar">
            	<ul class="nav navbar-nav navbar-right">
            	
                    <li>
                        <a class="page-scroll"  href="../Webtoon/List.jsp">웹툰</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="MyPage.jsp">마이페이지</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="Logout.jsp">로그아웃</a>
                    </li>

                </ul>
                
            </div>
        </div>
    </nav>
    
    <section id="one" class="" style="text-align:center; margin-top:5%; padding-left:20%; padding-right:20%">
    <div style="justify-content: space-between;  display: flex;">
    <h1 class="h1-m" style="color:black; display:inline; font-size: 5rem;">My Page</h1>
    <h3 class="h3-m" style="color:#353535; display:inline; margin-bottom: 0; align-self: flex-end; font-weight: 100;"><%=name %>님의 정보</h3>
    </div>
    <br><br><br>
    <!-- 프로필  -->
    <div style="float:clear;">
    	<img src="../UserPic?userID=<%=userID%>" height="300em" width="300em" style="border-radius:5%" >
	</div>
	</section>
	<!-- 좋아요리스트 -->
	<section id="two" class="no-padding" style="text-align: center; padding-bottom: 5em;">
		<div id = "like_list">
			<P>좋아요 리스트</P>
		</div>
		<div class="container-fluid">
        	<div class="row no-gutter">
				<div style="padding-left:17%; padding-right:17%">
				
		<%
		}
		String sql = "select webtoon.webtoonID, webtoonTitle, webtoonPoster from (wishlist join user on wishlist.userID=user.userID) join webtoon on (wishlist.webtoonID=webtoon.webtoonID) where user.userID= " + userID;
		ResultSet rs = stmt.executeQuery(sql);
		while (rs.next()) {
			int webtoonID=rs.getInt(1);
			String webtoonTitle=rs.getString(2);
			String webtoonPoster=rs.getString(3);
		
		%>
					<div class="col-lg-4 col-sm-6">		
						<a class="a_style" href="../Webtoon/Detail.jsp?number=<%=webtoonID%>"><img src="<%=webtoonPoster%>" width="180em" height="180em"></a>
						<a class="a_style webtoon_url" href="../Webtoon/Detail.jsp?number=<%=webtoonID%>" style="display:block; padding-bottom:3em;"><%=webtoonTitle%></a>
					</div>
		<%
    	//System.out.println(vo.toString());
		}
		stmt.close();
		conn.close();
		%>
				</div>
			</div>
		</div>
	</section>
	<!-- 추천리스트 -->
	<section id="two" class="no-padding" style="text-align: center; padding-bottom: 5em;">
		<div id = "like_list">
			<P>추천 리스트</P>
		</div>
		<div class="container-fluid">
        	<div class="row no-gutter">
				<div style="padding-left:17%; padding-right:17%"></div>
			</div>
		</div>
	</section>
			<footer id="footer">
        	<div class="container-fluid">
            	<div class="row">
            	<div class="col-xs-6 col-sm-3 column">
            	<h4>Information</h4>
                    <ul class="list-unstyled">
                        <li><a href="">Products</a></li>
                        <li><a href="">Services</a></li>
                        <li><a href="">Benefits</a></li>
                        <li><a href="">Developers</a></li>
                    </ul>
            	</div>
            	<div class="col-xs-6 col-sm-3 column">
            	<h4>About</h4>
                    <ul class="list-unstyled">
                        <li><a href="#">Contact Us</a></li>
                        <li><a href="#">Delivery Information</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms &amp; Conditions</a></li>
                    </ul>
            	</div>
            	<div class="col-xs-12 col-sm-3 column">
            	<h4>Stay Posted</h4>
                    <form>
                        <div class="form-group">
                          <input type="text" class="form-control" title="No spam, we promise!" placeholder="Tell us your email">
                        </div>
                        <div class="form-group">
                          <button class="btn btn-primary" data-toggle="modal" data-target="#alertModal" type="button">Subscribe for updates</button>
                        </div>
                    </form>
            	</div>
            	<div class="col-xs-12 col-sm-3 text-right">
                    <h4>Follow</h4>
                    <ul class="list-inline">
                      <li><a rel="nofollow" href="" title="Twitter"><i class="icon-lg ion-social-twitter-outline"></i></a>&nbsp;</li>
                      <li><a rel="nofollow" href="" title="Facebook"><i class="icon-lg ion-social-facebook-outline"></i></a>&nbsp;</li>
                      <li><a rel="nofollow" href="" title="Dribble"><i class="icon-lg ion-social-dribbble-outline"></i></a></li>
                    </ul>
                </div>
            </div>
            <br/>
]
           <span class="pull-right text-muted small">Toonight 2018</span>
        </div>
	</footer>
	     <!--scripts loaded here -->
    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery.easing.min.js"></script>
    <script src="../js/wow.js"></script>
    <script src="../js/scripts.js"></script>
    
</body>
</html>