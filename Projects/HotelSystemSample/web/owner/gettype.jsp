<%@page import="java.sql.ResultSet"%>
<%@page import="PublicClass.DataBase"%>
<%

    String hotelid = request.getParameter("hotelid");
     DataBase db = new DataBase();
     ResultSet rs;
     rs=db.ExecuteSQL("select PRICE.TYPE_ID,TYPE_NAME from price LEFT JOIN TYPE ON TYPE.TYPE_ID=PRICE.TYPE_ID where HOTEL_ID='"+hotelid+"'");
     //out.println("select PRICE.TYPE_ID,TYPE_NAME from price LEFT JOIN TYPE ON TYPE.TYPE_ID=PRICE.TYPE_ID where HOTEL_ID='"+hotelid+"'");
     String strReturn = "";
     while(rs.next()){
     strReturn=strReturn+rs.getString("TYPE_ID")+"_"+rs.getString("TYPE_NAME")+"-";
     }
    out.println(strReturn);
%>
