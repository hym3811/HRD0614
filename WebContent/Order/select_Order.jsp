<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문 목록</title>
</head>
<body>
<%@ include file="../Main/header.jsp" %>
<%@ include file="../Main/nav.jsp" %>
<section>
	<form name=form>
		<br>
		<h3 id="title">주문 목록</h3>
		<br>
		<%
			Integer number=0;
			try{
				sql="select count(orderdate) from order0614";
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()){
					number=rs.getInt(1);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			if(number==0){
		%>
		<script>
		alert("등록된 주문정보가 없습니다.\n주문 정보 등록 화면으로 이동합니다.");
		location.href="add_Order.jsp";
		</script>
		<%
			}
		%>
		<label style="margin-left:10%;">총 <%=number %>개의 주문정보가 있습니다.</label>
		<hr>
		<table border=1 id="tab2">
			<tr>
				<th>No</th>
				<th>주문날짜</th>
				<th>주문자명</th>
				<th>상품코드</th>
				<th>상품명</th>
				<th>단가</th>
				<th>주문수량</th>
				<th>주문주소</th>
				<th>구분</th>
			</tr>
		<%
			Integer no=0;
			java.util.Date orderdate=null;
			String ordername=null;
			String productid=null;
			String name=null;
			String unitprice=null;
			String orderqty=null;
			String orderaddress=null;
			if(number!=0){
				try{
					sql="select orderdate,ordername,a.productid,b.name,a.unitprice,a.orderqty,a.orderaddress from order0614 a join product0614 b on a.productid=b.productid order by a.orderdate";
					pstmt=conn.prepareStatement(sql);
					rs=pstmt.executeQuery();
					while(rs.next()){
						no++;
						orderdate=rs.getDate(1);
						ordername=rs.getString(2);
						productid=rs.getString(3);
						name=rs.getString(4);
						unitprice=rs.getString(5);
						orderqty=rs.getString(6);
						orderaddress=rs.getString(7);
		%>
			<tr>
				<td><%=no %></td>
				<td><%=orderdate %></td>
				<td><%=ordername %></td>
				<td><%=productid %></td>
				<td><%=name %></td>
				<td><%=unitprice %></td>
				<td><%=orderqty %></td>
				<td><%=orderaddress %></td>
				<td><a id="a2" href="update_Order.jsp?orderdate=<%=orderdate%>&ordername=<%=ordername%>">수정</a>/<a id="a2" href=# onclick=if(confirm("주문날짜:<%=orderdate%>\n주문자명:<%=ordername%>\n삭제하시겠습니까?")){location.href="delete_Order.jsp?orderdate=<%=orderdate%>&ordername=<%=ordername%>"}>삭제</a></td>
			</tr>
		<%
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		%>
		</table>
		<table style="margin:0 auto">
		<tr>
		<td>
			<input id="btn" type=button value="등록" onclick=add()>
		</td>
		</tr>
		</table>
	</form>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
<script>
function add(){
	location.href="add_Order.jsp";
}
</script>
</html>