<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../DBConn.jsp" %>
<%
	Integer chk=Integer.parseInt(request.getParameter("chk"));
	try{
		sql="select table_name from user_tables where table_name='PRODUCT0614'";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		if(rs.next()){
			switch(chk){
			case 21:
%>
				<script>
				location.href="add_Product.jsp";
				</script>
<%
				break;
			case 22:
%>
				<script>
				location.href="select_Product.jsp";
				</script>
<%
				break;
			}
		}else{
			sql="create table product0614(productid varchar2(20) primary key,name varchar2(45) not null,unitprice number(11) not null,description varchar2(45),category varchar2(45),manufacturer varchar2(45),unitsinstock number(11),condition varchar2(45))";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();pstmt.close();
			sql="insert into product0614 values('P100001','computer',1500000,'cpu256 samsung','10','SAMSUNG',11,'신규제품')";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();pstmt.close();
			sql="insert into product0614 values('P100002','mouse',15000,'wireless','10','LG',20,'신규제품')";
			pstmt=conn.prepareStatement(sql);
			pstmt.executeUpdate();pstmt.close();
			
			sql="select table_name from user_tables where table_name='CATEGORY0614'";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(!rs.next()){
				sql="create table category0614(no number(3) primary key, category varchar2(50) not null)";
				pstmt=conn.prepareStatement(sql);
				pstmt.executeUpdate();pstmt.close();
				sql="insert into category0614 values(10,'전자제품')";
				pstmt=conn.prepareStatement(sql);
				pstmt.executeUpdate();pstmt.close();
				sql="insert into category0614 values(20,'의류')";
				pstmt=conn.prepareStatement(sql);
				pstmt.executeUpdate();pstmt.close();
				sql="insert into category0614 values(30,'공산품')";
				pstmt=conn.prepareStatement(sql);
				pstmt.executeUpdate();pstmt.close();
				sql="insert into category0614 values(40,'식품')";
				pstmt=conn.prepareStatement(sql);
				pstmt.executeUpdate();pstmt.close();
				sql="insert into category0614 values(50,'유제품')";
				pstmt=conn.prepareStatement(sql);
				pstmt.executeUpdate();pstmt.close();
			}
%>
<script>
alert("product0614 테이블 생성 완료");
</script>
<%
			switch(chk){
			case 21:
%>
	<script>
	location.href="add_Product.jsp";
	</script>
<%
				break;
			case 22:
%>
	<script>
	location.href="select_Product.jsp";
	</script>
<%
				break;
			}	
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>