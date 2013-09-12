<%-- 
    Document   : index
    Created on : 2012-8-30, 2:18:21
    Author     : Administrator
--%>


<%@page import="myClass.helloresource"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript" src="js/json2.js"></script>
        <script language="javascript" src="js/jquery.js"></script>
    </head>
    <body>
        <script language="javascript">
            function get(){
                var url ="http://localhost:8080/CSE-Doodle/myClass/helloworld/say/"+document.getElementById("get").value;
                //   var para ="name="+ document.getElementById("get").value;
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
                XMLHttpReq.open("GET", url, false);
                XMLHttpReq.send(null);
                if (XMLHttpReq.readyState == 4) { 
                    if (XMLHttpReq.status == 200) {
                        var responseText = XMLHttpReq.responseText;
                        // alert(responseText);
                        document.getElementById("re_get").innerHTML = responseText;
                    }
                }
            }
            function post(){
                var url ="http://localhost:8080/CSE-Doodle/myClass/helloworld/afternoon";
                var para ="name="+ document.getElementById("post").value;
             
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
                XMLHttpReq.open("POST", url, false);
                XMLHttpReq.send(para);
                //   alert(para);
                if (XMLHttpReq.readyState == 4) { 
                    if (XMLHttpReq.status == 200) {
                        var responseText = XMLHttpReq.responseText;
                        // alert(responseText);
                        document.getElementById("re_post").innerHTML = responseText;
                    }
                }
            }
            function jsonp(){
                $.ajax( { 
                   url : "http://localhost:8080/CSE-Doodle/myClass/helloworld/afternoonjson",  
                    type : "POST",  
                    data : {name:"kate",name2:"jack"},   //or [1,2,3]--- array;
                    dataType : "json",                   //html-->string .....json-->object
                    contentType:"application/x-www-form-urlencoded",  
                    async : false,                      //asynchronous  or
                    success : function(data) {  
                       // alert(data); 
                         document.getElementById("re_jsonp").innerHTML = data[0]+" + "+data[1];
                     },  
                    error : function() {  
                        alert("ajax error");  
                    }  
                });
               
            }
            
            
            function jsong(){
               // var url ="http://localhost:8080/R3/myclass/helloworld/evening";
              
                $.ajax( {  
                    url : "./myClass/helloworld/evening",  
                    type : "GET",  
                    data : {name:"kate",name2:"jack"},   //or [1,2,3]--- array;
                    dataType : "json",  
                    contentType:"application/x-www-form-urlencoded",  
                    async : false,  
                    success : function(data) {  
                       // alert(data); 
                         document.getElementById("re_jsong").innerHTML = data[0]+" and " + data[1];
                       
                    },  
                    error : function() {  
                        alert("ajax error");  
                    }  
                });
            }
            
            
        </script>
        <fieldset>
            <legend>GET</legend>
            <input type="text" name="get" id="get" style="width:100px"/>
            <input type="button" value="get" onclick="get()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
            <label id="re_get"></label>
        </fieldset>

        <fieldset>
            <legend>POST</legend>
            <input type="text" name="post" id="post" style="width:100px"/>
            <input type="button" value="post" onclick="post()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
            <label id="re_post"></label>
        </fieldset>
        <fieldset>
            <legend>JSON--get</legend>
            <input type="button" value="jsong" onclick="jsong()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
            <label id="re_jsong"></label>
        </fieldset>
         <fieldset>
            <legend>JSON--post</legend>
            <input type="button" value="jsonp" onclick="jsonp()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
            <label id="re_jsonp"></label>
        </fieldset>
    </body>
</html>
