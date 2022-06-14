<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	String orderdate=request.getParameter("orderdate");
	String ordername=request.getParameter("ordername");
	String productid=null;
	Integer orderqty=0;
	Integer unitsinstock=0;
	try{
		sql="select productid,orderqty from order0614 where orderdate=? and ordername=?";//상품명,주문수량 조회
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, orderdate);
		pstmt.setString(2, ordername);
		rs=pstmt.executeQuery();
		if(rs.next()){
			productid=rs.getString(1);
			orderqty=rs.getInt(2);
		}
		sql="select unitsinstock from product0614 where productid=?";//해당 상품 재고 조회
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, productid);
		rs=pstmt.executeQuery();
		if(rs.next()){
			unitsinstock=rs.getInt(1);
		}
		sql="update product0614 set unitsinstock=? where productid=?";//재고 더하기
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, unitsinstock+orderqty);
		pstmt.setString(2, productid);
		pstmt.executeUpdate();
		sql="delete from order0614 where orderdate=? and ordername=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, orderdate);
		pstmt.setString(2, ordername);
		pstmt.executeUpdate();
%>
<script>
alert("주문날짜:<%=orderdate%>\n주문자명:<%=ordername%>\n주문 정보 삭제 완료");
location.href="select_Order.jsp";
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>