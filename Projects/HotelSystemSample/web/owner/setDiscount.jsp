<%@page import="java.sql.ResultSet"%>
<%@page import="PublicClass.DataBase"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    String hotel1 = request.getParameter("hotelid");
    String type1 = request.getParameter("type1");
    String begin1 = request.getParameter("begin1");
    String end1 = request.getParameter("end1");
    String price = request.getParameter("price");
    String trend = request.getParameter("trend");
    if ("0".equals(trend)) {
        trend = "-";
    }
    if ("1".equals(trend)) {
        trend = "+";
    }
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    Date d1 = df.parse(begin1);
    Date d2 = df.parse(end1);

    String dt1 = df.format(d1);//begin
    String dt2 = df.format(d2);
    DataBase db = new DataBase();
    ResultSet rs = db.ExecuteSQL("select * from discount where HOTEL_ID='" + hotel1 + "' AND TYPE_ID='" + type1 + "'");
    int tag;
    if ("".equals(hotel1) || "".equals(type1)) {
        out.println("Information is not completed");
    } else {
        while (rs.next()) {
        }
        if (rs.getRow() == 0) {

            tag = db.ExecuteSQL2("Insert Into DISCOUNT (Hotel_Id, Type_Id, Rate, Trend, Begin, End) Values ('" + hotel1 + "', '" + type1 + "', '" + price + "', '" + trend + "', '" + dt1 + "', '" + dt2 + "')");
        } else {
            tag = db.ExecuteSQL2("UPDATE DISCOUNT SET RATE='" + price + "', TREND='" + trend + "',BEGIN='" + dt1 + "',END='" + dt2 + "' WHERE HOTEL_ID='" + hotel1 + "' AND TYPE_ID='" + type1 + "'");

        }

        //out.println("UPDATE DISCOUNT SET RATE='" + price + "', TREND='" + trend + "',BEGIN='" + dt1 + "',END='" + dt2 + "' WHERE HOTEL_ID='" + hotel1 + "' AND TYPE_ID='" + type1 + "'");
        if (tag > 0) {
            out.println("SUCCESS");
        } else {
            out.println("FAIL");
        }
    }
%>
