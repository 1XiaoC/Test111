<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>添加图书信息</title>
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
        .container {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .container h2 {
            text-align: center;
            color: #333;
        }
        .form-item {
            margin-bottom: 15px;
        }
        .form-item label {
            display: inline-block;
            width: 80px;
            font-weight: bold;
        }
        .form-item input[type="text"] {
            padding: 8px;
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        .button-container button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .button-container button:hover {
            background-color: #45a049;
        }
        .result {
            margin-top: 20px;
            padding: 10px;
            text-align: center;
            border-radius: 3px;
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
    <div class="container">
        <h2>添加图书信息</h2>
        <form action="add_book.jsp" method="post">
            <div class="form-item">
                <label>书号：</label>
                <input type="text" name="bookId" required>
            </div>
            <div class="form-item">
                <label>书名：</label>
                <input type="text" name="bookName" required>
            </div>
            <div class="form-item">
                <label>作者：</label>
                <input type="text" name="author" required>
            </div>
            <div class="form-item">
                <label>出版社：</label>
                <input type="text" name="pub" required>
            </div>
            <div class="button-container">
                <button type="submit">添加</button>
            </div>
        </form>
        <div class="result">
            <% 
                String bookId = request.getParameter("bookId");
                String bookName = request.getParameter("bookName");
                String author = request.getParameter("author");
                String pub = request.getParameter("pub");
                
                if (bookId != null && !bookId.isEmpty()) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/1?useSSL=false&serverTimezone=UTC&characterEncoding=utf8&useUnicode=true", "root", "x8");
                        
                        // 先删除旧表，然后创建新表以确保字符集设置生效
                        java.sql.Statement stmt = conn.createStatement();
                        try {
                            stmt.executeUpdate("DROP TABLE IF EXISTS book");
                        } catch (Exception e) {
                            // 忽略删除表的错误
                        }
                        String createTableSQL = "CREATE TABLE book (" +
                            "bookid VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY, " +
                            "bookname VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, " +
                            "author VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, " +
                            "pub VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci" +
                            ") DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
                        stmt.executeUpdate(createTableSQL);
                        stmt.close();
                        
                        // 插入数据
                        java.sql.PreparedStatement ps = conn.prepareStatement("INSERT INTO book (bookid, bookname, author, pub) VALUES (?, ?, ?, ?)");
                        ps.setString(1, bookId);
                        ps.setString(2, bookName);
                        ps.setString(3, author);
                        ps.setString(4, pub);
                        
                        int rows = ps.executeUpdate();
                        if (rows > 0) {
                            out.println("<p style='color: green;'>添加成功！</p>");
                        } else {
                            out.println("<p style='color: red;'>添加失败！</p>");
                        }
                        
                        ps.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p style='color: red;'>添加失败：" + e.getMessage() + "</p>");
                    }
                }
            %>
        </div>
    </div>
</body>
</html>