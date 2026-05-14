<%@ page import="java.util.List,beans.Book,dao.BookDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书籍信息列表</title>
    <style>
        table{border-collapse: collapse;width: 600px;margin: 20px auto;}
        td,th{border:1px solid #333;padding: 8px;text-align: center;}
        th{background:#f0f0f0;}
    </style>
</head>
<body>
<h2 align="center">书籍信息列表（JSP+DAO+VO）</h2>
<table>
    <tr>
        <th>编号</th>
        <th>书名</th>
        <th>出版社</th>
        <th>价格</th>
    </tr>
    <%
        BookDAO bookDAO = new BookDAO();
        List<Book> bookList = bookDAO.findAllBooks();
        for(Book book : bookList){
    %>
    <tr>
        <td><%=book.getId()%></td>
        <td><%=book.getName()%></td>
        <td><%=book.getPublish()%></td>
        <td><%=book.getPrice()%></td>
    </tr>
    <% } %>
</table>
</body>
</html>