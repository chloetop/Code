<%-- 
    Document   : error
    Created on : 2012-4-26, 20:17:07
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table style=" width: 100%; height: 100%;border: 0pt none">
            <tr style="height: 100px;background-color:rgb(0,53,128) ">
                <td  colspan="3"></td>


            </tr>
            <tr>
                <td style=" width: 25%;"></td>
                <td align="centre">
                    <fieldset>
                        <legend>Error Information</legend>
                        <div>

                            <table style="width: 100%">
                                <tr>
                                    <td>Description</td>
                                    <td><%=request.getParameter("des") %></td>
                                </tr>
                                <tr>
                                    <td>Link</td>
                                    <td><a href="<%=request.getParameter("page") %>"> return last page</a></td>
                                </tr>
                                
                            </table>
                        </div>
                    </fieldset>
                </td>
                <td style=" width: 25%; " align="centre" valign ="top">

                </td>
            </tr>
            <tr>
                <td colspan="3" align="center"></td>
            </tr>
        </table>
    </body>
</html>
