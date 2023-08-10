<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.chunjae.util.*"%>
<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*"%>

<%@ include file="../encoding.jsp"%>

<%
    //3. 보내온 이메일 데이터 받기
    String name = request.getParameter("name");
    String from = request.getParameter("author");
    String email = request.getParameter("from");    //보내는 사람 이메일
    String tel = request.getParameter("tel");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String to = "bkyoung123@naver.com"; //받는 사람 이메일

    //4. smtp 설정 -> Properties 활용
    Properties p = new Properties();
    p.put("mail.smtp.host","smtp.naver.com");                                   //smtp 서버명
    p.put("mail.smtp.port","465");                                              //smtp 포트번호
    p.put("mail.smtp.starttles.enable","true");                                 //smtp 시작시 알려주게 설정
    p.put("mail.smtp.auth","true");                                             //smtp 인증 설정
    p.put("mail.smtp.debug","true");                                            //smtp 디버그 설정
    p.put("mail.smtp.socketFactory.port","465");                                //smtp 소켓 포트 설정
    p.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");    //smtp 소켓 ssl 설정
    p.put("mail.smtp.socketFactory.fallback","false");                          //smtp 소켓 fallback 설정

    //5. 이메일 보내기
    try{
        Authenticator auth = new SMTPAuthenticator();
        Session ses = Session.getInstance(p, auth);

        ses.setDebug(true);
        MimeMessage msg = new MimeMessage(ses);

        msg.setSubject(title);  //제목

        StringBuffer buffer = new StringBuffer();   //이메일 내용
        buffer.append("보내는 사람: ");
        buffer.append(name+"\n");
        buffer.append("연락처: ");
        buffer.append(tel+"\n");
        buffer.append("이메일: ");
        buffer.append(email+"\n");
        buffer.append("제목: ");
        buffer.append(title+"\n");
        buffer.append("내용: ");
        buffer.append(content+"\n");

        Address fromAddr = new InternetAddress(from);   //보내는 사람
        msg.setFrom(fromAddr);

        Address toAddr = new InternetAddress(to);   //받는 사람
        msg.addRecipient(Message.RecipientType.TO, toAddr);

        msg.setContent(buffer.toString(), "text/html; charset=UTF-8");

        Transport.send(msg);    //전송
    } catch (Exception e){
        e.printStackTrace();
    }finally {
        response.sendRedirect("/index.jsp");
    }



%>