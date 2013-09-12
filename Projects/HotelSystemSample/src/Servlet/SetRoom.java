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
public class SetRoom extends HttpServlet {

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
            out.println("<title>Servlet SetRoom</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SetRoom at " + request.getContextPath() + "</h1>");
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
        try {
            PrintWriter out = response.getWriter();
            String orderid = request.getParameter("orderid").trim();
            String ids = request.getParameter("ids").trim();
            String url = request.getParameter("url").trim();
            String hotelid = request.getParameter("hotelid").trim();
            String typeid = request.getParameter("typeid").trim();

            String[] id = ids.split("-");
            DataBase db = new DataBase();
            ResultSet rs;
            for (int i = 0; i < id.length; i++) {
                if (!"".equals(ids)) {
                    db.ExecuteSQL2("update ROOM SET STATUS='2' WHERE HOTEL_ID='" + hotelid + "' AND TYPE_ID='" + typeid + "' AND ROOM_ID='" + id[i] + "'");
                }
            }
            db.ExecuteSQL2("Update ORDERS Set STATUS = '2' Where OID='" + orderid + "' AND TYPE_ID='" + typeid + "' AND Hotel_Id='" + hotelid + "'");
            //out.println("Update ORDERS Set Num_Room = '2' Where OID='" + orderid + "' AND TYPE_ID='" + typeid + "' AND Hotel_Id='" + hotelid + "'");
            response.sendRedirect("Manager/" + url);
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
