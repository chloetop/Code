<%-- 
    Document   : Add
    Created on : 2012-3-24, 14:43:49
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
response.setContentType("text/html;charset=UTF-8");

            String sType = request.getParameter("sType");
            String val = request.getParameter("val");
            if (sType.equals("r1")) {
                String Session_al = (String) request.getSession().getAttribute("Albums");
                if (!"".equals(Session_al)) {
                    session.setAttribute("Albums", Session_al+val);
                } else {
                    session.setAttribute("Albums", val);
                }
            }
            if (sType.equals("r2")) {
                String Session_sg = (String) request.getSession().getAttribute("Songs");
                if (!"".equals(Session_sg)) {
                    session.setAttribute("Songs", Session_sg+val);
                } else {
                    session.setAttribute("Songs", val);
                }
                
               
            }

        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
