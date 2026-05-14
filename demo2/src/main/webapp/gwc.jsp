<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>购物车</title>
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
            max-width: 800px;
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
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .cart-table th,
        .cart-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .cart-table th {
            background-color: #4CAF50;
            color: white;
        }
        .cart-table tr:hover {
            background-color: #f5f5f5;
        }
        .cart-total {
            margin-top: 20px;
            text-align: right;
            font-size: 18px;
            font-weight: bold;
        }
        .cart-actions {
            margin-top: 20px;
            text-align: center;
        }
        .cart-actions button {
            padding: 10px 20px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .cart-actions button:hover {
            background-color: #da190b;
        }
        .empty-cart {
            text-align: center;
            padding: 40px;
            color: #999;
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
        <a href="gwc.jsp">购物车</a>
    </div>
    <div class="container">
        <h2>购物车</h2>
        
        <% 
            // 处理中文编码问题
            request.setCharacterEncoding("UTF-8");
            // 处理清空购物车的请求
            String action = request.getParameter("action");
            if ("clear".equals(action)) {
                session.removeAttribute("cart");
                out.println("<p style='color: green; text-align: center;'>购物车已清空！</p>");
            }
            
            // 从Session中获取购物车
            java.util.List<java.util.Map<String, String>> cart = (java.util.List<java.util.Map<String, String>>) session.getAttribute("cart");
            
            if (cart == null || cart.isEmpty()) {
        %>
            <div class="empty-cart">
                <p>购物车是空的，快去添加书籍吧！</p>
                <a href="sj.jsp">去选书</a>
            </div>
        <% 
            } else {
        %>
            <table class="cart-table">
                <tr>
                    <th>序号</th>
                    <th>书籍名称</th>
                    <th>作者</th>
                    <th>价格</th>
                </tr>
                <% 
                    double totalPrice = 0;
                    for (int i = 0; i < cart.size(); i++) {
                        java.util.Map<String, String> book = cart.get(i);
                        String priceStr = book.get("price");
                        double price = Double.parseDouble(priceStr);
                        totalPrice += price;
                %>
                <tr>
                    <td><%= i + 1 %></td>
                    <td><%= book.get("name") %></td>
                    <td><%= book.get("author") %></td>
                    <td>¥<%= price %></td>
                </tr>
                <% } %>
            </table>
            <div class="cart-total">
                总计：¥<%= totalPrice %>
            </div>
            <div class="cart-actions">
                <form action="gwc.jsp" method="post">
                    <button type="submit" name="action" value="clear">清空购物车</button>
                </form>
            </div>
        <% } %>
    </div>
</body>
</html>