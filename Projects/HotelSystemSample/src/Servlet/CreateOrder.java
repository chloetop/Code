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
public class CreateOrder extends HttpServlet {

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
            out.println("<title>Servlet CreateOrder</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateOrder at " + request.getContextPath() + "</h1>");
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
        // processRequest(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
             String from = request.getParameter("from");
            String account = request.getParameter("account");
            String Csql = request.getParameter("Csql");
            String OID = request.getParameter("OID").trim();
            DataBase db = new DataBase();
            ResultSet rs;
            // if new user-->create; else nothing
            rs = db.ExecuteSQL("select * from Users where ID='" + account + "'");
            while (rs.next()) {
            }
            String upsql = "";
            if (rs.getRow() == 0) {
                upsql = "INSERT INTO Users ( ROLE ,ID ,PASSWORD) VALUES(3 ,'" + account + "' ,'" + account + "')";
                db.ExecuteSQL2(upsql);
                upsql = "INSERT INTO Consumer ( C_ID ,C_NAME ,C_EMAIL,C_PHONE) VALUES('" + account + "' ,'" + account + "' ,'" + account + "','')";
                db.ExecuteSQL2(upsql);
            }
            // add new order

            rs = db.ExecuteSQL("select distinct(OID) from orders");
            while (rs.next()) {
            }
            String orderid="";
            if ("".equals(OID)) {
                orderid = Integer.toString(rs.getRow() + 1);
            } else {
                orderid = OID;
            }

            //replace uid and oid
            Csql = Csql.replaceAll("\\$OID\\$", orderid);
            Csql = Csql.replaceAll("\\$UID\\$", account);
            String[] Lsql = Csql.split(";");
            for (int i = 0; i < Lsql.length; i++) {
                db.ExecuteSQL2(Lsql[i]);
            }

            //Csql_N=Csql.replaceAll("$UID$", account);
            out.println(Csql);
            out.println("</br>");
            response.sendRedirect("Consumer/afterpay.jsp?orderid=" + orderid + "&from="+from);
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("error.jsp?des=" + ex.getMessage() + "&page=index.jsp");
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
