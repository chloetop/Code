<%-- 
    Document   : consumer
    Created on : 2012-4-26, 18:48:06
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript" src="JS/CheckFieldData.js"></script>
    </head>
    <body>
        <script language="javascript">
           
            function btOK(){
                var Err = "";
               
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
               
                if(IsNumNull(Err)) {
                    alert(Err);
                    return ;
                }else {
                    var form = document.getElementById("SignIn");
                    form.submit();
                } 
                 
            }
            
        </script>
        <table style=" width: 100%; height: 100%;border: 0pt none">
            <tr style="height: 100px;background-color:rgb(0,53,128) ">
                <td  colspan="3"></td>


            </tr>
            <tr>
                <td style=" width: 35%;"></td>
                <td align="centre">
                    <fieldset>
                        <legend>Sign In</legend>
                          <div style="background-color: orange">
                            <form name="SignIn" id="SignIn" action="SignIn" method="POST">
                                <table style="width: 100%">
                                    <tr>
                                        <td>Email Address(Account)</td>
                                        <td><input type="text" name="account" id="account" value="" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/></td>
                                    </tr>
                                    <tr>
                                        <td>Password</td>
                                        <td><input type="password" name="pwd" id="pwd" value="" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/></td>
                                    </tr>

                                    <tr>
                                        <td colspan="2" align ="center">
                                            <input type="button" value="OK" onclick="btOK()" style=" width: 150px;border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
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
