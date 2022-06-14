<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 목록</title>
</head>
<body>
<%@ include file="../Main/header.jsp" %>
<%@ include file="../Main/nav.jsp" %>
<section>
	<form name=form>
		<br>
		<h3 id="title">회원 목록</h3>
		<br>
		<%
			Integer number=0;
			try{
				sql="select count(id) from member0614";
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()){
					number=rs.getInt(1);
				}
				if(number==0){
		%>
		<script>
		alert("회원 정보가 없습니다.\n회원가입 화면으로 이동합니다.");
		location.href="add_Member.jsp";
		</script>
		<%
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
		<label style="margin-left:10%;">총 <%=number %>명의 회원이 있습니다.</label>
		<hr>
		<table border=1 id="tab2">
			<tr>
				<th>아이디</th>
				<th>성명</th>
				<th>비밀번호</th>
				<th>성별</th>
				<th>생년월일</th>
				<th>이메일</th>
				<th>연락처</th>
				<th>주소</th>
				<th>관심분야</th>
				<th style="width:8%;">구분</th>
			</tr>
			
		<%
			try{
				sql="select * from member0614";
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					String id=rs.getString(1);
					String password=rs.getString(2);
					String name=rs.getString(3);
					String g=rs.getString(4);
					String gender=null;
					switch(g){
					case "1":
						gender="남성";
						break;
					case "2":
						gender="여성";
						break;
					}
					java.util.Date birth=rs.getDate(5);
					String email=rs.getString(6);
					String phone=rs.getString(7);
					String address=rs.getString(8);
					String interest=rs.getString(9);
		%>
			<tr>
				<td><%=id %></td>
				<td><%=password %></td>
				<td><%=name %></td>
				<td><%=gender %></td>
				<td><%=birth %></td>
				<td><%=email %></td>
				<td><%=phone %></td>
				<td><%=address %></td>
				<td><%=interest %></td>
				<td><a id="a2" href="update_Member.jsp?id=<%=id%>">수정</a>/<a id="a2" href=# onclick=if(confirm("아이디:<%=id %>\n삭제하시겠습니까?")){location.href="delete_Member.jsp?id=<%=id %>"}>삭제</a></td>
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
				<input id="btn" type=button value="회원가입" onclick=add()>
			</td>
		</tr>
		</table>
	</form>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
<script>
function add(){
	location.href="add_Member.jsp";
}
</script>
</html>