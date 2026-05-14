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
        <a href="zy.jsp">访问统计</a>
        <a href="dl.jsp">登录</a>
        <a href="sj.jsp">书籍</a>
    </div>
    <div class="login-container">
        <h2>登录</h2>
        <form action="dl.jsp" method="post">
            <div class="form-item">
                <label>账号：</label>
                <input type="text" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
            </div>
            <div class="form-item">
                <label>密码：</label>
                <input type="password" name="password" value="<%= request.getParameter("password") != null ? request.getParameter("password") : "" %>">
            </div>
            <div class="button-container">
                <button type="submit">登录</button>
            </div>
        </form>
        <div class="result">
            <% 
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                
                if (username != null && password != null) {
                    if ("jk174".equals(username) && "146908".equals(password)) {
                        // 保存到Session
                        session.setAttribute("username", username);
                        session.setAttribute("password", password);
                        
                        // 保存到Cookie，有效期1天
                        Cookie usernameCookie = new Cookie("username", username);
                        usernameCookie.setMaxAge(24 * 60 * 60); // 1天
                        response.addCookie(usernameCookie);
                        
                        Cookie passwordCookie = new Cookie("password", password);
                        passwordCookie.setMaxAge(24 * 60 * 60); // 1天
                        response.addCookie(passwordCookie);
                        
                        // 重定向到dl_result.jsp
                        response.sendRedirect("dl_result.jsp");
                    } else {
                        out.println("<p style='color: red;'>账号或密码错误！</p>");
                    }
                }
            %>
        </div>
    </div>
</body>
</html>