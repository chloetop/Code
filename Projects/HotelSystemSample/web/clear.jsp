<%
    response.setContentType("text/html;charset=UTF-8");
    session.invalidate();
    String from = request.getParameter("from");
    
    RequestDispatcher rd = null;
    if ("o".equals(from)) {
        rd = request.getRequestDispatcher("owner_index.jsp");
        
    } else if ("m".equals(from)) {
        rd = request.getRequestDispatcher("manager_index.jsp");
       
    } else {
        rd = request.getRequestDispatcher("index.jsp");
       
    }
    rd.forward(request, response);
%>
