<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	String ch=request.getParameter("chk");
	Integer chk=0;
	if(request.getParameter("chk")!=null&&request.getParameter("chk")!=""){
		chk=Integer.parseInt(request.getParameter("chk"));
	}
	try{
		sql="select table_name from user_tables where table_name='MEMBER0614'";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		if(rs.next()){
			switch(chk){
			case 11:
%>
				<script>
					location.href="add_Member.jsp?chk=<%=chk%>";
				</script>
<%
				break;
			case 12:
%>
				<script>
					location.href="select_Member.jsp?chk=<%=chk%>";
				</script>
<%
				break;
			}
		}else{
			sql="create table member0614(id number(8) primary key,password varchar2(30) not null,name varchar2(30) not null,gender char(1) not null,birth date,email varchar2(45),phone varchar2(13),address varchar2(80),interest varchar2(80),timestamp date)";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();pstmt.close();
			sql="insert into member0614 values(10000001,'1234','홍길동','1','2001-02-21','hong@korea.com','010-1111-1111','부산시 부산진구 양정동','여행,프로그램',SYSDATE)";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();pstmt.close();
			sql="insert into member0614 values(10000002,'1234','유관순','2','2000-12-23','ryu@hanmail.net','010-2222-1111','부산시 동래구 명장동','독서,사진',SYSDATE)";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();pstmt.close();
			sql="insert into member0614 values(10000003,'1234','강감찬','1','1999-03-02','kang@gmail.com','010-3333-3333','부산시 금정구 장전동','컴퓨터',SYSDATE)";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();pstmt.close();
%>
			<script>
				alert("member0614 테이블 생성 완료");
			</script>
<%
			switch(chk){
			case 11:
%>
				<script>
					location.href="add_Member.jsp";
				</script>
<%
				break;
			case 12:
%>
				<script>
					location.href="select_Member.jsp";
				</script>
<%
				break;
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>