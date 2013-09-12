<%
response.setContentType("text/html;charset=UTF-8");
session.invalidate();

 RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
	     rd.forward(request, response);

%>
