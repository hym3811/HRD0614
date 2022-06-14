<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	String productid=request.getParameter("productid");
	String name=request.getParameter("name");
	String unitprice=request.getParameter("unitprice");
	String description=request.getParameter("description");
	String category=request.getParameter("category");
	String manufacturer=request.getParameter("manufacturer");
	String unitsinstock=request.getParameter("unitsinstock");
	String condition=request.getParameter("condition");
	try{
		sql="update product0614 set name=?,unitprice=?,description=?,category=?,manufacturer=?,unitsinstock=?,condition=? where productid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, unitprice);
		pstmt.setString(3, description);
		pstmt.setString(4, category);
		pstmt.setString(5, manufacturer);
		pstmt.setString(6, unitsinstock);
		pstmt.setString(7, condition);
		pstmt.setString(8, productid);
		pstmt.executeUpdate();
%>
<script>
alert("상품 정보 수정 완료");
location.href="select_Product.jsp";
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>