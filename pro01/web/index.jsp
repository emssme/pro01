<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>천재교육</title>
    <%@ include file="head.jsp" %>

    <!-- 스타일 초기화 : reset.css 또는 normalize.css -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">

    <!-- 필요한 폰트를 로딩 : 구글 웹 폰트에서 폰트를 선택하여 해당 내용을 붙여 넣기 -->
    <link rel="stylesheet" href="google.css">
    <link rel="stylesheet" href="fonts.css">

    <!-- 필요한 플러그인 연결 -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <link rel="stylesheet" href="common.css">
    <link rel="stylesheet" href="hd.css">
    <style>
        /* 본문 영역 스타일 */
        .contents { clear:both; }
        .contents::after { content:""; clear:both; display:block; width:100%; }
        .vs { clear:both; width:100%; min-height:600px; background-color: deeppink;
            position:relative; overflow:hidden; }
        .img_box { position:relative; width: 100%; height:600px; overflow:hidden; }
        .img_box li { visibility:hidden; opacity:0;  transition-duration:0.7s;
            transition-delay:0.1s;    width:100%; height:600px;  }
        .img_box li .bg_box { width:100vw; height:600px; background-repeat: no-repeat;
            background-position:center center; background-size:cover; position:absolute;
            left: 0; top: 0; z-index:5; }
        .img_box li.active .bg_box { z-index:6; }
        .img_box li.item1 .bg_box { background-image: url("./images/education01.jpg"); }
        .img_box li.item2 .bg_box { background-image: url("./images/education02.jpg"); }
        .img_box li .vs_tit { position:absolute; top:180px; left:100px; z-index:10;
            font-weight: 300; font-size: 60px; line-height: 1.3; }
        .img_box li .vs_tit strong { font-weight: 500; }

        .img_box li.active { visibility: visible; opacity: 1; }
        .vs_tit { font-size:60px; color:#fff; }
        .btn_box li .vs_btn { display:block; width: 12px; height: 12px;
            background-color:rgba(255,255,255,0.8); border:2px solid #fff;
            position:absolute; top:100px; left: 100px; z-index:14; cursor:pointer;
            border-radius:50%; }
        .btn_box li.item2 .vs_btn { left: 132px; }
        .btn_box li.active .vs_btn { background-color: #fff; border:2px solid #333; }
        .vs_ra { display:none; }

        .play_btn { display:block; width: 12px; height: 12px; position:absolute;
            top:98px; left: 164px; z-index:14; cursor:pointer; color: #fff;
            border:0;  background-color: transparent; font-weight: 900; }
        .play_btn:after { content:"| |"; }
        .play_btn.active:after { content:"▶"; }

        .page { clear:both; width: 100vw; height: 100vh; position:relative; }
        .page::after { content:""; display:block; width: 100%; clear:both; }

        .page_wrap { clear:both; width: 1200px; height: auto; margin:0 auto; }
        .page_tit { font-size:48px; text-align: center; padding-top:1.75em; }

        #page1 { background-color: #f1f2f1;
            background-image:url("./images/education03.jpg");
            background-position:15vw 63vh; background-repeat: no-repeat; }

        .pic_lst { clear:both; width: 1200px; margin: 60px auto; }
        .pic_lst li { width: 280px; margin-right:26px; height: 400px; float:left;
            background-repeat: no-repeat; background-position:center center;
            filter:brightness(90%); margin-top:30px; transition:0.4s;
            box-shadow:12px 12px 12px #999; overflow:hidden;  }
        .pic_lst li:hover { filter:brightness(140%); margin-top: -10px; }
        .pic_lst li a { display:block; width: 256px; height: 376px; margin: 11px;
            border:1px solid #fff; color:#fff; }
        .pic_lst li:last-child { margin-right: 0; }
        .pic_lst li.item1 { background-image: url("./images/education04.jpg"); }
        .pic_lst li.item2 { background-image: url("./images/education05.jpg"); }
        .pic_lst li.item3 { background-image: url("./images/education06.jpg"); }
        .pic_lst li.item4 { background-image: url("./images/education07.jpg"); }
        .pic_com { padding-left: 20px; padding-top: 20px; font-size:14px; }
        .pic_tit { padding-left: 20px; padding-top: 20px; font-size:18px; }
        .pic_arrow { display:block; width:110px; height:10px; border-bottom:1px solid #fff;
            margin-top: 20px; margin-left: -12px; transition:0.4s; position:relative; }
        .pic_lst li:hover a .pic_arrow { margin-left:20px; }
        .pic_arrow::after { content:""; display:block; width: 10px; height: 10px;
            position:absolute; right:0; top: 0; border-bottom:1px solid #fff; transform-origin:100% 100%;
            transform:rotate(45deg); display:none; }
        .pic_lst li:hover a .pic_arrow::after { display:block; }

        #page2 .page_wrap { width: 100%; }
        .slide_box::-webkit-scrollbar { display:none; }
        .slide_box { clear:both; width:calc(100vw - 350px); height:400px;
            margin-left: 350px;  -ms-overflow-style:none;
            scrollbar-width:none; }

        .page_com { text-align: center; padding-bottom: 30px; padding-top: 30px;  }
        .card_lst { width: 4000px; }
        .card_lst > li { width: 320px; height: 400px; float:left; margin-right: 50px;
            box-shadow:5px 5px 30px #888; border-radius:6px; overflow: hidden; }
        .card_lst > li:first-child { margin-left: 30px; }

        .card_lst li .thumb_box { width: 320px; height: 210px;
            background-repeat: no-repeat; background-position: center center;
            background-size: cover; }
        .card_lst li a { display:block; width: 320px; height: 220px; }
        .card_lst li.item2 .thumb_box { background-image: url("./images/education08.jpg"); }
        .card_lst li.item3 .thumb_box { background-image: url("./images/education09.jpg"); }
        .card_lst li.item4 .thumb_box { background-image: url("./images/education10.jpg"); }
        .card_lst li.item5 .thumb_box { background-image: url("./images/education11.jpg"); }
        .card_lst li.item6 .thumb_box { background-image: url("./images/education12.jpg"); }
        .card_lst li.item7 .thumb_box { background-image: url("./images/education01.jpg"); }

        .thumb_tit { height: 42px; box-sizing:border-box; font-size: 14px; color:#333; padding:14px; padding-bottom: 0; text-overflow: ellipsis;
            overflow:hidden; display:-webkit-box; -webkit-box-orient: vertical; -webkit-line-clamp:2;
            margin-bottom: 60px; }

        .ico_box { height: 53px; clear:both; margin-top: 30px; border-top:1px solid #eee;
            padding-top:30px; }
        .ico { display:block; width: 30px; height: 30px;
            background-image: url("./images/iconset.png"); background-repeat: no-repeat;
            float:left; margin-left: 14px; }
        .thumb_date { float:right; margin-right: 14px;  }
        .ico.item1 { background-position:-71px -60px; }
        .ico.item2 { background-position:-142px -121px; }

        .cate_tit { padding-left: 32px; font-size: 36px; line-height: 2; padding-top: 24px;
            padding-bottom: 24px; }
        .cate_lst li { border-top:1px solid #333; margin-left: 14px; margin-right: 14px;
            padding-top: 32px; height: 90px;  }
        .cate_tit li a { display:block; }
        .bd_content { width:auto; padding-right: 24px; }
        .bd_date { padding-top: 18px; }

        .sl-btn-box .btn { display:block; width: 48px; height: 48px; font-size:32px;
            color:#fff; background-color:#333; text-align: center; line-height: 48px;
            font-weight: 700; cursor:pointer; position:absolute; left:100px; }
        .sl-btn-box .btn.next { top:100px; }
        .sl-btn-box .btn.prev { top:148px; }
    </style>

    <link rel="stylesheet" href="ft.css">
</head>
<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="header.jsp" %>
    </header>
    <div class="contents">
        <figure class="vs">
            <ul class="img_box">
                <li class="item1 active">
                    <input type="radio" name="vs_ra" id="vs_ra1" class="vs_ra" checked>
                    <div class="bg_box"></div>
                    <h2 class="vs_tit">교육에 대한 끊임없는 도전<br>
                        <strong>행복한 내일을 함께 합니다</strong></h2>
                </li>
                <li class="item2">
                    <input type="radio" name="vs_ra" id="vs_ra2" class="vs_ra">
                    <div class="bg_box"></div>
                    <h2 class="vs_tit">“나눔의 힘! 실천의 힘!”<br>
                        <strong>작은 따뜻함으로 세상을 <br>바꿉니다</strong>
                    </h2>
                </li>
            </ul>
            <ul class="btn_box">
                <li class="item1 active"><label for="vs_ra1" class="vs_btn"></label></li>
                <li class="item2"><label for="vs_ra2" class="vs_btn"></label></li>
            </ul>
            <button type="button" class="play_btn"></button>
        </figure>
        <script>
            $(function(){
                $(".btn_box li .vs_btn").click(function(){
                    var par = $(this).parents("li").index();
                    $(".img_box li").removeClass("active");
                    $(".img_box li").eq(par).addClass("active");
                    $(".btn_box li").removeClass("active");
                    $(".btn_box li").eq(par).addClass("active");
                });
                var sw = 1;
                var int1 = setInterval(function(){
                    if(sw==1){
                        autoplay(1);
                        sw = 0;
                    } else {
                        autoplay(0);
                        sw = 1;
                    }
                }, 3500);

                function autoplay(n){
                    $(".img_box li").removeClass("active");
                    $(".img_box li").eq(n).addClass("active");
                    $(".btn_box li").removeClass("active");
                    $(".btn_box li").eq(n).addClass("active");
                }

                $(".play_btn").click(function(){
                    if($(this).hasClass("active")){
                        $(this).removeClass("active");
                        sw = 1;
                        int1 = setInterval(function(){
                            if(sw==1){
                                autoplay(1);
                                sw = 0;
                            } else {
                                autoplay(0);
                                sw = 1;
                            }
                        }, 3500);
                    } else {
                        $(this).addClass("active");
                        sw = 0;
                        clearInterval(int1);
                    }
                });
            });
        </script>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">페이지 제목1</h2>
                <ul class="pic_lst">
                    <li class="item1">
                        <a href="">
                            <p class="pic_com">설명</p>
                            <h3 class="pic_tit">제목</h3>
                            <span class="pic_arrow"></span>
                        </a>
                    </li>
                    <li class="item2">
                        <a href="">
                            <p class="pic_com">설명</p>
                            <h3 class="pic_tit">제목</h3>
                            <span class="pic_arrow"></span>
                        </a>
                    </li>
                    <li class="item3">
                        <a href="">
                            <p class="pic_com">설명</p>
                            <h3 class="pic_tit">제목</h3>
                            <span class="pic_arrow"></span>
                        </a>
                    </li>
                    <li class="item4">
                        <a href="">
                            <p class="pic_com">설명</p>
                            <h3 class="pic_tit">제목</h3>
                            <span class="pic_arrow"></span>
                        </a>
                    </li>
                </ul>
            </div>
        </section>
        <section class="page" id="page2">
            <div class="page_wrap">
                <h2 class="page_tit">미디어</h2>
                <p class="page_com">천재교육의 보도자료와 SNS 콘텐츠를 소개합니다.</p>
                <div class="sl-btn-box">
                    <button type="button" class="btn next">&gt;</button>
                    <button type="button" class="btn prev">&lt;</button>
                </div>
                <!-- div.slide_box>ul.card_lst>li.item$*7>a>div.thumb_box+p.thumb_tit{썸네일제목$}+(div.ico_box>span.ico_item+span{아이콘$}.thumb_date{2023-07-18}) -->
                <div class="slide_box">
                    <ul class="card_lst">
                        <li class="item1">
                            <h3 class="cate_tit">언론보도</h3>
                            <ul class="cate_lst">
                                <li>
                                    <a href="">
                                        <p class="bd_content">운필력 키우는 한글 글쓰기, 유아학습지로 창의력과 표현력을 기른다.</p>
                                        <p class="bd_date">2023-07-17</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <p class="bd_content">천재교과서, 스마트해법-밀크T 온·오프라인 결합 상품 더블케어 천재패스 출시</p>
                                        <p class="bd_date">2023-07-17</p>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="item2">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2썸네일제목2 썸네일제목2 썸네일제목2 썸네일제목2썸네일제목2썸네일제목2 썸네일제목2 </p>
                                <div class="ico_box"><span class="ico item1"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item3">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목3</p>
                                <div class="ico_box"><span class="ico item1"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item4">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목4</p>
                                <div class="ico_box"><span class="ico item2"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item5">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목5</p>
                                <div class="ico_box"><span class="ico item1"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item6">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목6</p>
                                <div class="ico_box"><span class="ico item2"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                        <li class="item7">
                            <a href="">
                                <div class="thumb_box"></div>
                                <p class="thumb_tit">썸네일제목7</p>
                                <div class="ico_box"><span class="ico item1"></span><span class="thumb_date">2023-07-18</span></div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </section>
        <script>
            $(function(){
                $(".sl-btn-box .btn.next").click(function(){
                    var ln = parseInt($(".card_lst").css("margin-left"));
                    if(ln>-1110) {
                        var mv = ln - 370;
                        $(".card_lst").not(":animated").animate({"margin-left":mv+"px"});
                    }
                });
                $(".sl-btn-box .btn.prev").click(function(){
                    var ln = parseInt($(".card_lst").css("margin-left"));
                    if(ln<0){
                        var mv = ln + 370;
                        $(".card_lst").not(":animated").animate({"margin-left":mv+"px"});
                    }
                });
            });
        </script>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="footer.jsp" %>
    </footer>
</div>
</body>
</html>