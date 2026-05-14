<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>访问统计</title>
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
            font-size: 18px;
            line-height: 1.5;
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
        <a href="zy.jsp">访问统计</a>
        <a href="dl.jsp">登录</a>
        <a href="sj.jsp">书籍</a>
    </div>
    <div class="content">
        <h2>访问统计</h2>
        <% 
            // 使用application对象统计访问人数
            Integer count = (Integer) application.getAttribute("visitCount");
            if (count == null) {
                count = 0;
            }
            count++;
            application.setAttribute("visitCount", count);
        %>
        <p>您是第 <strong style="color: #4CAF50; font-size: 24px;"><%= count %></strong> 个访问本网站的用户</p>
        <p>感谢您的访问！</p>
    </div>
</body>
</html>