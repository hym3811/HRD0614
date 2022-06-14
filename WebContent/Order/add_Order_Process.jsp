<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	String orderdate=request.getParameter("orderdate");
	String ordername=request.getParameter("ordername");
	String productid=request.getParameter("productid");
	String unitprice=request.getParameter("unitprice");
	String orderqty=request.getParameter("orderqty");
	String orderaddress=request.getParameter("orderaddress");
	Integer unitsinstock=0;
	try{
		sql="select * from order0614 where orderdate=? and ordername=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, orderdate);
		pstmt.setString(2, ordername);
		rs=pstmt.executeQuery();
		if(rs.next()){
%>
<script>
alert("주문날짜:<%=orderdate%>\n주문자명:<%=ordername%>\n중복되는 주문정보입니다.");
history.back();
</script>
<%
		}else{
			sql="insert into order0614 values(?,?,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, orderdate);
			pstmt.setString(2, ordername);
			pstmt.setString(3, productid);
			pstmt.setString(4, unitprice);
			pstmt.setString(5, orderqty);
			pstmt.setString(6, orderaddress);
			pstmt.executeUpdate();
			
			sql="select unitsinstock from product0614 where productid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, productid);
			rs=pstmt.executeQuery();
			if(rs.next()){
				unitsinstock=rs.getInt(1);
				sql="update product0614 set unitsinstock=? where productid=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, unitsinstock-Integer.parseInt(orderqty));
				pstmt.setString(2, productid);
				pstmt.executeUpdate();
			}
%>
<script>
alert("주문날짜:<%=orderdate%>\n주문자명:<%=ordername%>\n주문 등록 완료");
location.href="add_Order.jsp";
</script>
<%
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>