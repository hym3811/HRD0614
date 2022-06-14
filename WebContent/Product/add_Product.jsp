<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 등록 화면</title>
</head>
<body>
<%@ include file="../Main/header.jsp" %>
<%@ include file="../Main/nav.jsp" %>
<section>
	<form name=form>
		<br>
		<h3 id="title">상품 등록 화면</h3>
		<br>
		<hr>
		<table border=1 id="tab1" style="width:50%;">
			<tr>
			<%
				Integer num=0;
				String pid=null;
				String productid=null;
				try{
					sql="select productid from product0614 order by productid";
					pstmt=conn.prepareStatement(sql);
					rs=pstmt.executeQuery();
					if(rs.next()){
						while(rs.next()){
							pid=rs.getString(1);
						}
						num=1+Integer.parseInt(pid.replace("P", ""));
						productid="P"+num;
					}else{
						productid="P100001";
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			%>
				<th>상품코드</th>
				<td><input style="width:100%;" type=text name=productid value="<%=productid%>" readonly></td>
			</tr>
			<tr>
				<th>상품명</th>
				<td><input style="width:100%;" type=text name=name></td>
			</tr>
			<tr>
				<th>가격</th>
				<td><input style="width:100%;" type=number name=unitprice></td>
			</tr>
			<tr>
				<th>상세정보</th>
				<td><input style="width:100%;" type=text name=description></td>
			</tr>
			<tr>
				<th>제조사</th>
				<td><input style="width:100%;" type=text name=manufacturer></td>
			</tr>
			<tr>
				<th>분류</th>
				<td>
					<select name=category style="width:100%;">
						<option value="">분류 선택</option>
						<%
							Integer no=0;
							String category=null;
							try{
								sql="select * from category0614";
								pstmt=conn.prepareStatement(sql);
								rs=pstmt.executeQuery();
								while(rs.next()){
									no=rs.getInt(1);
									category=rs.getString(2);
						%>
						<option value="<%=no%>">[<%=no %>] <%=category %></option>
						<%
								}
							}catch(Exception e){
								e.printStackTrace();
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<th>재고수</th>
				<td><input style="width:100%;" type=number name=unitsinstock></td>
			</tr>
			<tr>
				<th>상태</th>
				<td>
					<label><input type=radio name=condition value="신규제품">신규제품</label>
					<label><input type=radio name=condition value="중고제품">중고제품</label>
					<label><input type=radio name=condition value="재생제품">재생제품</label>
				</td>
			</tr>
			<tr id="btntr">
				<td colspan=2>
					<input id="btn" type="button" value="등록" onclick=add()>
					<input id="btn" type="button" value="취소" onclick=reset()>
				</td>
			</tr>
		</table>
	</form>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
<script>
function add(){
	var doc=document.form;
	var rdo=document.getElementsByName("condition");
	var chk=0;
	for(var i=0;i<rdo.length;i++){
		if(rdo[i].checked==true){
			chk++;
			break;
		}
	}
	
	if(doc.name.value==""){
		alert("[상품명]\n상품명을 입력하세요.");
		doc.name.focus();
	}else if(doc.unitprice.value==""){
		alert("[가격]\n가격을 입력하세요.");
		doc.unitprice.focus();
	}else if(doc.unitprice.value<0){
		alert("[가격]\n가격은 음수를 입력할 수 없습니다.");
		doc.unitprice.focus();
	}else if(doc.description.value==""){
		alert("[상세정보]\n상세정보를 입력하세요.");
		doc.description.focus();
	}else if(doc.manufacturer.value==""){
		alert("[제조사]\n제조사를 입력하세요.");
		doc.manufacturer.focus();
	}else if(doc.category.value==""){
		alert("[분류]\n분류를 선택하세요.");
		doc.category.focus();
	}else if(doc.unitsinstock.value==""){
		alert("[재고수]\n재고수를 입력하세요.");
		doc.unitsinstock.focus();
	}else if(doc.unitsinstock.value<0){
		alert("[재고수]\n재고수는 음수를 입력할 수 없습니다.");
		doc.unitsinstock.focus();
	}else if(chk==0){
		alert("[상태]\n상태를 선택하세요.");
	}else{
		doc.action="add_Product_Process.jsp";
		doc.submit();
	}
}
</script>
</html>