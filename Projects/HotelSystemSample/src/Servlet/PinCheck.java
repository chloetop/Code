/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package MyServlet;

import PublicClass.DataBase;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Administrator
 */
public class PinCheck extends HttpServlet {

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
            out.println("<title>Servlet PinCheck</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PinCheck at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
            String orderid = request.getParameter("orderid");
            String pin = request.getParameter("pin");
            DataBase db = new DataBase();
            ResultSet rs;
            // if new user-->create; else nothing
            rs = db.ExecuteSQL("Select * From Orders where OID='" + orderid + "' AND PIN='" + pin + "'");
            String checkin = "";
            while (rs.next()) {
                checkin = rs.getString("CHECK_IN");
            }
            if (rs.getRow() == 0) {
                response.sendRedirect("error.jsp?des=Pin is not correct!&page=Consumer/checkorder.jsp?ID=" + orderid);
            } else {
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                Date d1 = df.parse(df.format(new java.util.Date()));
                Date d2 = df.parse(checkin);
                int days = (int) ((d2.getTime() - d1.getTime()) / (24 * 60 * 60 * 1000));
                out.println(days);
                if (days < 2) {
                    response.sendRedirect("error.jsp?des=It is not allowed to make any changes!&page=Consumer/checkorder.jsp?ID=" + orderid);
                } else {
                    response.sendRedirect("Consumer/afterpay.jsp?orderid=" + orderid + "&from=PinCheck");
                }

            }
            out.println(pin + orderid);

        } catch (Exception ex) {
            ex.getMessage();
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
