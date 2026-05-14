<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>书籍列表</title>
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
        .book-list {
            margin-top: 20px;
        }
        .book-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #f9f9f9;
        }
        .book-item h3 {
            margin: 0 0 10px 0;
            color: #4CAF50;
        }
        .book-item p {
            margin: 5px 0;
        }
        .book-item .price {
            font-weight: bold;
            color: #f44336;
        }
        .book-item form {
            margin-top: 10px;
        }
        .book-item button {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .book-item button:hover {
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
        <a href="gwc.jsp">购物车</a>
    </div>
    <div class="container">
        <h2>书籍列表</h2>
        <div class="book-list">
            <!-- 书籍1 -->
            <div class="book-item">
                <h3>唐诗三百首</h3>
                <p>作者：蘅塘退士</p>
                <p>出版社：中华书局</p>
                <p class="price">价格：39.9元</p>
                <form action="sj.jsp" method="post">
                    <input type="hidden" name="bookId" value="1">
                    <input type="hidden" name="bookName" value="唐诗三百首">
                    <input type="hidden" name="author" value="蘅塘退士">
                    <input type="hidden" name="price" value="39.9">
                    <button type="submit" name="action" value="add">加入购物车</button>
                </form>
            </div>
            
            <!-- 书籍2 -->
            <div class="book-item">
                <h3>宋词选</h3>
                <p>作者：钱钟书</p>
                <p>出版社：人民文学出版社</p>
                <p class="price">价格：45.5元</p>
                <form action="sj.jsp" method="post">
                    <input type="hidden" name="bookId" value="2">
                    <input type="hidden" name="bookName" value="宋词选">
                    <input type="hidden" name="author" value="钱钟书">
                    <input type="hidden" name="price" value="45.5">
                    <button type="submit" name="action" value="add">加入购物车</button>
                </form>
            </div>
            
            <!-- 书籍3 -->
            <div class="book-item">
                <h3>古文观止</h3>
                <p>作者：吴楚材</p>
                <p>出版社：上海古籍出版社</p>
                <p class="price">价格：42.0元</p>
                <form action="sj.jsp" method="post">
                    <input type="hidden" name="bookId" value="3">
                    <input type="hidden" name="bookName" value="古文观止">
                    <input type="hidden" name="author" value="吴楚材">
                    <input type="hidden" name="price" value="42.0">
                    <button type="submit" name="action" value="add">加入购物车</button>
                </form>
            </div>
        </div>
        
        <div class="result">
            <% 
                // 处理添加到购物车的请求
                // 处理中文编码问题
                request.setCharacterEncoding("UTF-8");
                String action = request.getParameter("action");
                if ("add".equals(action)) {
                    String bookId = request.getParameter("bookId");
                    String bookName = request.getParameter("bookName");
                    String author = request.getParameter("author");
                    String price = request.getParameter("price");
                    
                    // 从Session中获取购物车
                    java.util.List<java.util.Map<String, String>> cart = (java.util.List<java.util.Map<String, String>>) session.getAttribute("cart");
                    if (cart == null) {
                        cart = new java.util.ArrayList<java.util.Map<String, String>>();
                        session.setAttribute("cart", cart);
                    }
                    
                    // 创建书籍对象
                    java.util.Map<String, String> book = new java.util.HashMap<String, String>();
                    book.put("id", bookId);
                    book.put("name", bookName);
                    book.put("author", author);
                    book.put("price", price);
                    
                    // 添加到购物车
                    cart.add(book);
                    session.setAttribute("cart", cart);
                    
                    out.println("<p style='color: green;'>" + bookName + " 已成功加入购物车！</p>");
                }
            %>
        </div>
    </div>
</body>
</html>