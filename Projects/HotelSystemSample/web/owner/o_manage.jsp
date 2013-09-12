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
        <script language="javascript" src="../JS/calendar.js"></script>
        <title>JSP Page</title>
    </head>
    <%
        DataBase db = new DataBase();
        DataBase db1 = new DataBase();
        ResultSet rs;
        ResultSet rs1;
    %>
    <body>
        <script language="javascript">
            var XMLHttpReq;
            
            function Setime1(){
                var url = "setDiscount.jsp?";
                var para = "hotelid="+document.getElementById("hotel1").value+"&type1="+document.getElementById("type1").value+"&begin1="+document.getElementById("begin1").value+"&end1="+document.getElementById("end1").value+"&trend="+document.getElementById("trend").value+"&price="+document.getElementById("price").value;
                // window.location=url+para;
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
            
            function getype() {
                //alert("a");
                var url = "gettype.jsp?";
                var para = "hotelid="+document.getElementById("hotel1").value;
                //window.location=url+para;
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
                XMLHttpReq.onreadystatechange = processResponse1;
                XMLHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                //var tt ="hotelid="+hotelid+"&types="+types+"&checkin="+checkin+"&checkout="+checkout;
                XMLHttpReq.send(para);
            }
            function processResponse1() {
                if (XMLHttpReq.readyState == 4) { 
                    if (XMLHttpReq.status == 200) {
                        var responseText = XMLHttpReq.responseText;
                        //alert(responseText);
                        var obj = document.getElementById("type1");
                        var count = obj.options.length;
                        for(var i = 0;i<count;i++){
                            obj.options.remove(0);
                        }
            
                        var t=responseText.split("-");
                        for(i=0;i<t.length-1;i++){
                            var r=t[i].split("_");
                         
                     
                            var   oOption=document.createElement( "option"); 
                            oOption.text= r[1]; 
                            oOption.value=r[0];
                            document.getElementById("type1").options.add(oOption);
                        }
                    }
                } else { 
                    //alert("please try again");
                }
            }    
        
            function Setime() {
                var begin=document.getElementById("begin").value;
                var end=document.getElementById("end").value;
                if(begin=="" || end=="") {
                    alert("not allowed blank");
                    return;
                }
                   
                var url ="setPeriod.jsp?";
                var para ="op=1&hotelid="+document.getElementById("hotel").value+"&begin="+document.getElementById("begin").value+"&end="+document.getElementById("end").value;
                // window.location=url+para;
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
                <td  colspan="1" style="color: white">
                    <% String UID = (String) request.getSession().getAttribute("UID");
                        if ("".equals(UID) || UID == null) {
                            response.sendRedirect("../error.jsp?des=out of session,please sign in again!&page=owner_index.jsp");
                    %>

                    <% } else {%>
                    Current User: <%=UID%></br>
                    <a href="../clear.jsp?from=o">Sign out</a>
                    <%}%>

                </td>


            </tr>
            <tr>
                <td style=" width: 30%" valign ="top">
                    <fieldset>
                        <legend>Hotel maintenance </legend>
                        <div>
                            Set a period during which Hotel is closed:
                            <select name="hotel" id="hotel">
                                <%
                                    rs = db.ExecuteSQL("select HOTEL_NAME,Hotel_Id from hotel");

                                    while (rs.next()) {%>
                                <option value="<%=rs.getString("Hotel_Id")%>"><%=rs.getString("HOTEL_NAME")%></option>
                                <%      }%>

                            </select>
                            <input type="text" name="begin" id="begin" value="" onfocus="HS_setDate(document.getElementById('begin'))"/>
                            <input type="text" name="end" id="end" value="" onfocus="HS_setDate(document.getElementById('end'))"/>
                            <input type="button" value="Set Time" onclick="Setime()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
                        </div>
                    </fieldset>

                </td>


            </tr>
            <tr><td align="centre" valign ="top">
                    <fieldset>
                        <legend>Set Discount</legend>
                        <div>
                            <select name="hotel1" id="hotel1" onchange="getype()">
                                <option value=""></option>
                                <%
                                    rs = db.ExecuteSQL("select HOTEL_NAME,Hotel_Id from hotel");

                                    while (rs.next()) {%>
                                <option value="<%=rs.getString("Hotel_Id")%>"><%=rs.getString("HOTEL_NAME")%></option>
                                <%      }%>

                            </select>
                            <select name="type1" id="type1" >


                            </select>

                            <input type="text" name="begin1" id="begin1" value="" onfocus="HS_setDate(document.getElementById('begin1'))"/>
                            <input type="text" name="end1" id="end1" value="" onfocus="HS_setDate(document.getElementById('end1'))"/>
                            <select name="trend" id="trend" >
                                <option  value="1">increase</option>
                                <option  value="0">reduce</option>
                            </select>
                            <input type="text" name="price" id="price" value="" />%
                            <input type="button" value="Set Discount" onclick="Setime1()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 

                        </div>
                    </fieldset>
                </td>
            </tr>
            <tr><td align="centre" valign ="top">
                    <fieldset>
                        <legend>Occupancy </legend>
                        <div>
                            <table style="width: 60%; border-bottom-color: orange" cellpadding="0" cellspacing="0" border="1">
                                <tr style="background-color: rgb(83,124,180);color: white">
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" ></td>
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">Occupied</td>
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">Available</td>
                                    <td style= "border-width: 1px;border-top: solid; border-top-color: orange" align="center">Percentage</td>
                                </tr>
                                <%
                                    rs = db.ExecuteSQL("select HOTEL_NAME,Hotel_Id from hotel");

                                    while (rs.next()) {

                                        rs1 = db1.ExecuteSQL("select * from Room where HOTEL_ID='" + rs.getString("Hotel_Id") + "' AND STATUS='1'");
                                        while (rs1.next()) {
                                        }
                                        int num2 = rs1.getRow();
                                        rs1 = db1.ExecuteSQL("select * from Room where HOTEL_ID='" + rs.getString("Hotel_Id") + "' AND STATUS='2'");
                                        while (rs1.next()) {
                                        }
                                        int num1 = rs1.getRow();
                                        double Percentage = 0.;
                                        if (num1 == 0 && num2 == 0) {
                                        }
                                        if (num1 == 0 && num2 > 0) {
                                        }
                                        if (num1 > 0 && num2 == 0) {
                                            Percentage = 100.00;
                                        }
                                        if (num1 > 0 && num2 > 0) {
                                            Percentage = (100 * num1 / (num1 + num2));
                                        }

                                        // double Percentage = (num1 / (num1 + num2)) * 100;%>
                                <tr>
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange">
                                        <%=rs.getString("HOTEL_NAME")%></td>
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center"><%=num1%></td>
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center"><%=num2%></td>  
                                    <td style= "border-width: 1px;border-top: solid; border-color: orange" align="center"><%=Percentage%>%</td>  
                                </tr>
                                <% }
                                    rs.close();
                                 
                                    db1.SQLRelase();
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
