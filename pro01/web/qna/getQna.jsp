<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import ="java.sql.*"%>
<%@ page import ="java.util.*"%>
<%@ page import ="com.chunjae.db.*"%>
<%@ page import ="com.chunjae.dto.*"%>
<%@ page import="com.chunjae.vo.Qna" %>
<%@ page import="com.sun.jna.platform.unix.X11" %>
<%@ include file="../encoding.jsp"%>

<%
    int qno = Integer.parseInt(request.getParameter("qno"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "select * from qnalist where qno=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, qno);
    rs = pstmt.executeQuery();

    Qna qna = new Qna();
    if(rs.next()){
        qna.setQno(rs.getInt("qno"));
        qna.setTitle(rs.getString("title"));
        qna.setContent(rs.getString("content"));
        qna.setAuthor(rs.getString("author"));
        qna.setResdate(rs.getString("resdate"));
        qna.setLev(rs.getInt("lev"));
        qna.setPar(rs.getInt("par"));
        qna.setCnt(rs.getInt("cnt"));
    }
    con.close(rs,pstmt,conn);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>질문과 답변 상세보기</title>

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
            min-width:140px; padding-left: 24px; padding-right: 24px; text-align: center;
            line-height: 48px; background-color: #333; color:#fff; font-size: 18px; }
        .inbtn:first-child { float:left; }
        .inbtn:last-child { float:right; }
    </style>

    <link rel="stylesheet" href="../ft.css">
</head>
<body>
<div class="container">
    <header class="hd" id="hd">
        <%@include file="../header.jsp"%>
    </header>
    <div class="contents" id="contents">
        <div class="breadcrumb">
            <p><a href="/">HOME</a> &gt; <a href="/qna/qnaList.jsp">질문과 답변</a> &gt; <span>질문과 답변 상세보기</span></p>
        </div>
        <section class="page" id="page1">
            <div class="page_wrqp">
                <h2 class="page_tit">질문과 답변 상세보기</h2>
                <hr>
                <table class="tb1">
                    <tbody>
                    <!--해당 글 번호에 상세 내용 출력-->
                    <tr>
                        <th>글 제목</th>
                        <td><%=qna.getTitle()%></td>
                    </tr>
                    <tr>
                        <th>글 내용</th>
                        <td><%=qna.getContent()%></td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td><%=qna.getAuthor()%></td>
                    </tr>
                    <tr>
                        <th>작성일</th>
                        <td><%=qna.getResdate()%></td>
                    </tr>
                    <tr>
                        <th>조회수</th>
                        <td><%=qna.getCnt()%></td>
                    </tr>
                    <tr>
                        <th colspan="2"></th>
                        <!--현재 글이 질문 글이면 로그인 한 사람만(관리자 포함) 답변하기, 질문한 사람만 질문글 수정 삭제 버튼 추가, 답변글이면 답변을 등록한 사람(관리자포함) 답변글 삭제, 수정-->
                        <!---->
                        <td>
                        <a href="/board/boardList.jsp" class="inbtn">글 목록</a>
                        <%if(qna.getLev() == 0) {%>
                            <%if (sid!=null){%>
                            <a href="/qna/addQna.jsp?lev=1&par=<%=qna.getQno()%>" class="inbtn">답변하기</a>
                            <% } %>
                            <%if (sid!=null && (sid.equals("admin") || sid.equals(qna.getAuthor()))){%>
                            <a href="/qna/updateQna.jsp?qno=<%=qna.getQno()%>" class="inbtn">질문 수정하기</a>
                            <a href="/qna/delQna.jsp?qno=<%=qna.getQno()%>" class="inbtn">질문 삭제하기</a>
                            <% } %>
                        <%} else {%>
                            <%

                            %>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@include file="../footer.jsp"%>
    </footer>
</div>
</body>
</html>
