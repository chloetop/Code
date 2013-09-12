<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="PublicClass.DataBase"%>
<%
    String op = request.getParameter("op");
    String hotelid = request.getParameter("hotelid");
    String begin = request.getParameter("begin");
    String end = request.getParameter("end");
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    Date d1 = df.parse(begin);
    Date d2 = df.parse(end);

    String dt1 = df.format(d1);//begin
    String dt2 = df.format(d2);
    //out.println(hotelid+"-----"+roomid);
    DataBase db = new DataBase();
    if ("1".equals(op)) {
        
        int tag = db.ExecuteSQL2("update hotel SET BEGIN='" + dt1 + "',END='" + dt2 + "' WHERE HOTEL_ID='" + hotelid + "'");
        if (tag > 0) {
            out.println("SUCCESS");
        } else {
            out.println("FAIL");
        }
    } else if ("2".equals(op)) {
    } else {
    }

%>
