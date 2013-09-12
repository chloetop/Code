<%@page import="java.sql.ResultSet"%>
<%@page import="PublicClass.DataBase"%>
<%
String orderid = request.getParameter("orderid").trim();
 DataBase db = new DataBase();
        ResultSet rs;
        rs = db.ExecuteSQL("delete orders where Oid='"+orderid+"'");
        response.sendRedirect("clear.jsp?from=");
         
%>
