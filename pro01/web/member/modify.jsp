<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.chunjae.db.*" %>
<%@ page import="com.chunjae.dto.*" %>
<%
    String id = (String) session.getAttribute("id");    //세션의 id 불러오기
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    Member mem = new Member();  //마이페이지에 담길 회원 객체 생성

    DBC con = new MariaDBCon();
    conn = con.connect();
    if(conn != null){
        System.out.println("DB연결 성공");
    }
    String pw = "";
    try {
        String sql = "select * from member where id=?"; //DB에서 로그인 한 회원의 정보를 검색
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();
        if (rs.next()) { //해당 회원의 정보를 DB에서 로딩하여 회원 객체의 필드값으로 저장
            mem.setId(rs.getString("id"));
            mem.setPw(rs.getString("pw"));
            mem.setName(rs.getString("name"));
            mem.setEmail(rs.getString("email"));
            mem.setTel(rs.getString("tel"));
            mem.setRegdate(rs.getString("regdate"));
            mem.setPoint(rs.getInt("point"));
            pw = mem.getPw();
        } else {
            response.sendRedirect("/member/login.jsp");
        }
    } catch (SQLException e) {
        System.out.println("SQL 구문이 처리되지 못했습니다.");
    } finally {
        con.close(rs, pstmt, conn);
    }
%>
<%
    String path0 = request.getContextPath();
    String pw2 = pw.substring(0,2);
    for(int i=0; i<pw.length(); i++) {
        pw2+="*";
    }  //12**  //pw2.equals(re_pw)
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <%@ include file="../head.jsp" %>

    <!-- 스타일 초기화 : reset.css 또는 normalize.css -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">

    <!-- 필요한 폰트를 로딩 : 구글 웹 폰트에서 폰트를 선택하여 해당 내용을 붙여 넣기 -->
    <link rel="stylesheet" href="../google.css">
    <link rel="stylesheet" href="../fonts.css">

    <!-- 필요한 플러그인 연결 -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <link rel="stylesheet" href="../common.css">
    <link rel="stylesheet" href="../hd.css">
    <style>
        /* 본문 영역 스타일 */
        .contents { clear:both; min-height:100vh;
            background-image: url("../images/education01.jpg");
            background-repeat: no-repeat; background-position:center -250px; }
        .contents::after { content:""; clear:both; display:block; width:100%; }

        .page { clear:both; width: 100vw; height: 100vh; position:relative; }
        .page::after { content:""; display:block; width: 100%; clear:both; }

        .page_wrap { clear:both; width: 1200px; height: auto; margin:0 auto; }
        .page_tit { font-size:48px; text-align: center; padding-top:1em; color:#fff;
            padding-bottom: 2.4rem; }

        .breadcrumb { clear:both;
            width:1200px; margin: 0 auto; text-align: right; color:#fff;
            padding-top: 28px; padding-bottom: 28px; }
        .breadcrumb a { color:#fff; }
        .frm { clear:both; width:1200px; margin:0 auto; padding-top: 80px; }

        .tb1 { width:500px; margin:0 auto; }
        .tb1 th {width: 500px; }
        .tb1 td { width:310px; line-height: 32px; padding-top:8px; padding-bottom:8px; border-bottom: 1px solid #333; padding-left: 14px; border-top: 1px solid #333;}

        .indata { display:inline-block; width: 500px; height: 48px; line-height: 48px;
            text-indent:14px; font-size:18px; }
        .inbtn { display:block;  border-radius:100px;
            min-width:140px; padding-left: 24px; padding-right: 24px; text-align: center;
            line-height: 48px; background-color: #333; color:#fff; font-size: 18px; }
        .inbtn:first-child { float:left; }
        .inbtn:last-child { float:right; }
    </style>

    <link rel="stylesheet" href="../ft.css">
</head>
<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <div class="breadcrumb">
            <p><a href="">HOME</a> &gt; <span>정보수정</span></p>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">회원 정보 수정</h2>
                <hr>
                <form action="modifypro.jsp" method="post">
                    <table class="tb1">
                        <tbody>
                        <tr>
                            <th>아이디</th>
                            <td><input type="text" name="id" id="id" class="indata" value="<%=mem.getId()%>" readonly required/></td>
                        </tr>
                        <tr>
                            <th>비밀번호</th>
                            <!-- re_pw에 입력한 값과 pw2의 값이 같으면 원래 pw값을 전달
                            서로 다르면 re_pw로 비밀번호를 변경할 것임-->
                            <td>
                                <input type="text" value="<%=pw2 %>" name="re_pw" id="re_pw" class="indata" required/>
                                <input type="hidden" value="<%=pw2 %>" name="pw2" id="pw2"/>
                                <input type="hidden" value="<%=pw %>" name="pw" id="pw"/>
                            </td>
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td><input type="text" value="<%=mem.getName()%>" name="name" id="name" class="indata" readonly></td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td><input type="email" value="<%=mem.getEmail()%>" name="email" id="email" class="indata" required></td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td><input type="tel" value="<%=mem.getTel()%>" name="tel" id="tel" class="indata" required></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="colspan">
                                <input type="submit" value="회원정보수정" class="inbtn">
                                <a href="/member/mypage.jsp" class="inbtn"></a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>