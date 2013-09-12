<%-- 
    Document   : CreateAccount
    Created on : 2012-4-24, 19:53:40
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Account</title>
        <script language="javascript" src="../JS/CheckFieldData.js"></script>
    </head>
    <body>
        <script language="javascript">
           
            function cna(){
                var Err = "";
               
//                var val = (document.getElementById("id").value).trim();
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
                    var form = document.getElementById("SignUp");
                    form.submit();
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
                <td  colspan="3"></td>


            </tr>
            <tr>
                <td style=" width: 25%;"></td>
                <td align="centre">
                    <fieldset>
                        <legend>Information</legend>
                        <div>
                            <form name="SignUp" id="SignUp" action="../A.CreatAccount" method="POST">
                                <table style="width: 100%">
                                    <tr>
                                        <td>Email Address(Account)</td>
                                        <td><input type="text" name="id" id="id" value="" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/></td>
                                    </tr>
                                    <tr>
                                        <td>Password</td>
                                        <td><input type="password" name="pwd" id="pwd" value="" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/></td>
                                    </tr>
                                    <tr>
                                        <td>Name</td>
                                        <td><input type="text" name="name" id="name" value="" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/></td>
                                    </tr>
                                    <tr>
                                        <td>Telephone</td>
                                        <td><input type="text" name="phone" id="phone" value="" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align ="center">
                                            <input type="button" value="Create New Account" onclick="cna()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </fieldset>
                </td>
                <td style=" width: 25%; " align="centre" valign ="top">

                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">CopyRight:</td>
            </tr>
        </table>
    </body>
</html>
