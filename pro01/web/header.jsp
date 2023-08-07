<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String path1 = request.getContextPath();
    String sid = (String) session.getAttribute("id");
%>
<body>
<div class="wrap">
    <header class="hd">
        <div class="hd_wrap">
            <a href="index.html" class="logo">
                <img src="<%=path1 %>/images/chunjae1.png" alt="천재IT교육센터 로고타입">
            </a>
            <nav class="tnb">
                <ul class="menu">
                    <nav class="tnb">
                        <ul class="menu">
                            <% if(sid!=null) { %>
                            <li><a href="<%=path1 %>/member/logout.jsp">로그아웃</a></li>
                            <li><a href="<%=path1 %>/member/mypage.jsp">마이페이지</a></li>
                            <li><a href="map.jsp">오시는길</a></li>
                            <% if(sid.equals("admin")) { %>
                            <li><a href="<%=path1 %>/admin/index.jsp">관리자페이지로</a></li>
                            <% } %>
                            <% } else { %>
                            <li><a href="<%=path1 %>/member/login.jsp">로그인</a></li>
                            <li><a href="<%=path1 %>/member/term.jsp">회원가입</a></li>
                            <li><a href="map.jsp">오시는길</a></li>
                            <% } %>
                        </ul>
                    </nav>
                </ul>
            </nav>
        </div>
        <div class="hd_wrap">
            <!-- nav.gnb>ul.menu>li.item$*5>a.dp1{메인$}+(ul.sub>li*4>a{서브$$}) -->
            <nav class="gnb">
                <ul class="menu">
                    <li class="item1">
                        <a href="" class="dp1">회사소개</a>
                        <ul class="sub">
                            <li><a href="">서브01</a></li>
                            <li><a href="">서브02</a></li>
                            <li><a href="">서브03 서브03 서브03 서브03 서브03</a></li>
                            <li><a href="">서브04</a></li>
                        </ul>
                    </li>
                    <li class="item2">
                        <a href="" class="dp1">인사말</a>
                        <ul class="sub">
                            <li><a href="">서브01</a></li>
                            <li><a href="">서브02</a></li>
                            <li><a href="">서브03</a></li>
                            <li><a href="">서브04</a></li>
                        </ul>
                    </li>
                    <li class="item3">
                        <a href="" class="dp1">사업소개</a>
                        <ul class="sub">
                            <li><a href="">서브01</a></li>
                            <li><a href="">서브02</a></li>
                            <li><a href="">서브03</a></li>
                            <li><a href="">서브04</a></li>
                        </ul>
                    </li>
                    <li class="item4">
                        <a href="" class="dp1">홍보</a>
                        <ul class="sub">
                            <li><a href="">서브01</a></li>
                            <li><a href="">서브02</a></li>
                            <li><a href="">서브03</a></li>
                            <li><a href="">서브04</a></li>
                        </ul>
                    </li>
                    <li class="item5">
                        <a href="" class="dp1">커뮤니티</a>
                        <ul class="sub">
                            <li><a href="/board/boardList.jsp">공지사항</a></li>
                            <li><a href="">서브02</a></li>
                            <li><a href="">서브03</a></li>
                            <li><a href="">서브04</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </header>
    <div class="contents">
        <figure class="vs">
            <h2 class="vs_tit">배너 제목</h2>
        </figure>
    </div>
    <footer class="ft">
        <div class="ft_wrap"></div>
    </footer>
</div>