<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.chunjae.db.*" %>
<%@ page import="com.chunjae.dto.*" %>
<%
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    String pw2 = request.getParameter("pw2");
    String name = request.getParameter("name");
    String email = request.getParameter("name");
    String tel = request.getParameter("tel");


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
        String sql = "insert into member(id, password, name, tel, email) values (?,?,?,?,?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, pw);
        pstmt.setString(3, name);
        pstmt.setString(4, tel);
        pstmt.setString(5, email);
        pstmt.executeUpdate();
        if (cnt > 0) {
            out.print("<script> alert ('회원가입이 완료되었습니다')</script>");
            location.href="login.jsp";
        } else {
            out.print("<script> alert ('회원가입에 실패하였습니다.')</script>");
            location.href="join.jsp";
        }
    } catch (SQLException e) {
        System.out.println("SQL 구문이 처리되지 못했습니다");
    } finally {
        con.close(rs,pstmt, conn);
    }
%>