<%-- 
    Document   : index
    Created on : 2012-3-19, 18:26:51
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            session.setAttribute("Albums", "");
            session.setAttribute("Songs", "");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Music</title>
    </head>
    <body>
        <table>
            <tr style=" "></tr>
            <tr>
            <form action="SearchPage1" method="POST">
                <h1>Web Music Store</h1>
                <input type="radio" name="sType" value="r1" id="r1" checked="checked" />
                <input type="radio" name="sType" value="r2" id="r2" /></br>
                <input type="text" name="Search" value="" id="Search"/><input type="submit" value="Search" />
                <!--            <input type="text" name="sGenre" value="" style="display:none"/>-->
                <input type="text" name="sArtist" value="" style="display:none"/>
                <input type="text" name="sYear" value="" style="display:none"/>
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
        </tr>
        <tr></tr>
    </table>
</body>
</html>
