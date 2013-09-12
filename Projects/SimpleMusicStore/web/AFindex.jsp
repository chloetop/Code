<%-- 
    Document   : index
    Created on : 2012-3-19, 18:26:51
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Music</title>
        <script language="javascript">
            function bt1(){
                document.getElementById("tr1").style.display=""
                document.getElementById("tr2").style.display="none"
            }
            function bt2(){
                document.getElementById("tr2").style.display=""
                document.getElementById("tr1").style.display="none"
            }
            function aa(){
                alert("a")
                document.getElementById("Search").style.background="#ffffff"
            }
        </script>
    </head>
    <body>
        <table style="width: 100%">
            <tr  height="20%">
                <td width="20%"></td>
                <td width="60%"></td>
                <td width="20%"></td>
            </tr>
            <tr height="60%">
                <td></td>
                <td>
                    <table width="100%">
                        <tr style="background-color: #a9a9a9; color: #ffffff; font-size: 30pt"> 
                            <td style="width: 50%" align="center">Web Music Store</td>
                            <td style="width: 50%"><u><a onclick="bt1()"  style="cursor: pointer">Search</a></u>&nbsp;&nbsp;&nbsp;<u><a onclick="bt2()" style="cursor: pointer">About us</a></u></td>
            </tr>
            <tr id="tr2" style="display: none" ><td colspan="=2"> this is an simple web app. </td></tr>
            <tr id="tr1">
                <td colspan="2" >
                    <form action="SearchPage1" method="POST">
                        <span  style="width: 100px">Albums:<input type="radio" name="sType" value="r1" id="r1" checked="checked" /></span>
                        <span style="width: 100px">Songs:<input type="radio" name="sType" value="r2" id="r2" /></span>
                        <input type="text" name="Search" value="" id="Search" style="background-color: #a9a9a9"  onfocus="this.style.background='#ffffff'" onblur="this.style.background='#a9a9a9'"/>
                        <input type="submit" value="Search"  style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none" onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/>
                        <!--            <input type="text" name="sGenre" value="" style="display:none"/>-->
                        <input type="text" name="sArtist" value="" style="display:none"/>
<!--                        <input type="text" name="sYear" value="" style="display:none"/>-->
                        <select name="sYear" style="display:none"/>
                        <option  selected=true></option>
                        <option>2012</option>
                        <option >2011</option>
                        <option>2010</option>
                        <option>2009</option>
                        <option>2008</option>
                        <option>2007</option>
                        </select>
                        
                        <select name="sGenre" style="display:none"/>
                        <option  selected=true></option>
                        <option>Country</option>
                        <option >Pop</option>
                        <option>Jazz</option>
                        <option>Latin</option>
                        <option>Soul</option>
                        </select>
                        <input type="text" name="ids" value="" style="display:none"/>
                        <!--            <input type="checkbox" name="aa" value="ON1" /><input type="checkbox" name="bb" value="ON2" checked="checked" />-->
                        <!--            <a href ="http:\\www.google.com" >link</a>-->
                    </form>
                </td>
            </tr>
            <tr >
                <td colspan="2"> 
                    <img src="bg.jpg" width="1024" height="468" alt="bg"/>
                </td>
            </tr>
        </table>
    </td>
<td></td>
</tr>
<tr height="10%"><td></td><td align ="center">Copyright 2012 Z3342248 Yang Yu, All Rights Reserved</td><td></td></tr>
</table>
</body>
</html>
