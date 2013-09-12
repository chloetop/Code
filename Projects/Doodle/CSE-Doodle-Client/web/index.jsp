<%
    session.setAttribute("Uid", "");
    session.setAttribute("Url", "http://localhost:8080/CSE-Doodle/REST/");
    RequestDispatcher rd = request.getRequestDispatcher("Welcome.jsp");
    rd.forward(request, response);
%>
