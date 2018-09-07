<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" type="text/css" href="../css/style2.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
</head>
<body>

<%
Cookie[] cookies = request.getCookies();
int feel[]= new int[51];
for(int i=1;i<51;i++){
	feel[i]=0;
}

String number = getCookieValue(cookies, "number");
    Class.forName("com.mysql.jdbc.Driver");
  
   int webtoonID = Integer.parseInt(number);
   String currentUser = (String) session.getAttribute("userID");
  
      Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/toonight", "root", "1234");
      

String command2="select count(*) from feelings where webtoonID="+webtoonID+" and f? =1";
PreparedStatement pstmt2=conn.prepareStatement(command2);

int k=1;
String command="select count(*) from feelings where webtoonID="+webtoonID;
PreparedStatement pstmt=conn.prepareStatement(command);
ResultSet rs22=pstmt.executeQuery();
while(rs22.next()){
	k=rs22.getInt(1);}
	if(k>0){


      Statement stmt = conn.createStatement();
      String sql="select sum(grade), count(*) from feelings where webtoonID="+webtoonID;
     
      ResultSet result=stmt.executeQuery(sql);
      while(result.next()){
    	  int grade=result.getInt(1);
    	  int n=result.getInt(2);
    	  
    	 
    	  float ave=(grade/n)+(grade%n);
    	  %>
<p>평점:<%=ave %></p>
<%} %>

<p>웹툰의 감정 순위</p>
<div id="chart"></div>
<%


HashMap<String,Integer> hmap=new HashMap<String,Integer>();
for(Integer i=1;i<51;i++){
	pstmt2.setInt(1,i);

	ResultSet rs=pstmt2.executeQuery();
	while(rs.next()){
		feel[i]=rs.getInt(1);
		hmap.put("성장",feel[1]);
		hmap.put("감동",feel[2]);
		hmap.put("공포",feel[3]);
		hmap.put("스릴러",feel[4]);
		hmap.put("로맨스",feel[5]);
		hmap.put("풋풋함",feel[6]);
		hmap.put("병맛",feel[7]);
		hmap.put("재미",feel[8]);
		hmap.put("역사",feel[9]);
		hmap.put("학원",feel[10]);
		hmap.put("미스테리",feel[11]);
		hmap.put("음식",feel[12]);
		hmap.put("일상",feel[13]);
		hmap.put("SF",feel[14]);
		hmap.put("드라마",feel[15]);
		hmap.put("무빙툰",feel[16]);
		hmap.put("스포츠",feel[17]);
		hmap.put("스릴러",feel[18]);
		hmap.put("복수",feel[19]);
		hmap.put("대학생",feel[20]);
		hmap.put("청춘",feel[21]);
		hmap.put("순정",feel[22]);
		hmap.put("액션",feel[23]);
		hmap.put("우울",feel[24]);
		hmap.put("반전",feel[25]);
		hmap.put("추리",feel[26]);
		hmap.put("몽환",feel[27]);
		hmap.put("오글",feel[28]);
		hmap.put("동물",feel[29]);
		hmap.put("사차원",feel[30]);
		hmap.put("블랙 코미디",feel[31]);
		hmap.put("풍자",feel[32]);
		hmap.put("전쟁",feel[33]);
		hmap.put("괴기",feel[34]);
		hmap.put("개그",feel[35]);
		hmap.put("사이다",feel[36]);
		hmap.put("고구마",feel[37]);
		hmap.put("범죄",feel[38]);
		hmap.put("불쾌",feel[39]);
		hmap.put("실망",feel[40]);
		hmap.put("지루",feel[41]);
		hmap.put("희망",feel[42]);
		hmap.put("호감",feel[43]);
		hmap.put("초조",feel[44]);
		hmap.put("짜증",feel[45]);
		hmap.put("분노",feel[46]);
		hmap.put("절망",feel[47]);
		hmap.put("복수심",feel[48]);
		hmap.put("친숙함",feel[49]);
		hmap.put("허탈",feel[50]);
	}
}


Iterator iterator=sortByValue(hmap).iterator();
String temp=(String)iterator.next();

for(int i=0;i<5;i++){
	%>
	<p><%=temp %>:<%=hmap.get(temp) %></p>

<%
temp=(String)iterator.next();
}
     }else{
    	 %>  	 
    	 <p>등록된 감정과 별점이 없습니다. 첫번째 등록자가 되어주세요!</p>
    	 <%    	 
     }
   pstmt2.close();
	conn.close();   	  
%>
</body>
</html>
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
<%!
public static List sortByValue(final Map<String,Integer> map){
	List <String> list=new ArrayList();
	list.addAll(map.keySet());
	
	Collections.sort(list,new Comparator(){
		public int compare(Object o1, Object o2){
			Object v1=map.get(o1);
			Object v2=map.get(o2);
			
			return((Comparable)v2).compareTo(v1);
		}
	});
	 return list;
}
%>