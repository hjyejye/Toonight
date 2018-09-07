<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@page import="java.sql.*"%>
<html>
<head>
	<meta charset="utf-8">	
	<title>툰아잇</title>
    <meta name="description" content="This is a free Bootstrap landing page theme created for BootstrapZero. Feature video background and one page design." />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Codeply">
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/animate.min.css" />
    <link rel="stylesheet" href="css/ionicons.min.css" />
    <link rel="stylesheet" href="css/styles.css" />
    <link rel="stylesheet" href="css/search.css" />
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
                
                <a class="navbar-brand page-scroll" href="Main.jsp">TOONIGHT</a>
            </div>
	        <div class="navbar-collapse collapse" id="bs-navbar">
	            <ul class="nav navbar-nav navbar-right">
	            	<%
	                  String id = (String) session.getAttribute("userID");
	                  if (id == null) {
	               	%>
	                    <li>
	                        <a class="page-scroll" href="User/SignUp.jsp">회원가입</a>
	                    </li>
	                    <li>
	                        <a class="page-scroll" href="User/Login.jsp">로그인</a>
	                    </li>
	                <%
	                  } else {
	                %>
	                    <li>
	                        <a class="page-scroll"  href="Webtoon/List.jsp">웹툰</a>
	                    </li>
	                    <li>
	                        <a class="page-scroll" href="User/MyPage.jsp">마이페이지</a>
	                    </li>
	                    <li>
	                        <a class="page-scroll" href="User/Logout.jsp">로그아웃</a>
	                    </li>
	                 <%
	                  }
	                 %> 
				</ul>
			</div>
        </div>
    </nav>
	 <header id="first">
        <div class="header-content">
            <div class="inner">       
            <!-- 메인 로고 -->
            	<a href="Main.jsp">
                  <img src="Images/biglogo.png" alt="Main Logo" style="width:70%; height:12%;">
               </a>
			<!-- 검색창 -->
            <div style="margin-top:4%;">            
         		<form class="search" action="Webtoon/Search.jsp" method="POST">
                  <input type="text" name="search" id="search" style="">
                  <button type="submit" class="btn btn-secondary btn-sm" style="size: 40%;">search</button>
               </form>    
            </div>   
                           
			</div>
         </div>
	</header>       
         <!-- 소개화면 -->
	<section class="bg-primary" id="one">
        <div>
			<img src="Images/intro.png" width="100%" height="1020px"> 
        </div>
	</section>
          
         <!--좋아요 기준 인기 순위 9개-->
               
         <section id="two" class="no-padding" style="text-align: center;">
         	<img src="Images/top9.png" width="25%" height="15%" style="margin-left:auto; margin-top:5%; margin-bottom:5%">
         	<br><br>
         	<div class="container-fluid">
         	     <div class="row no-gutter">
           <%
           Class.forName("com.mysql.jdbc.Driver");
           request.setCharacterEncoding("euc-kr");
            Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/toonight", "root", "1234");
            Statement stmt = conn.createStatement();

            int top[]=new int[50];
            String sql="select webtoonID,count(webtoonID) from wishlist group by webtoonID order by count(webtoonID) desc limit 9";
            String sql2="select webtoonTitle,webtoonPoster from webtoon where webtoonID=?";
            PreparedStatement pstmt=conn.prepareStatement(sql2);
            ResultSet rs=stmt.executeQuery(sql);
            while(rs.next()){
            	int wid=rs.getInt(1);
            	int wish=rs.getInt(2);
            	pstmt.setInt(1,wid);
            	ResultSet rs2=pstmt.executeQuery();
            	while(rs2.next()){
            		String title=rs2.getString(1);
            		String poster=rs2.getString(2);
			%>           	
            	<div style="padding-left:17%; padding-right:17%">
                	<div class="col-lg-4 col-sm-6" style="padding-bottom:2em;">
                	  <a href="#galleryModal" class="gallery-box" data-toggle="modal"><img src="<%=poster %>" class="img-responsive" alt="Image" style=" height:30em;">
	                        <div class="gallery-box-caption">
	                            <div class="gallery-box-content">
	                                <div>
	                                    <i class="icon-lg ion-ios-search"></i>
	                                    <p><%=title %></p>
	                                    <p>♥ <%=wish %></p>
	                                </div>
	                            </div>
	                        </div>
                    	</a>
                	</div>
				</div>
               <% 
            }}
           pstmt.close();
			%>
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
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.easing.min.js"></script>
    <script src="js/wow.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>