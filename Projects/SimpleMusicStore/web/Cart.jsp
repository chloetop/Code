<%@page import="java.text.DecimalFormat"%>
<%@page import="Classes.song"%>
<%@page import="Classes.Xml_Operation"%>
<%@page import="Classes.album"%>
<%@page import="Classes.Search"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="java.io.PrintWriter"%>

<html>
    <head>
        <script language="javascript">
            function release() {
                 if(confirm("Are You sure to check out?"))
                window.location="clear.jsp"
            else
                 window.location="AFindex.jsp"
            }
            
           
        </script>
    </head>
    <body>

        <%
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter show = response.getWriter();

            show.println("<table width=\"700px\" border=\"1\" cellpadding=\"0\" bordercolorlight=\"#999999\" bordercolordark=\"#FFFFFF\"  cellspacing=\"0\" align=\"center\">");
            show.println(" <tr align=\"center\" style=\"background-color: #a9a9a9\"><td>Type</td><td>Title</td><td>Price</td></tr>");
            String albums = (String) request.getSession().getAttribute("Albums");
            String songs = (String) request.getSession().getAttribute("Songs");

            double total = 0.00;
           
            if (!"".equals(albums)) {
                int len = albums.split("-").length;

                String[] al_arr = new String[len];
                al_arr = albums.split("-");

                Xml_Operation Xml_Op = new Xml_Operation();
                NodeList aim_al = Xml_Op.ReadXml("Albums.xml", "album");
                Search S_al = new Search();
                
                for (int i = 0; i < len; i++) {
                    album al = S_al.SearchPrice(al_arr[i], aim_al);
                    // show.println("</br>" + al.getAlbum_id() + "---------" + al.getTitle() + "--------------" + al.getPrice() + "</br>");

                    show.println("<tr align=\"center\" style=\"background-color: #99ccff\">");

                    show.println("<td>Album</td><td>" + al.getTitle() + "</td><td>" + al.getPrice() + "</td></tr>");
                    total = total + Double.parseDouble(al.getPrice());

                }
            }


            if (!"".equals(songs)) {
                int len = songs.split("-").length;

                String[] sg_arr = new String[len];
                sg_arr = songs.split("-");

                Xml_Operation Xml_Op = new Xml_Operation();
                NodeList aim_sg = Xml_Op.ReadXml("Songs.xml", "song");
                Search S_sg = new Search();

                for (int i = 0; i < len; i++) {
                    song sg = S_sg.SearchPrice2(sg_arr[i], aim_sg);
                    //  show.println("</br>" + sg.getSong_id() + "---------" + sg.getSong_name() + "--------------" + sg.getPrice() + "</br>");

                    show.println("<tr align=\"center\" style=\"background-color: #ccccff\">");

                    show.println("<td>Song</td><td>" + sg.getSong_name() + "</td><td>" + sg.getPrice() + "</td></tr>");
                    total = total + Double.parseDouble(sg.getPrice());
                }
            }
            DecimalFormat r = new DecimalFormat();
            r.applyPattern("#0.00");
            show.println("<tr><td align=\"center\">Total is $</td><td colspan=\"2\" align=right>" + r.format(total) + "</td></tr>");
        %>

    <tr>
        <td colspan="4" align="center">
            <input type="submit" value="Return To Last Page" onclick="history.go(-1)" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none" onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="submit" value="Check Out" onclick="release()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none" onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
        </td>
    </tr>
</table>
</body>
</html>
