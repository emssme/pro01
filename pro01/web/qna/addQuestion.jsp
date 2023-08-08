<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
</head>
<body>
<form action="addQuestion.jsp" method="post">
    <table class="btn">
        <tbody>
        <tr>
            <th><label for="title">글제목</label></th>
            <td>
                <input type="text" name="title" id="title" class="indata" required>
                <input type="hidden" name="author" id="author" value="<%=sid %>">
            </td>
        </tr>
        <tr>
            <th>글내용</th>
            <td><textarea name="content" id="content" cols="80" rows="10" maxlength="990" required></textarea></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="글쓰기" class="inbtn">
                <input type="reset" value="취소" class="inbtn">
            </td>
        </tr>
        </tbody>
    </table>
</form>
</body>
</html>