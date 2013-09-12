<%-- 
    Document   : test
    Created on : 2012-3-23, 17:54:15
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
            session.setAttribute("Time", "1090");
            session.setAttribute("data", "mar");
            

        %>
        <script language="javascript">
            
           // document.onclick=mouseClick;
            function click(element){
//                input=document.all.para.value
//                document.all.para.value=element.id
//                var trid = element.id
//                alert(trid)
            }
           
            function check(id)
            { var str = ""
                if(document.getElementById(id).checked ==true) {
                    document.getElementById("tt").value=document.getElementById("tt").value+id+"-"
                }
                else {
                    var t = document.getElementById("tt").value.split('-')
                    var str3 = "";
                    for(var i = 0;i<t.length-1;i++){
                        if(t[i]==id)
                            continue;
                        else
                            str3 = str3 + t[i]+"-"
                    }
                    document.getElementById("tt").value=str3
                }
            }
            var XMLHttpReq;
            function createXMLHttpRequest() {
             
                if(window.XMLHttpRequest) { //Mozilla 
                    XMLHttpReq = new XMLHttpRequest();
                }
                else if (window.ActiveXObject) { // IE
                    try {
                        XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (e) {
                        try {
                            XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {}
                    }
                }
            }
        
            function ajaxfun(){
               if(window.XMLHttpRequest) { //Mozilla 
                    XMLHttpReq = new XMLHttpRequest();
                }
                else if (window.ActiveXObject) { // IE
                    try {
                        XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (e) {
                        try {
                            XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {}
                    }
                }
                XMLHttpReq.open("GET", "test2.jsp", true);
                XMLHttpReq.onreadystatechange = processResponse;//
                XMLHttpReq.send(null);  // 
                alert("ok")
               
            }
            function processResponse() {
                if (XMLHttpReq.readyState == 4) { // 
                    if (XMLHttpReq.status == 200) { // 
                        
                         
                    } else { //
                        window.alert("error");
                    }
                }
            }
        function bt4(){
                 var t = document.getElementById("tt").value.split('-')
                 document.getElementById("tt").value=""
                 for(var i = 0;i<t.length-1;i++){
                     document.getElementById(t[i]).checked = false
                 }
                     
                  
        }
        
        function bt5() {
               window.location="test2.jsp"
            
        }
        function bt6() {
          if(confirm("ok?")) {
              alert("ok")
          }
              else{
                  alert("not ok")
              }
                  
        }
        </script>
    </head>
    <body>

        <h1>Hello World!</h1>
        <input type="submit" value="bt1" name="bt1" onclick="cc('01')"/>
        <input type="submit" name="Submit" value="提交" onclick="ale()" />
        <input type="text" name="t1" value=""  hidden=true disabled=true style="display:none"  />
        <input type="checkbox" name="aa" value="ON1" onclick="check('aa')" />
        <input type="checkbox" name="bb" value="ON2" onclick="check('bb')"/>
        <input type="submit" value="bt2" name="bt2"  onclick="check()"/>
        <input type="text" name="tt" />
        <input type="submit" value="bt3" name="bt3"  onclick="ajaxfun()"/>
          <input type="submit" value="bt4" name="bt4"  onclick="bt4()"/>
             <input type="submit" value="bt5" name="bt5"  onclick="bt5()"/>
          <a href="test3.jsp">test3</>
        <%= request.getSession().getAttribute("Time")%>
        <%= request.getSession().getAttribute("data")%>
        
        
        <input type="submit" value="bt6" name="bt6"  onclick="bt6()"/>
    </body>
</html>
