<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.chunjae.db.*" %>
<%@ page import="com.chunjae.dto.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    //DB 연결하기
    DBC conn = new MariaDBCon();
    con = conn.connect();

    //SQL을 실행하여 Result(공지사항 목록) 가져오기
    String sql = "select * from board order by bno desc";
    pstmt = con.prepareStatement(sql);
    rs = pstmt.executeQuery();

    //가져온 목록을 boardList(공지사항목록)에 하나씩 담기
    List<Board> boardList = new ArrayList<>();
    while (rs.next()) {
        Board bd = new Board();
        bd.setBno(rs.getInt("bno"));
        bd.setTitle(rs.getString("title"));
        bd.setContent(rs.getString("content"));
        bd.setAuthor(rs.getString("author"));
        bd.setResdate(rs.getString("resdate"));
        bd.setCnt(rs.getInt("cnt"));
        boardList.add(bd);
    }
    conn.close(rs, pstmt, con);


%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 목록</title>
    <%@include file="../head.jsp"%>
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

        .tb1 { width:500px; margin:50px auto; }
        .tb1 th { width:180px; line-height:32px; padding-top:8px; padding-bottom:8px;
            border-top:1px solid #333; border-bottom:1px solid #333;
            background-color:deepskyblue; color:#fff; }
        .tb1 td { width:310px; line-height:32px; padding-top:8px; padding-bottom:8px;
            border-bottom:1px solid #333;
            padding-left: 14px; border-top:1px solid #333; }

        .tb1 .item1 { width: 5%;}
        .tb2 .item3 { width: 70%;}
        .tb3 .item3 { width: 10%;}
        .tb4 .item4 { width: 15%;}

        .indata { display:inline-block; width:300px; height: 48px; line-height: 48px;
            text-indent:14px; font-size:18px; }
        .inbtn { display:block;  border-radius:100px;
            min-width:140px; padding-left: 24px; padding-right: 24px; text-align: center;
            line-height: 48px; background-color: #333; color:#fff; font-size: 18px; }
        .inbtn:first-child { float:left; }
        .inbtn:last-child { float:right; }
    </style>
    <!--jquery paging 처리-->
    <link rel="stylesheet" href="../jquery.dataTables.css">
    <script src="../jquery.dataTables.js"></script>
</head>
<body>
<div class="container">
    <header class="hd" id="hd">
        <%@include file="../header.jsp"%>
    </header>
    <div class="contents" id="contents">
        <div class="breadcrumb">
            <p><a href="/">HOME</a> &gt; <a href="">공지사항 </a> &gt; <span>공지사항 목록</span></p>
        </div>
        <seciton class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">공지사항 목록</h2>
                <hr>
                <table class="tb1" id="myTable">
                    <thead>
                    <th class="item1">글번호</th>
                    <th class="item2">글제목</th>
                    <th class="item3">작성자</th>
                    <th class="item4">작성일</th>
                    </thead>
                   <tbody>
                        <%
                            SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
                            for(Board bd:boardList) {
                                Date d = ymd.parse(bd.getResdate());    //날짜 데이터로 변경
                                String date = ymd.format(d);    //형식을 포함한 문자열로 변경
                        %>
                        <td class="item1"><%=bd.getBno()%></td>
                        <td class="item2">
                            <%
                                if(sid != null) { %>
                            <a href="/board/getBoard.jsp?bno=<%=bd.getBno()%>"><%=bd.getTitle()%></a>
                            <% } else { %>
                            <span><%=bd.getTitle()%></span>
                            <% } %>
                        </td>
                        <td class="item3"><%=bd.getAuthor()%></td>
                        <td class="item4"><%=bd.getResdate()%></td>
                   <%
                       }
                   %>
                    </tbody>
                </table>
                <script>
                    $(document).ready( function () {
                        $('#myTable').DataTable({
                            order:[[0,"desc"]]
                        });
                    } );
                </script>
            </div>
        </seciton>
    </div>
    <footer class="ft" id="ft">
        <%@include file="../footer.jsp"%>
    </footer>
</div>
</body>
</html>
