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
		sql="insert into product0614 values(?,?,?,?,?,?,?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, productid);
		pstmt.setString(2, name);
		pstmt.setString(3, unitprice);
		pstmt.setString(4, description);
		pstmt.setString(5, category);
		pstmt.setString(6, manufacturer);
		pstmt.setString(7, unitsinstock);
		pstmt.setString(8, condition);
		pstmt.executeUpdate();
%>
<script>
alert("상품 정보 등록 완료");
location.href="add_Product.jsp";
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>