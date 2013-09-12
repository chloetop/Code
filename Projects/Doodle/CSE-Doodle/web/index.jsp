<%-- 
    Document   : index
    Created on : 2012-9-22, 14:57:01
    Author     : viennayy
--%>

<%@page import="java.io.PrintWriter"%>

<%@page import="standard.DataBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <script language="javascript" src="js/json2.js"></script>
        <!--  <script language="javascript" src="js/json.js"></script>-->
        <script language="javascript" src="js/jquery.js"></script>
         <script language="javascript" src="js/jquery.json-2.3.js"></script>
        
    </head>
    <body>
        <script language="javascript">
            var arr = [1,2];
         function a(){
             this.name = "123";
             this.age = "66";
             this.arr = arr;
         }   
         function jsonp(){
              var b = new a();
             // alert(b.arr[1]);
             var bb =$.toJSON(b);
             var cc =JSON.stringify(bb);
             alert(JSON.stringify(bb));
             var json = "{\"name\":\"123\",\"name2\":\"abc\"}";
             var c = {name:"kate",name2:"jack"};
                $.ajax( { 
                   url : "./REST/Polls/Create",  
                    type : "POST",  
                    data :bb,//{name:"kate",name2:"jack"},   //or [1,2,3]--- array;
                    dataType : "html",                   //return type html-->string .....json-->object
                    contentType:"application/json",     // if data is a json type, contentType must be set
                    async : true,                      //asynchronous  or
                    beforeSend : function (xhr){
                            
                    },
                    success : function(data) {  
                        //alert(data); 
                         document.getElementById("re_jsonp").innerHTML = data;
                     }, 
                     complete : function (xhr){
                         
                     },
                    error : function() {  
                        alert("ajax error");  
                    }  
                });
               
            }   
            
            function jsong(){
               // var url ="http://localhost:8080/CSE-Doodle/myClass/Poll/get";
              
                $.ajax( {  
                    url : "./myClass/Poll/get",  
                    type : "GET",  
                   // data : {name:"kate",name2:"jack"},   //or [1,2,3]--- array;
                   // dataType : "json",  
                    contentType:"application/x-www-form-urlencoded",  
                    async : false,  
                    success : function(data) {  
                       // alert(data); 
                         document.getElementById("re_jsong").innerHTML = data;
                       
                    },  
                    error : function() {  
                        alert("ajax error");  
                    }  
                });
            }
        </script>
       <input type="button" value="jsonp" onclick="jsonp()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
        <label id="re_jsonp"></label>
       <input type="button" value="jsong" onclick="jsong()" style="border-bottom-style: none;border-top-style: none;border-left-style: none;border-right-style: none; " onmouseover="this.style.background='#3366ff'"  onmouseout="this.style.background='#a9a9a9'"/> 
            <label id="re_jsong"></label>
    </body>
   
</html>
