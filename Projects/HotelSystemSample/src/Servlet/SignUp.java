/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package MyServlet;

import PublicClass.DataBase;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Administrator
 */
public class SignUp extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /*
             * TODO output your page here. You may use following sample code.
             */
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SignUp</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUp at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("okokokokokokok");
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            out.println("start");
            String C_ID = request.getParameter("id").trim();
            String C_NAME = request.getParameter("name").trim();
            String C_EMAIL = request.getParameter("id").trim();
            String C_PHONE = request.getParameter("phone").trim();
            String PASSWORD = request.getParameter("pwd").trim();
            int Role = 1; //consumer

            DataBase db = new DataBase();
            //String sql = "INSERT INTO USERS( ROLE ,ID ,PASSWORD) VALUES('" + Role + "' ,'" + C_ID + "' ,'" + PASSWORD + "');";
            String sql = "INSERT INTO Users ( ROLE ,ID ,PASSWORD) VALUES(" + Role + " ,'" + C_ID + "' ,'" + PASSWORD + "')";
            String sql2 = "INSERT INTO Consumer ( C_ID ,C_NAME ,C_EMAIL,C_PHONE) VALUES('" + C_ID + "' ,'" + C_NAME + "' ,'" + C_EMAIL + "','" + C_PHONE + "')";
            String sql1 = "Select Password,Role From Users where ID='" + C_ID + "'";
            ResultSet rs = db.ExecuteSQL(sql1);
            while (rs.next()) {
            }
            if (rs.getRow() > 0) {
                 response.sendRedirect("error.jsp?des=ID has been used, try another one!&page=Consumer/CreateAccount.jsp");
            } else {
                int aa = db.ExecuteSQL2(sql);
                int bb = db.ExecuteSQL2(sql2);
                //out.println("<script language=\"javascript\">alert('aaa')</script>");
                response.sendRedirect("consumer.jsp");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
