<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="com.chunjae.db.*"%>


<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String content = request.getParameter("content");

    Connection conn = null;
    PreparedStatement pstmt = null;
    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "insert into board(title, content, author) values (?,?,?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setString(3, author);

    //5. 처리된 결과의 건수를 반환받아 글등록이 성공되었으면, 목록페이지로 이동(boardList.jsp)
    //실패하면 글쓰기(addBoard.jsp)로 이동
    int cnt = pstmt.executeUpdate();
    String script = "<script>";
    script += "history.go(-1)";
    script += "</script>";

    if(cnt>0) {
        response.sendRedirect("/boardList.jsp");
    } else {
        out.println(script);
    }
    con.close(pstmt, conn);
%>
