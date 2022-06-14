<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 가입 화면</title>
</head>
<body>
<%@ include file="../Main/header.jsp" %>
<%@ include file="../Main/nav.jsp" %>
<section>
	<form name=form>
		<br>
		<h3 id="title">회원 가입 등록 화면</h3>
		<br>
		<hr>
		<table border=1 id="tab1">
		<%
			String id=request.getParameter("id");
			String name=request.getParameter("name");
			String password=request.getParameter("password");
			String passchk=request.getParameter("passchk");
			String gender="";
			if(request.getParameter("gender")!=null&&request.getParameter("gender")!=""){
				gender=request.getParameter("gender");
			}
			String y=request.getParameter("year");
			Integer year=0;
			if(y!=null&&y!=""){
				year=Integer.parseInt(y);
			}
			String m=request.getParameter("month");
			Integer month=0;
			if(m!=null&&m!=""){
				month=Integer.parseInt(m);
			}
			String d=request.getParameter("day");
			Integer day=0;
			if(d!=null&&d!=""){
				day=Integer.parseInt(d);
			}
			String email=null;
			if(request.getParameter("email")!=null&&request.getParameter("email")!=""){
				email=request.getParameter("email");
			}
			String domain=null;
			String domain1=null;
			if(request.getParameter("domain1")!=null&&request.getParameter("domain1")!=""){
				domain1=request.getParameter("domain1");
			}
			String domain2=null;
			if(request.getParameter("domain2")!=null){
				domain2=request.getParameter("domain2");
			}
			if(domain1!=null&&domain1!=""){
				if(domain1!="직접입력"){
					domain=domain1;
				}
			}else if("직접입력".equals(domain1)){
				domain=domain2;
			}

			String phone=null;
			if(request.getParameter("phone")!=null&&request.getParameter("phone")!=""){
				phone=request.getParameter("phone");
			}
			String address=null;
			if(request.getParameter("address")!=null&&request.getParameter("address")!=""){
				address=request.getParameter("address");
			}
			String[] in =null;
			if(request.getParameterValues("interest")!=null){
				in = request.getParameterValues("interest");
			}
			String interest=null;
			if(in!=null){
				for(int i=0;i<in.length;i++){
					if(i==0){
						interest=in[0];
					}else{
						interest=interest+","+in[i];
					}
				}
			}
			String dt=null;
			String[] date=null;
			String em=null;
			String[] ema=null;
			/////////////////////////////////
			try{
				sql="select * from member0614 where id=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs=pstmt.executeQuery();
				if(rs.next()){
					if(request.getParameter("password")==null||request.getParameter("password")==""){
						password=rs.getString(2);
					}
					if(request.getParameter("name")==null||request.getParameter("name")==""){
						name=rs.getString(3);
					}
					if(request.getParameter("gender")==null||request.getParameter("gender")==""){
						gender=rs.getString(4);
					}
					if((request.getParameter("year")==null||request.getParameter("year")=="")&&(request.getParameter("month")==null||request.getParameter("month")=="")&&(request.getParameter("day")==null||request.getParameter("day")=="")){
						dt=rs.getString(5);
						date=dt.split("-");
						year=Integer.parseInt(date[0]);
						month=Integer.parseInt(date[1]);
						day=Integer.parseInt(date[2].replace(" 00:00:00", ""));
					}
					if(request.getParameter("phone")==null||request.getParameter("phone")==""){
						phone=rs.getString(7);
					}
					if(request.getParameter("address")==null||request.getParameter("address")==""){
						address=rs.getString(8);
					}
					if(request.getParameterValues("interest")==null){
						interest=rs.getString(9);
					}
					if((request.getParameter("email")==null||request.getParameter("email")=="")&&(request.getParameter("domain1")==null||request.getParameter("domain1")=="")&&(request.getParameter("domain2")==null||request.getParameter("domain2")=="")){
						em=rs.getString(6);
						ema=em.split("@");
						email=ema[0];
						if(!"gmail.com".equals(ema[1])||!"hanmail.net".equals(ema[1])||!"naver.com".equals(ema[1])||!"korea.com".equals(ema[1])){
							domain1="직접입력";
							domain2=ema[1];
						}else{
							domain1=ema[1];
						}
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
			<tr>
				<th>아이디</th>
				<td><input type=number name="id" value="<%=id%>" style="width:100%;"></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><input type=text name=name value="<%=name==null||name=="" ? "" : name%>" style="width:100%;"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type=password name=password value="<%=password==null||password=="" ? "" : password%>" style="width:100%;"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type=password name=passchk value="<%=passchk==null||passchk=="" ? "" : passchk%>" style="width:100%;"></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<label><input type=radio name=gender value="1" <%=gender.equals("1") ? "checked" : "" %>>남성</label>
					<label><input type=radio name=gender value="2" <%=gender.equals("2") ? "checked" : "" %>>여성</label>
				</td>
			</tr>
			<tr>
				<th>생일</th>
				<td>
					<select name=year onchange=search() style="width:25%;">
						<option value="">년도선택</option>
						<%
							for(int i=2023;i>1900;i--){
						%>
						<option value="<%=i %>" <%=i==year ? "selected" : "" %>><%=i %></option>
						<%
							}
						%>
					</select>
					년
					<select name=month onchange=search() style="width:25%;">
						<option value="">월 선택</option>
						<%
							for(int i=1;i<13;i++){
						%>
						<option value="<%=i %>" <%=i==month ? "selected" : "" %>><%=i %></option>
						<%
							}
						%>
					</select>
					월
					<select name=day style="width:25%;">
						<option value="">일 선택</option>
						<%
							if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
								for(int i=1;i<=31;i++){
						%>
							<option value="<%=i%>" <%=day==i ? "selected" : "" %>><%=i %></option>
						<%
								}
							}else if(month==2){
								if(y==null||y==""){
									for(int i=1;i<=28;i++){
										if(day>28){
											day=28;
										}
										%>
											<option value="<%=i%>" <%=day==i ? "selected" : "" %>><%=i %></option>
										<%
												}
								}else{
									if(year%4==0){
										for(int i=1;i<=29;i++){
											%>
												<option value="<%=i%>" <%=day==i ? "selected" : "" %>><%=i %></option>
											<%
													}
									}else{
										for(int i=1;i<=28;i++){
											if(day>28){
												day=28;
											}
											%>
												<option value="<%=i%>" <%=day==i ? "selected" : "" %>><%=i %></option>
											<%
													}
									}
								}
							}else if(month==4||month==6||month==9||month==11){
								for(int i=1;i<=30;i++){
									if(day>30){
										day=30;
									}
						%>
							<option value="<%=i%>" <%=day==i ? "selected" : "" %>><%=i %></option>
						<%
								}
							}else{
						%>
							<option value="" <%=m==null||m=="" ? "selected" : "" %>>-</option>
						<%
							}
						%>
					</select>
					일
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type=text name=email value="<%=email==null ? "" : email%>" style="width:50%;">
					@
					<input type=text name=domain2 value="<%="직접입력".equals(domain1)&&"".equals(domain2) ? "" : (domain2==null||domain2=="" ? "" : domain2) %>" <%="직접입력".equals(domain1) ? "" : "hidden" %>>
					<select name=domain1 onchange=search() style="width:20%;">
						<option value="">도메인 선택</option>
						<option value="gmail.com" <%="gmail.com".equals(domain1) ? "selected" : "" %>>gmail.com</option>
						<option value="hanmail.net" <%="hanmail.net".equals(domain1) ? "selected" : "" %>>hanmail.net</option>
						<option value="naver.com" <%="naver.com".equals(domain1) ? "selected" : "" %>>naver.com</option>
						<option value="korea.com" <%="korea.com".equals(domain1) ? "selected" : "" %>>korea.com</option>
						<option value="직접입력" <%="직접입력".equals(domain1) ? "selected" : "" %>>직접 입력</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td><input type=text name=phone value="<%=phone==null||phone=="" ? "" : phone%>" style="width:100%;"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type=text name=address value="<%=address==null||address=="" ? "" : address%>" style="width:100%;"></td>
			</tr>
			<tr>
				<th>관심분야</th>
				<td>
					<lable><input <%=interest!=null ? (interest.contains("프로그램") ? "checked" : "") : "" %> type=checkbox name=interest value="프로그램">프로그램</lable>
					<lable><input <%=interest!=null ? (interest.contains("독서") ? "checked" : "") : "" %> type=checkbox name=interest value="독서">독서</lable>
					<lable><input <%=interest!=null ? (interest.contains("등산") ? "checked" : "") : "" %> type=checkbox name=interest value="등산">등산</lable>
					<lable><input <%=interest!=null ? (interest.contains("여행") ? "checked" : "") : "" %> type=checkbox name=interest value="여행">여행</lable>
					<lable><input <%=interest!=null ? (interest.contains("컴퓨터") ? "checked" : "") : "" %> type=checkbox name=interest value="컴퓨터">컴퓨터</lable>
					<lable><input <%=interest!=null ? (interest.contains("영화") ? "checked" : "") : "" %> type=checkbox name=interest value="영화">영화</lable>
					<lable><input <%=interest!=null ? (interest.contains("운동") ? "checked" : "") : "" %> type=checkbox name=interest value="운동">운동</lable>
					<lable><input <%=interest!=null ? (interest.contains("산책") ? "checked" : "") : "" %> type=checkbox name=interest value="산책">산책</lable>
				</td>
			</tr>
			<tr>
				<td colspan=2 id="btntr">
					<input id="btn" type=button value="수정" onclick=add()>
					<input id="btn" type=button value="취소" onclick=reset()>
				</td>
			</tr>
		</table>
	</form>
</section>
<%@ include file="../Main/footer.jsp" %>
</body>
<script>
function search(){
	document.form.action="add_Member.jsp";
	document.form.submit();
}
function add(){
	var doc=document.form;
	var rdo=document.getElementsByName("gender");
	var chk1=0;
	for(var i=0;i<rdo.length;i++){
		if(rdo[i].checked==true){
			chk1++;
			break;
		}
	}
	var box=document.getElementsByName("interest");
	var chk2=0;
	for(var i=0;i<box.length;i++){
		if(box[i].checked==true){
			chk2++;
		}
	}
	
	if(doc.name.value==""){
		alert("[섬명]\n성명을 입력하세요.");
		doc.name.focus();
	}else if(doc.password.value==""){
		alert("[비밀번호]\n비밀번호를 입력하세요.");
		doc.password.focus();
	}else if(doc.passchk.value==""){
		alert("[비밀번호 확인]\n비밀번호 확인을 입력하세요.");
		doc.passchk.focus();
	}else if(doc.password.value!=doc.passchk.value){
		alert("[비밀번호 확인]\n비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		doc.passchk.focus();
	}else if(chk1==0){
		alert("[성별]\n성별을 체크하세요.");
	}else if(doc.year.value==""){
		alert("[생일]\n출생년도를 선택하세요.");
		doc.year.focus();
	}else if(doc.month.value==""){
		alert("[생일]\n출생월을 선택하세요.");
		doc.month.focus();
	}else if(doc.day.value==""){
		alert("[생일]\n출생일 선택하세요.");
		doc.day.focus();
	}else if(doc.email.value==""){
		alert("[이메일]이메일 주소를 입력하세요.");
		doc.email.focus();
	}else if(doc.domain1.value==""){
		alert("[도메인]도메인을 선택하세요.");
		doc.domain1.focus();
	}else if(doc.domain1.value=="직접입력"&&doc.domain2.value==""){
		alert("[도메인]도메인을 입력하세요.");
		doc.domain2.focus();
	}else if(doc.phone.value==""){
		alert("[연락처]\n연락처를 입력하세요.");
		doc.phone.focus();
	}else if(doc.address.value==""){
		alert("[주소]\n주소를 입력하세요.");
		doc.address.focus();
	}else if(chk2<2){
		alert("[관심분야]\n관심분야를 2개 이상 선택하세요.");
	}else{
		doc.action="update_Member_Process.jsp";
		doc.submit();
	}
}
</script>
</html>