<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	String id=request.getParameter("id");
	try{
		sql="delete from member0614 where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
%>
<script>
alert("아이디:<%=id%>\n회원 정보 삭제 완료");
location.href="select_Member.jsp";
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>