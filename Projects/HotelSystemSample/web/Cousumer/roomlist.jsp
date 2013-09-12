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

        String city = request.getParameter("city");
        String content = request.getParameter("content");
        String checkin = request.getParameter("checkin");
        String checkout = request.getParameter("checkout");

    %>
    <body onload="Init()">
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
                    //alert(responseText+"bbb");
                    if(responseText.trim()=="0")
                        window.location="payment.jsp?"+para;
                    else
                        alert(responseText);
                       
                       
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
            para ="from=payment&orderid=&hotelid="+id+"&roominfo="+roominfo+"&checkin="+document.getElementById("checkin").value+"&checkout="+document.getElementById("checkout").value;
            //alert(total);
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
        function Init() {
                
            document.getElementById("city").value="<%=city%>";
            document.getElementById("content").value="<%=content%>";
            document.getElementById("checkin").value="<%=checkin%>";
            document.getElementById("checkout").value="<%=checkout%>";
               
        }
        function search(){
                
            var Err = "";
               
            var val = (document.getElementById("content").value).trim();
            if(IsNumNull(val))
                if(!IsString(val))
                    Err = Err+"invalid character\n";
               
              
                
              
            if(IsNumNull(Err))
                alert(Err);
            else {
                var city = (document.getElementById("city").value).trim();
                var content = (document.getElementById("content").value).trim();
                var checkin = (document.getElementById("checkin").value).trim();
                var checkout = (document.getElementById("checkout").value).trim();
                  
                var link = "roomlist.jsp?city="+city+"&content="+content+"&checkin="+checkin+"&checkout="+checkout;
                window.location=link;
            }
        }
        //            function bt2(){
        //                document.getElementById("tr2").style.display=""
        //                document.getElementById("tr1").style.display="none"
        //            }
        //            function aa(){
        //                alert("a")
        //                document.getElementById("Search").style.background="#ffffff"
        //            }
        </script>
        <table style=" width: 100%; height: 100%;border: 0pt none">
            <tr style="height: 100px;background-color:rgb(0,53,128) ">
                <td  colspan="2"></td>


            </tr>
            <tr>
                <td style=" width: 30%" valign ="top">
                    <fieldset>
                        <legend>Search Information</legend>
                        <div>
                            <table style="width: 100%">
                                <tr>
                                    <td>City</td>
                                </tr>
                                <tr>
                                    <td>
                                        <select name="city" id="city">
                                            <%
                                                DataBase db = new DataBase();
                                                ResultSet rs = db.ExecuteSQL("select City_Id, City_Name from City");
                                                while (rs.next()) {%>
                                            <option value="<%=rs.getString("City_Id")%>"><%=rs.getString("City_Name")%></option>
                                            <%}
                                                rs.close();
                                                db.SQLRelase();
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Destination/Hotel Name</td>
                                </tr>
                                <tr>
                                    <td><input type="text" name="content" id="content" value="" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/></td>
                                </tr>
                                <tr>
                                    <td>Check-In Date</td>
                                </tr>
                                <tr>
                                    <td><input type="text" name="checkin" id="checkin" value="" readonly="readonly"/>
                                        <input type="image" src="../Img/calendar.jpg" width="20px"  height="20px" value="abc"  onclick="HS_setDate(document.getElementById('checkin'))" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Check-Out Date</td>
                                </tr>
                                <tr>
                                    <td><input type="text" name="checkout" id="checkout" value="" readonly="readonly"/>
                                        <input type="image" src="../Img/calendar.jpg" width="20px"  height="20px" value="abc"  onclick="HS_setDate(document.getElementById('checkout'))" />
                                    </td>
                                </tr>


                                <tr>
                                    <td align ="center"> 
                                        <input type="image" src="../Img/bt2.gif"  id="search" onmouseover="this.src='../Img/bt3.gif'"  onmouseout="this.src='../Img/bt2.gif'" onclick="search()"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </fieldset>

                </td>
                <td align="centre" valign ="top">
                    <fieldset>
                        <legend>Search Results</legend>
                        <div>

                            <table style="width: 100%">
                                <%
                                    DataBase db1 = new DataBase();
                                    String str1 = "Select HOTEL_ID,HOTEL.HOTEL_NAME,HOTEL.ADDRESS From HOTEL";
                                    str1 = str1 + " Where STATUS=1";
                                    // CITY_ID='"+city+"' AND ROOM.STATUS=1 GROUP BY ROOM.HOTEL_ID";
                                    if (!"".equals(city)) {
                                        str1 = str1 + " and City_ID='" + city + "'";
                                    }
                                    if (!"".equals(content)) {
                                        str1 = str1 + " and (HOTEL_NAME like '%" + content + "%' or ADDRESS like '%" + content + "%')";
                                    }

                                    ResultSet rs1 = db1.ExecuteSQL(str1);
                                %>
                                <%=str1%></br>
                                <%   while (rs1.next()) {


                                %>
                                <tr>

                                    <td style= "border-width: 1px; border-top: dotted;border-top-color: blue"><img src="../Img/h<%=rs1.getString("HOTEL_ID")%>.jpg" width="128" height="128" alt="h1"/>
                                    </td>
                                    <td valign="top" align ="left" style= "border-width: 1px; border-top: dotted;border-top-color: blue">
                                        <div>
                                            <a href=""><%=rs1.getString("HOTEL_NAME")%></a>   

                                        </div>
                                        <div><a href=""><%=rs1.getString("ADDRESS")%></a> </div>
                                        <div>room details
                                            <table style="width: 100%" cellpadding="0" cellspacing="0" >
                                                <%
                                                    DataBase db2 = new DataBase();
                                                    String str2 = "select HOTEL_ID ,PRICE.TYPE_ID AS TYPE_ID,PRICE, TYPE_NAME,EXTRA_BED,MAX_PEOPLE from PRICE left join Type on Type.Type_Id=PRICE.Type_Id where HOTEL_ID='" + rs1.getString("HOTEL_ID") + "'";
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
                                        <input type="button" value="Book" onclick="book('<%=rs1.getString("HOTEL_ID")%>','<%=types%>')" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
                                    </td>
                                </tr>
                                <%
                                        rs2.close();
                                        db2.SQLRelase();
                                    }
                                    if (rs1.getRow() == 0) {
                                        out.println("no results");
                                    }
                                    rs1.close();
                                    db1.SQLRelase();
                                %>
                            </table>

                        </div>
                    </fieldset>
                </td>

            </tr>

        </table>
    </body>
</html>
