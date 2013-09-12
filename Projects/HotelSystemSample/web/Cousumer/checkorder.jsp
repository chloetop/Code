<%-- 
    Document   : checkorder
    Created on : 2012-5-2, 20:57:11
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
     String orderid = request.getParameter("ID");
    %>
    <body>
        <table style=" width: 100%; height: 100%;border: 0pt none">
            <tr style="height: 100px;background-color:rgb(0,53,128) ">
                <td  colspan="3"></td>


            </tr>
            <tr>
                <td style=" width: 35%;"></td>
                <td align="centre">
                    <fieldset>
                        <legend>Booking Detail</legend>
                          <div style="background-color: orange">
                            <form name="PinCheck" id="PinCheck" action="../PinCheck" method="POST">
                                <table style="width: 100%">
                                    <tr>
                                        <td>PIN Code:</td>
                                        <td><input type="text" name="pin" id="pin" value="" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/></td>
                                    </tr>
                                    <input type="text" name="orderid" id="orderid" value="<%=orderid%>" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/>
                                    <tr>
                                        <td colspan="2" align ="center">
                                           <input type="submit" value="ok" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </fieldset>
                </td>
                <td style=" width: 35%; " align="centre" valign ="top">

                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">CopyRight:</td>
            </tr>
        </table>
    </body>
</html>
