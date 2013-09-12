<%
    session.setAttribute("Albums", "");
    session.setAttribute("Songs", "");
    RequestDispatcher rd = request.getRequestDispatcher("AFindex.jsp");
    rd.forward(request, response);
%>
