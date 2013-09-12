/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pack;

import Classes.Search;
import Classes.Xml_Operation;
import Classes.album;
import Classes.song;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 *
 * @author Administrator
 */
public class Al_Details extends HttpServlet {

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
//        PrintWriter out = response.getWriter();
//        try {
//            /*
//             * TODO output your page here. You may use following sample code.
//             */
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet Al_Details</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet Al_Details at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        } finally {            
//            out.close();
//        }
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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String id = request.getParameter("id");
        out.println("<html>");
        out.println("<head>");
        out.println("<script language=\"javascript\"> ");
        out.println(" function check(id)");
        out.println("   { var str = \"\"");
        out.println("       if(document.getElementById(id).checked ==true) {");
        out.println("           document.getElementById(\"ids\").value=document.getElementById(\"ids\").value+id+\"-\"");
        out.println("       }");
        out.println("       else {");
        out.println("          var t = document.getElementById(\"ids\").value.split('-')");
        out.println("          var str3 = \"\"");
        out.println("          for(var i = 0;i<t.length-1;i++){");
        out.println("              if(t[i]==id)");
        out.println("                  continue;");
        out.println("              else");
        out.println("                 str3 = str3 + t[i]+\"-\"");
        out.println("         }");
        out.println("         document.getElementById(\"ids\").value=str3");
        out.println("     }");
        out.println("  }");

        out.println("   var XMLHttpReq;");

        out.println(" function Add(){");
        //out.println("document.getElementById(\"ids\").value=\"\"");
        out.println(" if(window.XMLHttpRequest) { //firefox");
        out.println("      XMLHttpReq = new XMLHttpRequest();");
        out.println("  }");
        out.println("  else if (window.ActiveXObject) { // IE");
        out.println("      try {");
        out.println("         XMLHttpReq = new ActiveXObject(\"Msxml2.XMLHTTP\");");
        out.println("     } catch (e) {");
        out.println("         try {");
        out.println("             XMLHttpReq = new ActiveXObject(\"Microsoft.XMLHTTP\");");
        out.println("         } catch (e) {}");
        out.println("     }");
        out.println(" }");
        out.println(" XMLHttpReq.open(\"POST\", \"Add.jsp?sType=r2&val=\"+document.getElementById(\"ids\").value, true);");
        out.println(" XMLHttpReq.onreadystatechange = processResponse;");
        out.println("  XMLHttpReq.send(null);  ");
        out.println("  }");
        out.println("function processResponse() {");
        out.println("   if (XMLHttpReq.readyState == 4) { ");
        out.println("       if (XMLHttpReq.status == 200) {");
        out.println("          alert(\"success!\")");
        // out.println("alert(\"Add.jsp?sType=" + request.getParameter("sType").trim() + "&val=\"+document.getElementById(\"ids\").value)");
        out.println(" var t = document.getElementById(\"ids\").value.split('-')");
        out.println("        document.getElementById(\"ids\").value=\"\"");
        out.println("       for(var i = 0;i<t.length-1;i++){");
        out.println("            document.getElementById(t[i]).checked = false");
        out.println("}");
        out.println("      } else { ");
        out.println("          window.alert(\"somthing wrong,contact managers please。\");");
        out.println("     }");
        out.println(" }");
        out.println("}");

        out.println("</script>");
        out.println("</head>");
        out.println("<body>");
        out.println("<table width=\"700px\" border=\"1\" cellpadding=\"0\" bordercolorlight=\"#999999\" bordercolordark=\"#FFFFFF\" style=\"background-color:#99cc99\" cellspacing=\"0\" align=\"center\">");
        out.println("<tr align=center><td colspan=\"3\">");
        out.println("<input type=\"text\" name=\"ids\" id=\"ids\" style=\"display:none\"/>");
//            out.println("  </form>");
      out.println("<input type=\"submit\" value=\"Return To Last Page\" onclick=\"history.go(-1)\" style=\"border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none\" onmouseover=\"this.style.background='#3366ff'\"  onmouseout=\"this.style.background='#a9a9a9'\"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        out.println("<input type=\"submit\" value=\"Add To Cart\" onclick=\"Add()\" style=\"border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none\" onmouseover=\"this.style.background='#3366ff'\"  onmouseout=\"this.style.background='#a9a9a9'\"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        out.println("<a href=\"Cart.jsp\" >check cart</a>");
        Xml_Operation Xml_Op = new Xml_Operation();
        //Album
        NodeList Nodes_head = Xml_Op.ReadXml("Albums.xml", "album");
        Search S_al = new Search();
        album al = S_al.SearchAlbum(id, Nodes_head);
        out.println("</td></tr>");
        out.println("<tr><td  rowspan=\"3\" width=\"300\"><img src=\"" + al.getAlbum_id() + ".jpg\" width=\"300\" height=\"300\"/></td><td><li>Title:" + al.getTitle() + "</li></td><td><li>Artists:" + al.getArtist() + "</li></td></tr>");
        out.println("<tr><td><li>Genre:" + al.getGenre() + "</li></td><td><li>Publisher:" + al.getPublisher() + "</li></td></tr>");
        out.println("<tr><td><li>Year:" + al.getYear() + "</li></td><td><li>Price:" + al.getPrice() + "</li></td></tr>");
       // out.println(al.getAlbum_id() + "   " + al.getTitle() + "   " + al.getArtist() + "   " + al.getPublisher() + "   " + al.getGenre() + "   " + al.getYear() + "</br>" + al.getDescription() + "</br>");
out.println("</table>");
        //Songs 
        NodeList Nodes = Xml_Op.ReadXml("Songs.xml", "song");
out.println("<table width=\"700px\" border=\"1\" cellpadding=\"0\" bordercolorlight=\"#999999\" bordercolordark=\"#FFFFFF\" cellspacing=\"0\" align=\"center\">");
out.println("<tr align=\"center\" style=\"background-color: #a9a9a9\"><td></td><td>Title</td><td>Artist</td><td>Price</td></tr>");
        int len = Nodes.getLength();
        for (int i = 0; i < len; i++) {
            Node nNode = Nodes.item(i);
            song NewSong = new song();
            String temp;
            Element eElement = (Element) nNode;
            temp = eElement.getElementsByTagName("in_album").item(0).getChildNodes().item(0).getNodeValue();
            if (temp.equals(id)) {

                NewSong.setIn_album(temp);
                temp = eElement.getElementsByTagName("song_name").item(0).getChildNodes().item(0).getNodeValue();
                NewSong.setSong_name(temp);
                temp = eElement.getElementsByTagName("song_id").item(0).getChildNodes().item(0).getNodeValue();
                NewSong.setSong_id(temp);
                temp = eElement.getElementsByTagName("in_album").item(0).getChildNodes().item(0).getNodeValue();
                NewSong.setIn_album(temp);
                temp = eElement.getElementsByTagName("Price").item(0).getChildNodes().item(0).getNodeValue();
                NewSong.setPrice(temp);
                temp = eElement.getElementsByTagName("Artist").item(0).getChildNodes().item(0).getNodeValue();
                NewSong.setArtist(temp);
//                out.println("<input type=\"checkbox\" id=\"" + NewSong.getSong_id() + "\" name=\"" + NewSong.getSong_id() + "\" value=\"" + NewSong.getSong_id() + "\" onclick=\"check('" + NewSong.getSong_id() + "')\"/>");
//                out.println(NewSong.getSong_id() + "---" + NewSong.getSong_name() + "---" + NewSong.getArtist() + "---" + NewSong.getPrice() + "</br>");
                if (i % 2 == 1) {
                        out.println("<tr align=\"center\" style=\"background-color: #99ccff\">");
                    } else {
                        out.println("<tr align=\"center\" style=\"background-color: #ccccff\">");
                    }
                out.println("<td>");
                  out.println("<input type=\"checkbox\" id=\"" + NewSong.getSong_id() + "\" name=\"" + NewSong.getSong_id() + "\" value=\"" + NewSong.getSong_id() + "\" onclick=\"check('" + NewSong.getSong_id() + "')\"/>");
                    out.println("</td>");
                     out.println("<td>" + NewSong.getSong_name() + "</td>");
                    out.println("<td>" + NewSong.getArtist()+ "</td>");
                    out.println("<td>" + NewSong.getPrice() + "</td>");
                    out.println("</tr>");
            }
        }
         out.println("</table>");
        out.println("</body>");
        out.println("</html>");
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
        processRequest(request, response);
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
