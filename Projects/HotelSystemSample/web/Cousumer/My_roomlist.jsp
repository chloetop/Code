<%-- 
    Document   : roomlist
    Created on : 2012-4-26, 20:55:01
    Author     : Administrator
--%>

<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="PublicClass.DataBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Page</title>
        <script language="javascript" src="../JS/calendar.js"></script>
        <script language="javascript" src="../JS/CheckFieldData.js"></script>
    </head>
    <%
        String orderid = request.getParameter("orderid");
        DataBase db = new DataBase();
        ResultSet rs;

        rs = db.ExecuteSQL("SELECT DISTINCT(ORDERS.HOTEL_ID) AS HOTEL_ID,Hotel.Address,Hotel.Hotel_Name,Hotel.Phone,ORDERS.CHECK_IN,ORDERS.CHECK_OUT,CITY_ID FROM ORDERS LEFT JOIN HOTEL ON ORDERS.HOTEL_ID= Hotel.Hotel_Id WHERE OID ='" + orderid + "'");
        String Hid = "";
        String Hname = "";
        String Hphone = "";
        String Haddress = "";
        String checkin = "";
        String checkout = "";
        String Hcity = "";
        while (rs.next()) {
            Hid = rs.getString("HOTEL_ID");
            Hname = rs.getString("HOTEL_NAME");
            Haddress = rs.getString("ADDRESS");
            Hphone = rs.getString("PHONE");
            checkin = rs.getString("CHECK_IN");
            checkout = rs.getString("CHECK_OUT");
            Hcity = rs.getString("CITY_ID");

        }
        out.println("SELECT DISTINCT(ORDERS.HOTEL_ID) AS HOTEL_ID,Hotel.Address,Hotel.Hotel_Name,Hotel.Phone,ORDERS.CHECK_IN,ORDERS.CHECK_OUT,CITY_ID FROM ORDERS LEFT JOIN HOTEL ON ORDERS.HOTEL_ID= Hotel.Hotel_Id WHERE OID ='" + orderid + "'");
    %>
    <body >
        <script language="javascript">
            //            onfocus="HS_setDate(this)"src="JS/calendar.js"
            var XMLHttpReq;
            var para;
            function AjaxFunc(url,para){
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
                        if(responseText.trim()=="0")
                            window.location="payment.jsp?"+para;
                        else {
                            alert(responseText);
                            document.getElementById("div1").style.display="";
                        }
                       
                    }
                } else { 
                    //alert("please try again");
                }
            }
        
        
            function book(id,types){
                //                alert(id);
                //                alert(types);
                var t = types.split('-');
                var roominfo="";
                var total = 0;
                for(var i = 0;i<t.length-1;i++){
                    var p = t[i].split('_');
                    var no_of_room = document.getElementById(id+"_"+p[0]).value;
                    // total = total + no_of_room * p[1];
                    roominfo=roominfo+p[0]+"_"+no_of_room;
                    if(p[0]=="01") {
                        roominfo=roominfo+"_0-";
                        continue;
                    }
                    var ex_beds = document.getElementById(id+"_"+p[0]+"_EX").value;
                    roominfo=roominfo+"_"+ex_beds+"-";
                    total = total + ex_beds * 50;
                    
                }
                
                var url = "checkdatas.jsp";
                para ="from=PinCheck&orderid=<%=orderid%>&hotelid=<%=Hid%>&roominfo="+roominfo+"&checkin=<%=checkin%>&checkout=<%=checkout%>";
                alert(para);
                // window.location=url+"?"+para;
                AjaxFunc(url,para);
            }
            
            function addoption(id){
               
                var id2=id+"_EX";
                var obj = document.getElementById(id2);
                var count = obj.options.length;
                for(var i = 0;i<count;i++){
                    obj.options.remove(0);
                }

                
                for(i=0;i<=document.getElementById(id).value;i++){
                    var   oOption=document.createElement( "option"); 
                    oOption.text= i; 
                    oOption.value=i;
                    document.getElementById(id2).options.add(oOption);
                }
               
            }
           
           
        </script>
        <table style=" width: 100%; height: 100%;border: 0pt none">
            <tr style="height: 100px;background-color:rgb(0,53,128) ">
                <td  colspan="2"></td>


            </tr>
            <tr>
                <td style=" width: 30%" valign ="top">
                    <fieldset>
                        <legend>Search Information</legend>
                        <div id="div1" style=" display: none">
                            You are allowed to try other options, and if there is no one can meet your requirements,you are also allowed to choose
                            <a href="../deleteorder.jsp?orderid=<%=orderid%>">Delete all Bookings</a></br>
                            <a href="afterpay.jsp?orderid=<%=orderid%>&from=PinCheck">Maintain old Bookings</a></br>
                        </div>
                    </fieldset>

                </td>
                <td align="centre" valign ="top">
                    <fieldset>
                        <legend>Search Results</legend>
                        <div>

                            <table style="width: 100%">
                                <tr>

                                    <td style= "border-width: 1px; border-top: dotted;border-top-color: blue"><img src="../Img/h<%=Hid%>.jpg" width="128" height="128" alt="h1"/>
                                    </td>
                                    <td valign="top" align ="left" style= "border-width: 1px; border-top: dotted;border-top-color: blue">
                                        <div>
                                            <a href=""><%=Hname%></a>   

                                        </div>
                                        <div><a href=""><%=Haddress%></a> </div>
                                        <div>room details
                                            <table style="width: 100%" cellpadding="0" cellspacing="0" >
                                                <%
                                                    DataBase db2 = new DataBase();
                                                    String str2 = "select HOTEL_ID ,PRICE.TYPE_ID AS TYPE_ID,PRICE, TYPE_NAME,EXTRA_BED,MAX_PEOPLE from PRICE left join Type on Type.Type_Id=PRICE.Type_Id where HOTEL_ID='" + Hid + "'";
                                                    ResultSet rs2 = db2.ExecuteSQL(str2);
                                                    out.println(str2);
                                                    String types = "";%>
                                                <tr>

                                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" >ROOM TYPE</td>
                                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">MAX PEOPLE</td>
                                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">NO.ROOM</td>
                                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">PRICE/PER NIGHT</td>
                                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">NO.EXTRA.BED($50)</td>
                                                </tr>
                                                <% while (rs2.next()) {%>
                                                <tr>

                                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" ><%=rs2.getString("TYPE_NAME")%></td>
                                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center"><%=rs2.getString("MAX_PEOPLE")%></td>
                                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">
                                                        <%if ("01".equals(rs2.getString("TYPE_ID"))) {%>
                                                        <select name="<%=rs2.getString("HOTEL_ID")%>_<%=rs2.getString("TYPE_ID")%>" id="<%=rs2.getString("HOTEL_ID")%>_<%=rs2.getString("TYPE_ID")%>">
                                                            <%} else {%>
                                                            <select name="<%=rs2.getString("HOTEL_ID")%>_<%=rs2.getString("TYPE_ID")%>" id="<%=rs2.getString("HOTEL_ID")%>_<%=rs2.getString("TYPE_ID")%>" onchange="addoption('<%=rs2.getString("HOTEL_ID")%>_<%=rs2.getString("TYPE_ID")%>')">
                                                                <%}%>
                                                                <option value="0">0</option>  
                                                                <option value="1">1</option>
                                                                <option value="2">2</option>
                                                                <option value="3">3</option>
                                                                <option value="4">4</option>
                                                                <option value="5">5</option>
                                                            </select>
                                                    </td>
                                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center"><%=rs2.getString("PRICE")%></td>
                                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">
                                                        <%if (!"01".equals(rs2.getString("TYPE_ID"))) {%>
                                                        <select name="<%=rs2.getString("HOTEL_ID")%>_<%=rs2.getString("TYPE_ID")%>_EX" id="<%=rs2.getString("HOTEL_ID")%>_<%=rs2.getString("TYPE_ID")%>_EX">
                                                            <option value="0">0</option>  
                                                        </select>
                                                        <%}%>
                                                    </td>
                                                </tr>
                                                <%
                                                        types = types + rs2.getString("TYPE_ID") + "_" + rs2.getString("PRICE") + "-";

                                                    }
                                                %>


                                            </table>
                                        </div>



                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="button" value="Book" onclick="book('<%=Hid%>','<%=types%>')" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
                                    </td>
                                </tr>
                                <%
                                    rs2.close();
                                    db2.SQLRelase();

                                    rs.close();
                                    db.SQLRelase();
                                %>
                            </table>

                        </div>
                    </fieldset>
                </td>

            </tr>

        </table>
    </body>
</html>
