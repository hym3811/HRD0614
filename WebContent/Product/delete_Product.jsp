<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	String productid=request.getParameter("productid");
	try{
		sql="delete from product0614 where productid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,productid);
		pstmt.executeUpdate();
%>
<script>
alert("상품코드: <%=productid%>\n 삭제 완료");
location.href="select_Product.jsp";
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>