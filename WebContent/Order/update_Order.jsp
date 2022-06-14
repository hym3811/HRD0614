<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문 정보 수정</title>
</head>
<body>
<%@ include file="../Main/header.jsp" %>
<%@ include file="../Main/nav.jsp" %>
<section>
	<form name=form>
		<br>
		<h3 id="title">주문 정보 수정</h3>
		<br>
		<table border=1 id="tab1">
			<tr>
			<%
				String orderdate=request.getParameter("orderdate");
				String ordername=request.getParameter("ordername");
				String productid=null;
				String name=null;
				Integer qty=0;
				Integer qty2=0;
				Integer unitprice=0;
				String orderaddress=request.getParameter("orderaddress");
				String orderqty=null;
				
				try{
					sql="select productid,orderqty,orderaddress from order0614 where orderdate=? and ordername=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, orderdate);
					pstmt.setString(2, ordername);
					rs=pstmt.executeQuery();
					if(rs.next()){
						if(request.getParameter("productid")==null||request.getParameter("productid")==""){
							productid=rs.getString(1);
						}else{
							productid=request.getParameter("productid");
						}
						if(request.getParameter("orderqty")==null||request.getParameter("orderqty")==""){
							orderqty=rs.getString(2);
						}else{
							orderqty=request.getParameter("orderqty");
						}
						qty2=rs.getInt(2);
						if(request.getParameter("orderaddress")==null||request.getParameter("orderaddress")==""){
							orderaddress=rs.getString(3);
						}else{
							orderaddress=request.getParameter("orderaddress");
						}
					}
				}catch(Exception e){
					e.printStackTrace();
				}
				
				if(productid!=null&&productid!=""){
					try{
						sql="select name,unitprice,unitsinstock from product0614 where productid=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, productid);
						rs=pstmt.executeQuery();
						if(rs.next()){
							name=rs.getString(1);
							unitprice=rs.getInt(2);
							qty=rs.getInt(3)+qty2;
						}else{
			%>
			<script>
			alert("[상품코드]\n유효하지 않은 상품코드입니다.");
			</script>
			<%
							productid="";
							orderqty="0";
						}
					}catch(Exception e){
						e.printStackTrace();
					}
				}else{
					productid="";
				}
				Integer total=0;
				if(unitprice!=0&&orderqty!=null&&orderqty!=""){
					total=unitprice*Integer.parseInt(orderqty);
				}
				if(productid!=null&&productid!=""&&orderqty!=null&&orderqty!=""){
					if(qty<Integer.parseInt(orderqty)){
			%>
			<script>
			alert("주문가능수량: <%=qty%>\n현재주문수량: <%=orderqty%>\n주문가능 수량을 초과했습니다.");
			</script>
			<%
						orderqty="0";
						total=0;
					}
				}
			%>
				<th>주문일자</th>
				<td><input style="height:40px;width:100%;" type=date name=orderdate value="<%=orderdate%>" readonly></td>
				<th>주문자명</th>
				<td><input readonly type=text name=ordername value="<%=ordername%>" style="width:100%;"></td>
			</tr>
			<tr>
				<th>상품코드</th>
				<td><input type=text name=productid value="<%=productid%>" onchange=search() style="width:100%;"></td>
				<th>상품명</th>
				<td><input type=text name=name value="<%=name==null ? "" : name%>" readonly style="width:100%;"></td>
			</tr>
			<tr>
				<th>단가</th>
				<td><input type=number name=unitprice value="<%=unitprice==0 ? "" : unitprice%>" style="width:100%;"></td>
				<th>주문수량</th>
				<td><input type=number name=orderqty value="<%="0".equals(orderqty) ? "" : orderqty%>" onchange=search() style="width:100%;"></td>
			</tr>
			<tr>
				<th>주문금액</th>
				<td><input type=number name=total value="<%=total==0 ? "" : total%>" readonly style="width:100%;"></td>
				<th>주문주소</th>
				<td><input type=text name=orderaddress value="<%=orderaddress==null ? "" : orderaddress%>" style="width:100%;"></td>
			</tr>
			<tr id="btntr">
				<td colspan=4>
					<input type=button value="수정" onclick=add() id="btn">
					<input type=button value="취소" onclick=location.href="update_Order.jsp?orderdate=<%=orderdate %>&ordername=<%=ordername %>" id="btn">
				</td>
			</tr>
		</table>
	</form>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
<script>
function search(){
	document.form.action="update_Order.jsp";
	document.form.submit();
}
function add(){
	var doc=document.form;
	if(doc.ordername.value==""){
		alert("[주문자명]\n주문자명을 입력하세요.");
		doc.ordername.focus();
	}else if(doc.productid.value==""){
		alert("[상품코드]\n상품코드를 입력하세요.");
		doc.productid.focus();
	}else if(doc.name.value==""){
		alert("[상품명]\n상품코드를 통해 상품명을 조회해주세요.");
		doc.productid.focus();
	}else if(doc.orderqty.value==""){
		alert("[주문수량]\n주문수량을 입력해주세요.");
		doc.orderqty.focus();
	}else if(doc.orderqty.value<=0){
		alert("[주문수량]\n주문수량은 0보다 작을 수 없습니다.");
		doc.orderqty.focus();
	}else if(doc.orderaddress.value==""){
		alert("[주문주소]\n주문주소를 입력해주세요.");
		doc.orderaddress.focus();
	}else{
		doc.action="update_Order_Process.jsp";
		doc.submit();
	}
}
</script>
</html>