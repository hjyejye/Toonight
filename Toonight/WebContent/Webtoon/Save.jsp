<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

</head>
<body>



<%
Class.forName("com.mysql.jdbc.Driver");
request.setCharacterEncoding("euc-kr");
Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/toonight", "root", "1234");
Cookie[] cookies = request.getCookies();
String number = getCookieValue(cookies, "number");
int webtoonID=Integer.parseInt(number);
String id = (String) session.getAttribute("userID");
int userID=Integer.parseInt(id);
String[] value=request.getParameterValues("feeling");
for (String val: value){
	out.print(val+"<br>");
}
String[] feelings;
feelings=request.getParameterValues("feeling");
int[] num=new int[value.length];
for(int i=0;i<value.length;i++){
	num[i]=Integer.parseInt(feelings[i]);
}
String[] ratings;
ratings=request.getParameterValues("star");
int grade=Integer.parseInt(ratings[0]);
//int n1=Integer.parseInt(feelings[0]);
//int n2=Integer.parseInt(feelings[1]);
//int n3=Integer.parseInt(feelings[2]);
	
String command="select count(*) from feelings where userID=? and webtoonID=?";
PreparedStatement pstmt = conn.prepareStatement(command); 
pstmt.setInt(1,userID);
pstmt.setInt(2,webtoonID);
//pstmt.execute();
 
ResultSet rs=pstmt.executeQuery();
while(rs.next()){
	int count= rs.getInt(1);
	if(count==0){
	out.println("감정을 체크해주세요.");
for(int i=0;i<value.length;i++){
	String command2 = String.format("insert into feelings(webtoonID,userID, grade, f?) values (?,?,?,?) ;");
	PreparedStatement pstmt1 = conn.prepareStatement(command2); 
	pstmt1.setInt(1,num[i]);
	pstmt1.setInt(2,webtoonID);
	pstmt1.setInt(3,userID);
	pstmt1.setInt(4,grade);
	pstmt1.setInt(5,1);
pstmt1.execute();
pstmt1.close();
}
	}else{
		out.println("저장되었습니다. ");
		
		for(int i=0;i<value.length;i++){
			String sql11 = "update feelings  set grade=?, f?=1 where webtoonID=? and userID=? ";
			PreparedStatement pstmt2 = conn.prepareStatement(sql11); 
			pstmt2.setInt(1,grade);
			pstmt2.setInt(2,num[i]);
			pstmt2.setInt(3,webtoonID);
			pstmt2.setInt(4,userID);
			pstmt2.execute();
			pstmt2.close();
		}
			
	}
}
pstmt.close();
%>
<%!private String getCookieValue(Cookie[] cookies, String name) {
		String value = null;
		if (cookies == null)
			return null;
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(name))
				return cookie.getValue();
		}
		return null;
	}%>
	
</body>
</html>