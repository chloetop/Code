<%@page import="java.io.PrintWriter"%>
<%
    String type = request.getParameter("type");
    PrintWriter pout = response.getWriter();
    if ("1".equals(type)) {
        String Uid = request.getParameter("Uid");
        session.setAttribute("Uid", Uid);
        session.setAttribute("Url", "http://localhost:8080/CSE-Doodle/REST/");
        pout.println(session.getAttribute("Uid"));
    }
    if ("2".equals(type)) {
        pout.println(session.getAttribute("Uid").toString().trim());
    }

%>
