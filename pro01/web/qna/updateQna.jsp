<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.chunjae.db.*"%>
<%@ page import ="com.chunjae.dto.*"%>
<%@ page import ="com.chunjae.vo.*"%>
<%@ include file="../encoding.jsp"%>

<%
    int qno = Integer.parseInt(request.getParameter("qno"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int cnt = 0;

    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "update qua set title = ? content = ? where bno=?";
    pstmt = con.connect().prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setInt(3,qno);

    Qna qbd = new Qna();
    if(cnt>0) {
        response.sendRedirect("/qna/qnaList.jsp");
    } else {
        response.sendRedirect("/qna/updateQna.jsp?qno"+qno);
    }
    con.close(rs, pstmt, conn);

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>질문과 답변 수정하기</title>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>공지사항 수정하기</title>

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
                background-image: url("../images/education13.jpg");
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

            .tb1 { width:800px; margin:50px auto; }
            .tb1 th { line-height:32px; padding-top:8px; padding-bottom:8px;
                border-top:1px solid #333; border-bottom:1px solid #333;
                background-color:deepskyblue; color:#fff; }
            .tb1 td {line-height:32px; padding-top:8px; padding-bottom:8px;
                border-bottom:1px solid #333;
                padding-left: 14px; border-top:1px solid #333; }

            .indata { display:inline-block; width:300px; height: 48px; line-height: 48px;
                text-indent:14px; font-size:18px; }
            .inbtn { display:block;  border-radius:100px;
                min-width:100px; padding-left: 24px; padding-right: 24px; text-align: center;
                line-height: 48px; background-color: #333; color:#fff; font-size: 18px;
                float:left; margin-right: 20px; }
            .inbtn:last-child { float:right; }
        </style>

        <link rel="stylesheet" href="../ft.css">
</head>
<body>
    <header class="hd" id="hd">
        <%@include file="../header.jsp"%>
    </header>
    <div class="contents" id="contents">
        <div class="breadcrumb">
            <p><a href="/">HOME</a> &gt; <a href="">질문과 답변 </a> &gt; <span>질문과 답변 수정하기</span></p>
        </div>
        <seciton class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">질문과 답변 수정하기</h2>
                <hr>
                <form action="updateQnaPro.jsp" method="poste">
                    <table class="tb1">
                        <tbody>
                        <tr>
                            <th>글번호</th>
                            <td><input type="text" name="qno" id="qno" class="indata" value="<%=qbd.getQno()%>" required></td>
                        </tr>
                        <tr>
                            <th>글제목</th>
                            <td><input type="text" name="title" id="title" class="indata" value="<%=qbd.getTitle()%>" required></td>
                        </tr>
                        <tr>
                            <th>글내용</th>
                            <td><textarea rows="10" cols="80" name="content" id="content" class="indata2"><%=qbd.getContent() %></textarea></td>
                        </tr>
                        <tr>
                            <td colspan="2">

                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
</body>
</html>
