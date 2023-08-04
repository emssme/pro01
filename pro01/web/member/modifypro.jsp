<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.chunjae.db.*" %>
<%@ page import="com.chunjae.dto.*" %>
<%
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    String pw2 = request.getParameter("pw2");
    String re_pw = request.getParameter("re_pw");
    String apw = "";
    if (pw2.equals(re_pw)){
        apw = pw;
    } else {
        apw = re_pw;
    }
    String tel = request.getParameter("tel");
    String email = request.getParameter("email");
    int cnt =0;
    Connection conn = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;

    DBC con = new MariaDBCon();
    conn = con.connect();
    if(conn != null){
        System.out.println("DB 연결 성공");
    }

    try {
        String sql = "update * member set pw=?, email=? tel=?, where id =?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, apw);
        pstmt.setString(2, email);
        pstmt.setString(3, tel);
        pstmt.setString(4, id);
        rs = pstmt.executeQuery();
        if (cnt > 0) {
            response.sendRedirect("/");
        } else {
            response.sendRedirect("/member/modify.jsp");
        }
    } catch (SQLException e) {
        System.out.println("SQL 구문이 처리되지 못했습니다");
    } finally {
        con.close(rs,pstmt, conn);
    }
%>