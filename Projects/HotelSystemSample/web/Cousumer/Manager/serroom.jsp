<%@page import="PublicClass.DataBase"%>
<%
    String hotelid = request.getParameter("hotel");
    String roomid = request.getParameter("roomid");
    //out.println(hotelid+"-----"+roomid);
    DataBase db = new DataBase();
    int tag = db.ExecuteSQL2("UPDATE ROOM SET STATUS='1' WHERE HOTEL_ID='" + hotelid + "' AND ROOM_ID='" + roomid + "'");
    if (tag > 0) {
        out.println("SUCCESS");
    } else {
        out.println("FAIL");
    }
%>
