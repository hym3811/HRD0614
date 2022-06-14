<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	try{
		sql="select table_name from user_tables where table_name='MEMBER0614'";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		if(rs.next()){
			sql="drop table member0614";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();
%>
<script>
alert("member0614 테이블 삭제 완료");

</script>
<%
		}
		sql="select table_name from user_tables where table_name='PRODUCT0614'";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		if(rs.next()){
			sql="drop table product0614";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();
%>
<script>
alert("product0614 테이블 삭제 완료");
</script>
<%
		}
		sql="select table_name from user_tables where table_name='CATEGORY0614'";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		if(rs.next()){
			sql="drop table category0614";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();
%>
<script>
alert("category0614 테이블 삭제 완료");
</script>
<%
		}
		sql="select table_name from user_tables where table_name='ORDER0614'";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		if(rs.next()){
			sql="drop table order0614";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();
%>
<script>
alert("order0614 테이블 삭제 완료");
</script>
<%
		}
%>
<script>
alert("홈 화면으로 이동합니다.");
location.href="../Main/index.jsp";
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>