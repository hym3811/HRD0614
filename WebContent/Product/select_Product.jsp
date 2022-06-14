<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 목록</title>
</head>
<body>
<%@ include file="../Main/header.jsp" %>
<%@ include file="../Main/nav.jsp" %>
<section>
	<form name=form>
		<br>
		<h3 id="title">상품 목록</h3>
		<br>
		<%
			Integer number=0;
			try{
				sql="select count(productid) from product0614";
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
		alert("등록된 상품정보가 없습니다.\n상품 등록 화면으로 이동합니다.");
		location.href="add_Product.jsp";
		</script>
		<%
			}
		%>
		<label style="margin-left:10%;">총 <%=number %>개의 상품이 있습니다.</label>
		<hr>
		<table border=1 id="tab2">
			<tr>
				<th>상품코드</th>
				<th>상품명</th>
				<th>단가</th>
				<th>상세정보</th>
				<th>제조사</th>
				<th>분류</th>
				<th>재고수</th>
				<th>상태</th>
				<th>구분</th>
			</tr>
			<%
				try{
					sql="select productid,name,unitprice,description,b.category,manufacturer,unitsinstock,condition from product0614 a join category0614 b on a.category=b.no order by productid";
					pstmt=conn.prepareStatement(sql);
					rs=pstmt.executeQuery();
					while(rs.next()){
						String productid=rs.getString(1);
						String name=rs.getString(2);
						String unitprice=rs.getString(3);
						String description=rs.getString(4);
						String category=rs.getString(5);
						String manufacturer=rs.getString(6);
						String unitsinstock=rs.getString(7);
						String condition=rs.getString(8);
			%>
			<tr>
				<td><a id="a2" href="update_Product.jsp?productid=<%=productid%>"><%=productid %></a></td>
				<td><%=name %></td>
				<td><%=unitprice %></td>
				<td><%=description %></td>
				<td><%=manufacturer %></td>
				<td><%=category %></td>
				<td><%=unitsinstock %></td>
				<td><%=condition %></td>
				<td><a href=# id="a2" onclick=if(confirm("상품코드:<%=productid %>\n삭제하시겠습니까?")){location.href="delete_Product.jsp?productid=<%=productid %>"}>삭제</a></td>
			</tr>
			<%
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			%>
		</table>
		<table style="margin:0 auto;">
		<tr>
		<td>
			<input type=button id="btn" value="등록" onclick=add()>
		</td>
		</tr>
		</table>
	</form>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
<script>
function add(){
	location.href="add_Product.jsp";
}
</script>
</html>