<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	String id=request.getParameter("id");
	String password=request.getParameter("password");
	String name=request.getParameter("name");
	String gender=request.getParameter("gender");
	String year=request.getParameter("year");
	String month=request.getParameter("month");
	String day=request.getParameter("day");
	String birth=year+"-"+month+"-"+day;
	String mail=request.getParameter("email");
	String domain1=request.getParameter("domain1");
	String domain2=request.getParameter("domain2");
	String email=null;
	if("직접입력".equals(domain1)){
		email=mail+"@"+domain2;
	}else{
		email=mail+"@"+domain1;
	}
	String phone=request.getParameter("phone");
	String address=request.getParameter("address");
	String[] in=request.getParameterValues("interest");
	String interest=null;
	for(int i=0;i<in.length;i++){
		if(i==0){
			interest=in[0];
		}else{
			interest=interest+","+in[i];
		}
	}
	
	try{
		sql="insert into member0614 values(?,?,?,?,?,?,?,?,?,sysdate)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		pstmt.setString(3, name);
		pstmt.setString(4, gender);
		pstmt.setString(5, birth);
		pstmt.setString(6, email);
		pstmt.setString(7, phone);
		pstmt.setString(8, address);
		pstmt.setString(9, interest);
		pstmt.executeUpdate();
%>
<script>
alert("아이디: <%=id%>\n성명: <%=name%>\n회원가입 완료");
location.href="add_Member.jsp";
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>