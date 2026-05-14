<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>诗词欣赏网</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 20px;
        }
        .header h1 {
            margin: 0;
        }
        .divider {
            height: 5px;
            background-color: #4CAF50;
        }
        .nav {
            background-color: #f8f8f8;
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        .nav a {
            margin: 0 10px;
            text-decoration: none;
            color: #333;
            font-size: 14px;
        }
        .nav a:hover {
            color: #4CAF50;
        }
        .search-form {
            margin: 20px auto;
            text-align: center;
            padding: 20px;
            background-color: white;
            width: 80%;
            max-width: 600px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .search-form input[type="text"] {
            padding: 8px;
            width: 200px;
            margin-right: 10px;
        }
        .search-form button {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .search-form button:hover {
            background-color: #45a049;
        }
        .result {
            text-align: center;
            margin-top: 20px;
        }
        table {
            border-collapse: collapse;
            width: 80%;
            max-width: 800px;
            margin: 20px auto;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>诗词欣赏网</h1>
    </div>
    <div class="divider"></div>
    <div class="nav">
        <a href="index.jsp">首页</a>
        <a href="#">诗人</a>
        <a href="#">古诗</a>
        <a href="#">诗句</a>
        <a href="#">古籍</a>
        <a href="#">文言文</a>
        <a href="#">鉴赏</a>
        <a href="#">二十四史</a>
        <a href="#">书籍</a>
        <a href="#">注册</a>
        <a href="login.jsp">登录</a>
    </div>
    <div class="search-form">
        <form action="index.jsp" method="post">
            书号：<input type="text" name="bookId">
            <button type="submit">查询</button>
        </form>
    </div>
    <div class="result">
        <% 
            String bookId = request.getParameter("bookId");
            if (bookId != null && !bookId.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/1?useSSL=false&serverTimezone=UTC&characterEncoding=utf8mb4&useUnicode=true", "root", "x8");
                    
                    // 创建book表（如果不存在）
                    java.sql.Statement stmt = conn.createStatement();
                    String createTableSQL = "CREATE TABLE IF NOT EXISTS book (" +
                        "bookid VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY, " +
                        "bookname VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, " +
                        "author VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, " +
                        "pub VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci" +
                        ") DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
                    stmt.executeUpdate(createTableSQL);
                    stmt.close();
                    
                    java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM book WHERE bookid = ?");
                    ps.setString(1, bookId);
                    java.sql.ResultSet rs = ps.executeQuery();
                    
                    if (rs.next()) {
                        out.println("<h3>查询结果</h3>");
                        out.println("<table border='1'>");
                        out.println("<tr><th>书号</th><th>书名</th><th>作者</th><th>出版社</th></tr>");
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("bookid") + "</td>");
                        out.println("<td>" + rs.getString("bookname") + "</td>");
                        out.println("<td>" + rs.getString("author") + "</td>");
                        out.println("<td>" + rs.getString("pub") + "</td>");
                        out.println("</tr>");
                        out.println("</table>");
                    } else {
                        out.println("<p>未找到该图书信息</p>");
                    }
                    
                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>查询失败：" + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>