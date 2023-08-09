<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.chunjae.db.*"%>

<%@ include file="../encoding.jsp"%>

<%
    int qno = Integer.parseInt(request.getParameter("qno"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    Connection conn = null;
    PreparedStatement pstmt = null;

    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "update qna set title=?, content=? where qno=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setInt(3, qno);

    int cnt = pstmt. executeUpdate();

    if (cnt > 0) {
        response.sendRedirect("/qna/qnaList.jsp");
    } else {
        response.sendRedirect("/qna/updateQna.jsp?=qno"+qno);
    }

    con.close(pstmt, conn);

%>