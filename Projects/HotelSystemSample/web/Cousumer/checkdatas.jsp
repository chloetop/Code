<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="PublicClass.DataBase"%>
<%@page import="java.io.PrintWriter"%>
<%
    String hotelid = request.getParameter("hotelid");
    String roominfo = request.getParameter("roominfo");
    String checkin = request.getParameter("checkin");
    String checkout = request.getParameter("checkout");

   // out.println(hotelid + "------" + roominfo + "------" + checkin + "------" + checkout);
   // out.println("</br>");
    long DAY = 24L * 60L * 60L * 1000L;
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    Date d1 = df.parse(checkin);
    Date d2 = df.parse(checkout);
    String dt1 = df.format(d1);
    String dt2 = df.format(d2);

    String[] typelist = roominfo.split("-");
    String sql = "Select * From Orders left join TYPE on TYPE.TYPE_ID=ORDERS.TYPE_ID Where Hotel_Id = '" + hotelid + "' And Check_In<'" + dt2 + "' and Check_Out>'" + dt1 + "'";
    DataBase db = new DataBase();
    ResultSet rs;
    String returninfo = "0";
    for (int i = 0; i < typelist.length; i++) {
        String[] typelist2 = typelist[i].split("_");
        if (typelist2[1].equals("0")) {
            continue;
        } else {
            String Tsql = sql + " and ORDERS.TYPE_ID='" + typelist2[0] + "'";
            rs = db.ExecuteSQL(Tsql);
            
            int num = 0;
            int total = 0;

            while (rs.next()) {
                num = num + Integer.parseInt(rs.getString("NUM_ROOM"));
            }
            //-----------------------------
            String typename = "";
            rs = db.ExecuteSQL("select * from TYPE WHERE Type_Id='" + typelist2[0] + "'");
            while (rs.next()) {
                typename = rs.getString("TYPE_NAME");
            }
            //---------------------

            rs = db.ExecuteSQL("select count(*)as total from room where Hotel_Id='" + hotelid + "' and Type_Id='" + typelist2[0] + "'");
            while (rs.next()) {
                total = Integer.parseInt(rs.getString("total"));
            }
            if (total - num >= Integer.parseInt(typelist2[1])) {
            } else {
                returninfo = "There are only " + (total - num) + " " + typename + " left";
                break;
            }
        }
    }


out.println(returninfo);

%>
