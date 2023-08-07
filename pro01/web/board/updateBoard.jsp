\<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.chunjae.db.*" %>
<%@ page import="com.chunjae.dto.*"%>

<%
    int bno = Integer.parseInt(request.getParameter("bno"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int cnt =0;

    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "update Board set title=? content=? where bno=?";
    pstmt = con.connect().prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setInt(3, bno);
    cnt = pstmt.executeUpdate();

    Board bd = new Board();
    if (cnt>0) {
        response.sendRedirect("/board/BoardList.jsp");
    } else {
        response.sendRedirect("/board/updateBoard.jsp?bno="+bno);
    }
    con.close(rs, pstmt, conn);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 수정하기</title>
</head>
<body>

</form>
</body>
</html>
