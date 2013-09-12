<%-- 
    Document   : o_manage
    Created on : 2012-4-28, 19:13:15
    Author     : Administrator
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="PublicClass.DataBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String hotelid = request.getParameter("hotelid");
            String typeid = request.getParameter("typeid");
            String st = request.getParameter("st");
            String rights = (String) request.getSession().getAttribute("RIGHTS");
            out.println(rights);
        %>
        <script language="javascript">
            var XMLHttpReq;
            
              function firm(size){
                  var s=document.getElementById("ids").value.split("-");
               
//                var val = (document.getElementById("account").value).trim();
//                if(!IsNumNull(val))
//                    Err = Err+"Email must be input\n";
//                if(IsNumNull(val))
//                    if(!IsEmail(val))
//                        Err = Err+"invalid Email\n";
//                            
//                var val = (document.getElementById("pwd").value).trim();
//                if(!IsNumNull(val))
//                    Err = Err+"Password must be input\n";
               
                if(s.length-1!=size) {
                    alert("Please assign "+size+" Rooms for this order");
                    return ;
                }else {
                    var form = document.getElementById("SetRoom");
                    form.submit();
                } 
                 
            }
            
            function check(id)
            { 
                var str = ""
                if(document.getElementById(id).checked ==true) {
                    document.getElementById("ids").value=document.getElementById("ids").value+id+"-"
                }
                else {
                    var t = document.getElementById("ids").value.split('-')
                    var str3 = ""
                    for(var i = 0;i<t.length-1;i++){
                        if(t[i]==id)
                            continue;
                        else
                            str3 = str3 + t[i]+"-"
                    }
                    document.getElementById("ids").value=str3
                }
            }
            
            function SetAvailable(){
                // window.location="serroom.jsp?hotel="+document.getElementById("hotel").value+"&roomid="+document.getElementById("roomid").value
                var url ="serroom.jsp?";
                var para ="hotel="+document.getElementById("hotel").value+"&roomid="+document.getElementById("roomid").value;
                if(window.XMLHttpRequest) { //firefox;
                    XMLHttpReq = new XMLHttpRequest();
                }
                else if (window.ActiveXObject) { 
                    try {
                        XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (e) {
                        try {
                            XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {}
                    }
                }
                XMLHttpReq.open("POST", url, true);
                XMLHttpReq.onreadystatechange = processResponse;
                XMLHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                //var tt ="hotelid="+hotelid+"&types="+types+"&checkin="+checkin+"&checkout="+checkout;
                XMLHttpReq.send(para);
                
                
            }
            function processResponse() {
                if (XMLHttpReq.readyState == 4) { 
                    if (XMLHttpReq.status == 200) {
                        var responseText = XMLHttpReq.responseText;
                        alert(responseText);
                    }
                } else { 
                    //alert("please try again");
                }
            }
        </script>
        <table style=" width: 100%; height: 100%;border: 0pt none">
            <tr style="height: 100px;background-color:rgb(0,53,128) ">
                <td  colspan="3" style="color: white">
                    <% String UID = (String) request.getSession().getAttribute("UID");
                        if ("".equals(UID) || UID == null) {
                            response.sendRedirect("../error.jsp?des=out of session,please sign in again!&page=owner_index.jsp");
                    %>

                    <% } else {%>
                    Current User: <%=UID%></br>
                    <a href="../clear.jsp?from=m">Sign out</a>
                    <%}%>

                </td>


            </tr>

            <tr>
                <td>
                    <fieldset>
                        <legend>Check Out</legend>
                        <div>
                            <select name="hotel" id="hotel">
                                <%
                                    DataBase db = new DataBase();
                                    ResultSet rs;
                                    String[] right = rights.split(";");
                                    for (int i = 0; i < right.length; i++) {
                                        rs = db.ExecuteSQL("select HOTEL_NAME,Hotel_Id from hotel where HOTEL_ID='" + right[i] + "'");
                                        out.println("select HOTEL_NAME,Hotel_Id from hotel where HOTEL_ID='" + right[i] + "'");
                                        while (rs.next()) {%>
                                <option value="<%=rs.getString("Hotel_Id")%>"><%=rs.getString("HOTEL_NAME")%></option>
                                <%      }
                                    }%>
                            </select>
                            <input type="text" name="roomid" id="roomid" style=""/>  
                            <input type="button" value="Set Available" onclick="SetAvailable()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
                        </div>
                    </fieldset>
                </td>
            </tr>


            <tr><td>
                    <fieldset>
                        <legend>Check In</legend>
                        <div>
                            <table style="width: 100%">
                                <tr>
                                    <td style=" width: 15%" valign ="top">
                                        <fieldset>
                                            <legend>Hotels</legend>
                                            <div>
                                                <table style="width: 100%">
                                                    <%


                                                        rs = db.ExecuteSQL("select HOTEL_NAME,Hotel_Id from hotel");
                                                        String Hid = "";
                                                        String Hname = "";

                                                        while (rs.next()) {
                                                            Hid = rs.getString("Hotel_Id");
                                                            Hname = rs.getString("HOTEL_NAME");%>
                                                    <tr>
                                                        <td ><a href="m_manage.jsp?hotelid=<%=Hid%>&typeid=&st="><%=Hname%></a></td>
                                                    </tr>
                                                    <%  }%>     
                                                </table>
                                            </div>
                                        </fieldset>

                                    </td>
                                    <td align="centre" valign ="top" style=" width: 38%">
                                        <fieldset>
                                            <legend>Order information</legend>
                                            <div>


                                                <table style="width: 100%; border-bottom-color: orange" cellpadding="0" cellspacing="0" border="1">
                                                    <tr style="background-color: rgb(83,124,180);color: white">
                                                        <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">CHECK IN</td>
                                                        <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">CHECK OUT</td>
                                                        <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">ROOM TYPE</td>
                                                        <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">NUM OF ROOM</td>
                                                        <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">EXTRA BEDS</td>
                                                    </tr>
                                                    <%
                                                        rs = db.ExecuteSQL("Select CHECK_IN,CHECK_OUT,TYPE_NAME, ORDERS.TYPE_ID AS TYPE_ID,NUM_EX_BED,NUM_ROOM,OID From Orders LEFT JOIN TYPE ON TYPE.TYPE_ID=ORDERS.TYPE_ID Where Hotel_Id='" + hotelid + "' AND STATUS='1'");
                                                        String checkin = "";
                                                        String checkout = "";
                                                        String tNAME = "";
                                                        String tID = "";
                                                        String exBed = "";
                                                        String noRoom = "";
                                                        String oID = "";
                                                        while (rs.next()) {
                                                            checkin = rs.getString("CHECK_IN");
                                                            checkout = rs.getString("CHECK_OUT");
                                                            tNAME = rs.getString("TYPE_NAME");
                                                            tID = rs.getString("TYPE_ID");
                                                            exBed = rs.getString("NUM_EX_BED");
                                                            noRoom = rs.getString("NUM_ROOM");
                                                            oID= rs.getString("OID");
                                                    %>
                                                    <tr>
                                                        <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center">
                                                            <a href="m_manage.jsp?hotelid=<%=hotelid%>&typeid=<%=tID%>&st=1"><%=checkin%></a>
                                                        </td>
                                                        <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center">
                                                            <a href="m_manage.jsp?hotelid=<%=hotelid%>&typeid=<%=tID%>&st=1"><%=checkout%></a>
                                                        </td>
                                                        <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center">
                                                            <a href="m_manage.jsp?hotelid=<%=hotelid%>&typeid=<%=tID%>&st=1"><%=tNAME%></a>
                                                        </td>
                                                        <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center">
                                                            <a href="m_manage.jsp?hotelid=<%=hotelid%>&typeid=<%=tID%>&st=1"><%=noRoom%></a>
                                                        </td>
                                                        <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center">
                                                            <a href="m_manage.jsp?hotelid=<%=hotelid%>&typeid=<%=tID%>&st=1"><%=exBed%></a>
                                                        </td>
                                                    </tr>
                                                    <%  }%>      
                                                </table>





                                            </div>
                                        </fieldset>
                                    </td>
                                    <td align="centre" valign ="top">
                                        <fieldset>
                                            <legend>Room information</legend>
<!--                                            <span style="border: solid blue; border-width: 1px;" ><a href="m_manage.jsp?hotelid=<%=hotelid%>&typeid=<%=typeid%>&st=1">Free</a></span>
                                            <span style="border: solid blue; border-width: 1px;" ><a href="m_manage.jsp?hotelid=<%=hotelid%>&typeid=<%=typeid%>&st=2">Occupied</a></span>-->
                                            <form name="SetRoom" id="SetRoom" action="../SetRoom" method="POST">
                                                <input type="text" name="ids" id="ids" style=""/>  
                                                <input type="text" name="hotelid" id="hotelid" style="" value="<%=hotelid%>"/> 
                                                <input type="text" name="orderid" id="orderid" style="" value="<%=oID%>"/>  
                                                <input type="text" name="typeid" id="typeid" style="" value="<%=typeid%>"/>  
                                                <input type="text" name="url" id="url" style="" value="m_manage.jsp?hotelid=<%=hotelid%>&typeid=&st="/>   
                                                <input type="button" value="Confirm" id="confirm" name="confirm"  onclick="firm('<%=noRoom%>')"/>
                                            </form>
                                            <div>

                                                <table style="width: 100%">
                                                    <%
                                                        rs = db.ExecuteSQL("select * from room where hoteL_ID='" + hotelid + "' AND TYPE_ID='" + typeid + "' AND STATUS='" + st + "'");
                                                        String RoomNo = "";

                                                        while (rs.next()) {
                                                            RoomNo = rs.getString("ROOM_ID");


                                                    %>
                                                    <tr>
                                                        <td><%=RoomNo%>

                                                            <input type="checkbox" id="<%=RoomNo%>" name="<%=RoomNo%>" value= "<%=RoomNo%>" onclick="check('<%=RoomNo%>')"/>
                                                        </td>
                                                    </tr>
                                                    <%  }%>     
                                                </table>

                                            </div>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </fieldset>
                </td></tr>
        </table>
    </body>
</html>
