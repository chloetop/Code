<%-- 
    Document   : afterpay
    Created on : 2012-5-2, 20:13:13
    Author     : Administrator
--%>

<%@page import="PublicClass.SendEmail"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="PublicClass.DataBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Detail</title>
    </head>
    <%
        String orderid = request.getParameter("orderid");
        String from = request.getParameter("from");
        DataBase db = new DataBase();
        ResultSet rs;
    %>
    <body>
        <table style=" width: 100%; height: 100%;border: 0pt none">
            <tr style="height: 100px;background-color:rgb(0,53,128) ">
                <td  colspan="3"></td>


            </tr>
            <tr>
                <td align="centre" >
                    <fieldset>
                        <legend>Booking Details</legend>
                        <div>
                            <%
                                rs = db.ExecuteSQL("SELECT DISTINCT(ORDERS.HOTEL_ID) AS HOTEL_ID,Hotel.Address,Hotel.Hotel_Name,Hotel.Phone,ORDERS.CHECK_IN,ORDERS.CHECK_OUT,ORDERS.USER_ID FROM ORDERS LEFT JOIN HOTEL ON ORDERS.HOTEL_ID= Hotel.Hotel_Id WHERE OID ='" + orderid + "'");
                                String Uid = "";
                                String Hid = "";
                                String Hname = "";
                                String Hphone = "";
                                String Haddress = "";
                                String checkin = "";
                                String checkout = "";
                                while (rs.next()) {
                                    Uid = rs.getString("USER_ID");
                                    Hid = rs.getString("HOTEL_ID");
                                    Hname = rs.getString("HOTEL_NAME");
                                    Haddress = rs.getString("ADDRESS");
                                    Hphone = rs.getString("PHONE");
                                    checkin = rs.getString("CHECK_IN");
                                    checkout = rs.getString("CHECK_OUT");

                                }
                            %>
                            <table>
                                <tr>
                                    <td colspan="3">You will stay</td>
                                </tr>
                                <tr>
                                    <td  rowspan="5">  <img src="../Img/h<%=Hid%>.jpg" width="120" height="120" alt=""/></td>

                                    <td  colspan="2">     <%=Hname%></td>
                                </tr>
                                <tr>
                                    <td>Contact Number</td>
                                    <td>     <%=Hphone%></td>
                                </tr>
                                <tr>
                                    <td>Location</td>
                                    <td>     <%=Haddress%></td>
                                </tr>
                                <tr>
                                    <td>Check In</td>
                                    <td>     <%=checkin%></td>
                                </tr>
                                <tr>
                                    <td>Check Out</td>
                                    <td><%=checkout%></td>
                                </tr>
                            </table>
                        </div>
                        <div >
                            <table style="width: 100%; border-bottom-color: orange" cellpadding="0" cellspacing="0" border="1">
                                <tr style="background-color: rgb(83,124,180);color: white">
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" colspan="2">ROOM TYPE</td>
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">NO.ROOM</td>
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">NO.EXTRA.BED</td>
                                </tr>
                                <%

                                    rs = db.ExecuteSQL("Select * From Orders Left Join Type On Orders.Type_Id=Type.Type_Id WHERE OID='" + orderid + "'");
                                    String tID = "";
                                    String tName = "";
                                    String NUM_ROOM = "";
                                    String NUM_EX_BED = "";
                                    while (rs.next()) {
                                        tID = rs.getString("TYPE_ID");
                                        tName = rs.getString("TYPE_NAME");
                                        NUM_ROOM = rs.getString("NUM_ROOM");
                                        NUM_EX_BED = rs.getString("NUM_EX_BED");
                                %>
                                <tr>
                                    <td width="90">
                                        <img src="../Img/r<%=tID%>.jpg" width="90" height="90" alt=""/>
                                    </td>
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange">
                                        <%=tName%></td>
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center"><%=NUM_ROOM%></td>
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center"><%=NUM_EX_BED%></td>
                                </tr>        

                                <%  }
                                %>
                            </table>
                        </div>
                    </fieldset>
                </td>
                <%
                    if ("payment".equals(from)) {%>
                <td style=" width: 25%; " align="centre" valign ="top">
                    <fieldset>
                        <legend>Notice</legend>
                        <div>
                            An Email will be sent to your Email Address, please check!

                        </div>

                        <%  Random random = new Random();
                            String PIN = "";
                            while (true) {
                                int x = random.nextInt(999999);
                                if (x > 99999) {
                                    rs = db.ExecuteSQL("SELECT * FROM ORDERS WHERE PIN ='" + x + "'");
                                    while (rs.next()) {
                                    }
                                    if (rs.getRow() == 0) {

                                        PIN = Integer.toString(x);
                                        db.ExecuteSQL2("update orders set PIN='" + PIN + "' where OID='" + orderid + "'");
                                        break;
                                    }
                                }
                            }


                            String url = "http://" + request.getServerName() + ":8080/group15/Consumer/checkorder.jsp?ID=" + orderid;
                            String Cont="Thank you for booking in our hotels.\nThis is Pin Code:"+PIN+"\nYou are allowed to modify the order by using the link below\n"+url;
                            SendEmail se = new SendEmail();
                            se.sendMail("V Hotel Chain", Cont, Uid);
                        %>

                        <a  href="<%=url%>">dd</a>
                    </fieldset>
                </td>
                <% }%>
                <%if ("PinCheck".equals(from)) {%>


                <td style=" width: 25%; " align="centre" valign ="top">
                    <fieldset>
                        <legend>Modify Order</legend>
                        <div>
                            <a href="My_roomlist.jsp?orderid=<%=orderid%>">Add a Room</a>

                        </div>



                    </fieldset>
                </td>


                <% }%>
            </tr>
            <tr>
                <td colspan="3" align="center">CopyRight:</td>
            </tr>
        </table>
    </body>
</html>
