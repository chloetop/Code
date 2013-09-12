<%-- 
    Document   : payment
    Created on : 2012-5-1, 23:09:22
    Author     : Administrator
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="PublicClass.DataBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Page</title>
        <script language="javascript" src="../JS/CheckFieldData.js"></script>
    </head>
    <%
        String orderid = request.getParameter("orderid").trim();
        String from = request.getParameter("from").trim();
        DataBase db_old = new DataBase();
        ResultSet rs_old;
        String USER_ID = "";
        rs_old = db_old.ExecuteSQL("Select USER_ID From Orders where OID='" + orderid + "'");
        while (rs_old.next()) {
            USER_ID = rs_old.getString("USER_ID");
        }
        String hotelid = request.getParameter("hotelid").trim();
        String roominfo = request.getParameter("roominfo");
        String checkin = request.getParameter("checkin");
        String checkout = request.getParameter("checkout");
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date d1 = df.parse(checkin);
        Date d2 = df.parse(checkout);

        String dt1 = df.format(d1);//begin
        String dt2 = df.format(d2);
        // Calendar calendar = Calendar.getInstance();
        // calendar.setTime(d1);
        // calendar.set(Calendar.DAY_OF_MONTH, calendar.get(Calendar.DAY_OF_MONTH) + 1);
        // out.println(dt1 + "</br>");
        int days = (int) ((d2.getTime() - d1.getTime()) / (24 * 60 * 60 * 1000)); //how many days
        //  out.println(days);
        DataBase db = new DataBase();
        ResultSet rs;
        ResultSet rs1;
        double total = 0.00;
        DecimalFormat r = new DecimalFormat();
        r.applyPattern("#,#00.0#");
        String ordersql = "";
    %>
    <body>
        <%=roominfo%>
        <script language="javascript">
           
            function subt1(){
                var Err = "";
               
                //                var val = (document.getElementById("account").value).trim();
                //                if(!IsNumNull(val))
                //                    Err = Err+"Email must be input\n";
                //                if(IsNumNull(val))
                //                    if(!IsEmail(val))
                //                        Err = Err+"invalid Email\n";
                            
               
               
                if(IsNumNull(Err)) {
                    alert(Err);
                    return ;
                }else {
                    var form = document.getElementById("Payment");
                    form.submit();
                    //alert("ok");
                } 
                 
            }
            
            function maint1(){
                window.location="afterpay.jsp?orderid=<%=orderid%>&from=PinCheck";
            }
        </script>
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
                                rs = db.ExecuteSQL("select * from HOTEL where HOTEL_ID='" + hotelid + "'");
                                String Hname = "";
                                String Hphone = "";
                                String Haddress = "";
                                while (rs.next()) {
                                    Hname = rs.getString("HOTEL_NAME");
                                    Haddress = rs.getString("ADDRESS");
                                    Hphone = rs.getString("PHONE");

                                }
                            %>
                            <table>
                                <tr>
                                    <td colspan="3">You will stay</td>
                                </tr>
                                <tr>
                                    <td  rowspan="5">  <img src="../Img/h<%=hotelid%>.jpg" width="120" height="120" alt=""/></td>

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
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" colspan="5" align="center">New Booking Information</td>

                                </tr>
                                <tr style="background-color: rgb(83,124,180);color: white">
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" colspan="2">ROOM TYPE</td>
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">NO.ROOM</td>
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">PRICE For <%=days%> NIGHT</td>
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">NO.EXTRA.BED($50)</td>
                                </tr>
                                <%
                                    String[] typelist = roominfo.split("-");
                                    for (int i = 0; i < typelist.length; i++) {
                                        String[] typelist2 = typelist[i].split("_");
                                        if (typelist2[1].equals("0")) {
                                            continue;
                                        } else {
                                            rs = db.ExecuteSQL("select * from TYPE WHERE Type_Id='" + typelist2[0] + "'");
                                            String tName = "";

                                            while (rs.next()) {
                                                tName = rs.getString("TYPE_NAME");
                                            }
                                            rs = db.ExecuteSQL("select * from Price where HOTEL_ID='" + hotelid + "' AND TYPE_ID='" + typelist2[0] + "'");
                                            String tPrice = "";
                                            while (rs.next()) {
                                                tPrice = rs.getString("PRICE");
                                            }
                                %>

                                <%         //PEAK PERIOD CHECK  +  
                                    String sql = "";
                                    String sql1 = "";
                                    String Tdt = df.format(d1.getTime() + 0 * 24 * 60 * 60 * 1000);
                                    // out.println(Tdt);
                                    double Pt = 0.00;
                                    for (int j = 0; j < days; j++) {
                                        Tdt = df.format(d1.getTime() + j * 24 * 60 * 60 * 1000);
                                        //Pt = 0.00;
                                        sql = "Select * From Peak where BEGIN<='" + Tdt + "' AND END>'" + Tdt + "'";
                                        rs = db.ExecuteSQL(sql);
                                        double rate = 0.00;
                                        while (rs.next()) {
                                            rate = (Double.parseDouble(rs.getString("RATE")) + 100) / 100;
                                        }
                                        //discount
                                        sql1 = "select * from discount where Hotel_Id='" + hotelid + "' and Type_Id='" + typelist2[0] + "' and BEGIN<='" + Tdt + "' AND END>'" + Tdt + "'";
                                        rs1 = db.ExecuteSQL(sql1);
                                        double rate1 = 0.00;
                                        while (rs1.next()) {
                                            if ("+".equals(rs1.getString("TREND"))) {
                                                rate1 = (Double.parseDouble(rs1.getString("RATE")) + 100) / 100;
                                            }
                                            if ("-".equals(rs1.getString("TREND"))) {
                                                rate1 = (100 - Double.parseDouble(rs1.getString("RATE"))) / 100;
                                            }

                                        }
                                        if (rs.getRow() == 0 && rs1.getRow() == 0) {
                                            total = total + Double.parseDouble(tPrice) * Integer.parseInt(typelist2[1]);
                                            Pt = Pt + Double.parseDouble(tPrice) * Integer.parseInt(typelist2[1]);
                                        }
                                        if (rs.getRow() == 0 && rs1.getRow() == 1) {
                                            total = total + Double.parseDouble(tPrice) * Integer.parseInt(typelist2[1]) * rate1;
                                            Pt = Pt + Double.parseDouble(tPrice) * Integer.parseInt(typelist2[1]) * rate1;
                                        }
                                        if (rs.getRow() == 1 && rs1.getRow() == 0) {
                                            total = total + Double.parseDouble(tPrice) * Integer.parseInt(typelist2[1]) * rate;
                                            Pt = Pt + Double.parseDouble(tPrice) * Integer.parseInt(typelist2[1]) * rate;
                                        }
                                        if (rs.getRow() == 1 && rs1.getRow() == 1) {
                                            total = total + Double.parseDouble(tPrice) * Integer.parseInt(typelist2[1]) * rate * rate1;
                                            Pt = Pt + Double.parseDouble(tPrice) * Integer.parseInt(typelist2[1]) * rate * rate1;
                                        }
                                        if (typelist2[2].equals("0")) {
                                        } else {
                                            total = total + Integer.parseInt(typelist2[2]) * 50;
                                            Pt = Pt + Integer.parseInt(typelist2[2]) * 50;
                                        }
                                        // total = Double.parseDouble(r.format(total));
                                        //  out.println(total);
                                    }
                                    // Pt = Double.parseDouble(r.format(Pt));

                                %>
                                <tr>
                                    <td width="90">
                                        <img src="../Img/r<%=typelist2[0]%>.jpg" width="90" height="90" alt=""/>
                                    </td>
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange">
                                        <%=tName%></td>
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center"><%=typelist2[1]%></td>
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center"><%=r.format(Pt)%></td>
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center"><%=typelist2[2]%></td>
                                </tr>        
                                <%  // INSERT ORDERS
                                            if (!"".equals(orderid)) {
                                                ordersql = ordersql + "INSERT INTO ORDERS(OID,HOTEL_ID,USER_ID,TYPE_ID,CHECK_IN,CHECK_OUT,NUM_ROOM,PRICE,NUM_EX_BED,STATUS) VALUES('" + orderid + "','" + hotelid + "','" + USER_ID + "','" + typelist2[0] + "','" + dt1 + "','" + dt2 + "','" + typelist2[1] + "','" + r.format(Pt) + "','" + typelist2[2] + "','1');";
                                            } else {
                                                ordersql = ordersql + "INSERT INTO ORDERS(OID,HOTEL_ID,USER_ID,TYPE_ID,CHECK_IN,CHECK_OUT,NUM_ROOM,PRICE,NUM_EX_BED,STATUS) VALUES('$OID$','" + hotelid + "','$UID$','" + typelist2[0] + "','" + dt1 + "','" + dt2 + "','" + typelist2[1] + "','" + r.format(Pt) + "','" + typelist2[2] + "','1');";
                                            }


                                        }
                                    }
                                    //TOTAL PRICE FOR THIS ORDER
                                    rs.close();
                                    db.SQLRelase();
                                    out.println(ordersql);
                                %>

                            </table>

                        </div>
                        <% if (!"".equals(orderid)) {%>
                        <div>
                            <table style="width: 100%; border-bottom-color: orange" cellpadding="0" cellspacing="0" border="1">
                                <tr style="background-color: rgb(83,124,180);color: white">
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" colspan="4" align="center">Existing Booking Information</td>

                                </tr>
                                <tr style="background-color: rgb(83,124,180);color: white">
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" colspan="2">ROOM TYPE</td>
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">NO.ROOM</td>
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">NO.EXTRA.BED</td>
                                </tr>
                                <%

                                    rs_old = db_old.ExecuteSQL("Select * From Orders Left Join Type On Orders.Type_Id=Type.Type_Id WHERE OID='" + orderid + "'");
                                    String tID = "";
                                    String tName = "";
                                    String NUM_ROOM = "";
                                    String NUM_EX_BED = "";
                                    while (rs_old.next()) {
                                        tID = rs_old.getString("TYPE_ID");
                                        tName = rs_old.getString("TYPE_NAME");
                                        NUM_ROOM = rs_old.getString("NUM_ROOM");
                                        NUM_EX_BED = rs_old.getString("NUM_EX_BED");
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

                                <%  }%>
                            </table>
                        </div>
                        <%
                                rs_old.close();
                                db_old.SQLRelase();
                            }%>      
                        <div>
                            <table style="width: 100%; border-bottom-color: orange" cellpadding="0" cellspacing="0" border="1">
                                <tr style="background-color: rgb(252,247,232);color: rgb(0,53,128)">
                                    <td colspan="1" width="50%"></td>
                                    <td align="right">Total Price:</td>
                                    <td align="center">AUD  <%=r.format(total)%></td>
                                </tr>
                            </table>
                        </div>
                    </fieldset>
                </td>
                <td style=" width: 25%; " align="centre" valign ="top">
                    <fieldset>
                        <legend>Your Information</legend>
                        <div>
                            <table style="width: 100%">
                                <tr>
                                    <td>Email Address</td>
                                </tr>

                                <form name="Payment" id="Payment" action="../CreateOrder" method="POST">
                                    <tr>
                                        <td>
                                            <% if (!"".equals(orderid)) {%>
                                            <input type="text" name="account" id="account" value="<%=USER_ID%>" readonly style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/>
                                            <%} else {%>
                                            <input type="text" name="account" id="account" value="" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/>
                                            <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> 
                                            <input type="text" name="Csql" id="Csql" value="<%=ordersql%>" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/>
                                            <input type="text" name="OID" id="OID" value="<%=orderid%>" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/>
                                            <input type="text" name="from" id="from" value="<%=from%>" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="button" value="Confirm Payment" id="subt" name="subt"  onclick="subt1();" width="150px" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; width: 150px" onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/>
                                        </td>
                                    </tr>
                                    <% if (!"".equals(orderid)) {%>
                                    <tr>
                                        <td>
                                            <input type="button" value="Maintain" id="maint" name="maint"  onclick="maint1();"  style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; width: 150px " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/>
                                        </td>
                                    </tr>
                                    <%}%>
                                </form>
                            </table>
                        </div>


                    </fieldset>
                </td>
            </tr>
            <tr>
                <td colspan="1" align="center">

                </td>
            </tr>
        </table>
    </body>
</html>
