<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chunjae.dto.*"%>
<%@ page import="com.chunjae.db.*"%>

<%@include file="../encoding.jsp"%>

<%
    int bno = Integer.parseInt(request.getParameter("bno"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "delete from board where bno=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, bno);
    int cnt = pstmt.executeUpdate();

    if (cnt > 0) {
        response.sendRedirect("/board/boardList.jsp");
    } else {
        response.sendRedirect("/board/getBoard.jps?="+bno);
    }
    con.close(pstmt, conn);

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 삭제하기</title>
</head>
<body>

</body>
</html>
