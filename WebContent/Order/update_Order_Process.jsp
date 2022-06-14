<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	String orderdate=request.getParameter("orderdate");
	String ordername=request.getParameter("ordername");
	String productid=request.getParameter("productid");
	String unitprice=request.getParameter("unitprice");
	Integer orderqty=Integer.parseInt(request.getParameter("orderqty"));
	String orderaddress=request.getParameter("orderaddress");
	Integer unitsinstock=0;
	Integer qty=0;
	String pid=null;
	try{
		sql="select productid,orderqty from order0614 where orderdate=? and ordername=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, orderdate);
		pstmt.setString(2, ordername);
		rs=pstmt.executeQuery();
		if(rs.next()){
			pid=rs.getString(1);
			qty=rs.getInt(2);
		}
		
		if(productid.equals(pid)){//상품이 같을 때
			sql="select unitsinstock from product0614 where productid=?";//기존 상품 재고 조회
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, productid);
			rs=pstmt.executeQuery();
			if(rs.next()){
				unitsinstock=rs.getInt(1);
			}
			sql="update product0614 set unitsinstock=? where productid=?";//기존 상품 재고 수정
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, unitsinstock+qty-orderqty);
			pstmt.setString(2, productid);
			pstmt.executeUpdate();
			sql="update order0614 set orderqty=?,orderaddress=? where orderdate=? and ordername=?";//기존 상품 주문 수량 수정
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, orderqty);
			pstmt.setString(2, orderaddress);
			pstmt.setString(3, orderdate);
			pstmt.setString(4, ordername);
			pstmt.executeUpdate();
		}else{//상품이 다를 때
			sql="select unitsinstock from product0614 where productid=?";//기존 상품 재고 조회
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pid);
			rs=pstmt.executeQuery();
			if(rs.next()){
				unitsinstock=rs.getInt(1);
			}
			sql="update product0614 set unitsinstock=? where productid=?";//기존 상품 재고 더하기
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, unitsinstock+qty);
			pstmt.setString(2, pid);
			pstmt.executeUpdate();
			sql="select unitsinstock from product0614 where productid=?";//신규 상품 재고 조회
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, productid);
			rs=pstmt.executeQuery();
			if(rs.next()){
				unitsinstock=rs.getInt(1);
			}
			sql="update product0614 set unitsinstock=? where productid=?";//신규 상품 재고 빼기
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, unitsinstock-orderqty);
			pstmt.setString(2, productid);
			pstmt.executeUpdate();
			sql="update order0614 set productid=?,orderqty=?,orderaddress=? where orderdate=? and ordername=?";//신규 상품 관련 정보 입력
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, productid);
			pstmt.setInt(2,orderqty);
			pstmt.setString(3, orderaddress);
			pstmt.setString(4, orderdate);
			pstmt.setString(5, ordername);
			pstmt.executeUpdate();
		}
		pstmt.close();
%>
<script>
alert("주문날짜:<%=orderdate%>\n주문자명:<%=ordername%>\n주문정보 수정 완료");
location.href="select_Order.jsp";
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>