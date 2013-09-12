<%@page import="java.sql.ResultSet"%>
<%@page import="PublicClass.DataBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Page</title>
        <script language="javascript" src="JS/calendar.js"></script>
        <script language="javascript" src="JS/CheckFieldData.js"></script>
    </head>
    <body>
        <script language="javascript">
            //            onfocus="HS_setDate(this)"src="JS/calendar.js"
//            function convertData(id) {
//               var data = document.getElementById(id).value.split('-');
//                alert(data[1]);
//                if(data[1].length<2)
//                    data[1] = "0"+data[1];
//                alert(data[1]);
//            }
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
                   
                    var link = "Consumer/roomlist.jsp?city="+city+"&content="+content+"&checkin="+checkin+"&checkout="+checkout;
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
                <% String UID = (String) request.getSession().getAttribute("UID");
                    if ("".equals(UID) || UID == null) {
                %>
                <td ><a href="consumer.jsp" style="color: white">Sign in</a><br><a href="Consumer/CreateAccount.jsp" style="color: white">Sign up</a></td>
                    <% } else {%>
                <td style=" color: white " >Welcome: <%=UID%> </br> <a href="clear.jsp">Sign out</a></td>
                <%}%>
            </tr>
            <tr>
                <td style=" width: 15%;"></td>
                <td align="centre">
                    <fieldset>
                        <legend>Search Hotels</legend>
                        <div>
                            <table>
                                <tr>
                                    <td>City</td>
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
                                    <td><input type="text" name="content" id="content" value="" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/></td>
                                </tr>
                                <tr>
                                    <td>Check-In Date</td>
                                    <td><input type="text" name="checkin" id="checkin" value="" readonly="readonly"/>
                                        <input type="image" src="Img/calendar.jpg" width="20px"  height="20px" value="abc"  onclick="HS_setDate(document.getElementById('checkin'))" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Check-Out Date</td>
                                    <td><input type="text" name="checkout" id="checkout" value="" readonly="readonly"/>
                                        <input type="image" src="Img/calendar.jpg" width="20px"  height="20px" value="abc"  onclick="HS_setDate(document.getElementById('checkout'))" />
                                    </td>
                                </tr>
                                
                                <tr><td colspan="2" align ="center"> 
                                        <input type="image" src="Img/bt2.gif"  id="search" onmouseover="this.src='Img/bt3.gif'"  onmouseout="this.src='Img/bt2.gif'" onclick="search()"/>
                                    </td></tr>
                            </table>
                        </div>
                    </fieldset>
                </td>
                <td style=" width: 35%; " align="centre" valign ="top">
                    <fieldset>
                        <legend>About Us</legend>
                        <div>content</div>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">CopyRight:</td>
            </tr>
        </table>
    </body>
</html>
