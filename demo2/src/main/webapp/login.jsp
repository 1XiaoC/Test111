<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录</title>
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
        .login-container {
            max-width: 400px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .login-container h2 {
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
        .form-item input[type="text"],
        .form-item input[type="password"] {
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
    <div class="login-container">
        <h2>登录</h2>
        <form action="dl_result.jsp" method="post">
            <div class="form-item">
                <label>账号：</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-item">
                <label>密码：</label>
                <input type="password" name="password" required>
            </div>
            <div class="button-container">
                <button type="submit">登录</button>
            </div>
        </form>
    </div>
</body>
</html>