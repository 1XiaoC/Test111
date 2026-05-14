<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录结果</title>
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
        .content {
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }
        .content h2 {
            color: #333;
        }
        .content p {
            font-size: 16px;
            line-height: 1.5;
        }
        .content a {
            color: #4CAF50;
            text-decoration: none;
        }
        .content a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>登录结果</h1>
    </div>
    <div class="divider"></div>
    <div class="nav">
        <a href="add_book.jsp">添加</a>
        <a href="update_book.jsp">修改</a>
        <a href="delete_book.jsp">删除</a>
        <a href="index.jsp">返回首页</a>
    </div>
    <div class="content">
        <% 
            // 验证Session，防止非法访问
            String sessionUsername = (String) session.getAttribute("username");
            String sessionPassword = (String) session.getAttribute("password");
            
            if (sessionUsername == null || sessionPassword == null || !"jk174".equals(sessionUsername) || !"146908".equals(sessionPassword)) {
                // 未登录或登录信息不正确，重定向到登录页面
                response.sendRedirect("dl.jsp");
                return;
            }
            
            out.println("<h2>登录成功！</h2>");
            out.println("<p>欢迎使用图书管理系统</p>");
            out.println("<p>登录账号：" + sessionUsername + "</p>");
        %>
    </div>
</body>
</html>