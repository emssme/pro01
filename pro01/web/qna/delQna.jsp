<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ page import="com.chunjae.db.*"%>

<%@ include file="../encoding.jsp"%>

<%
    int qno = Integer.parseInt(request.getParameter("qno"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "delete from qna where qno=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, qno);
    int cnt = pstmt.executeUpdate();

    if (cnt > 0) {
        response.sendRedirect("/qna/qnaList.jsp");
    } else {
        response.sendRedirect("/qna/getQna.jps?="+qno);
    }
    con.close(pstmt, conn);

%>

