<%-- 
    Document   : GetPoll_P
    Created on : 2012-10-11, 0:35:35
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            String resturl = "http://localhost:8080/CSE-Doodle/REST/";

        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="keywords" content="CSE-Doodle" />
        <meta name="description" content="CSE-Doodle" />

        <title>CSE-Doodle</title>

        <script type="text/javascript">

            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-21544974-1']);
            _gaq.push(['_trackPageview']);

            (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();
            
            
        </script>

        <script type="text/javascript" src="../js/jquery-1.8.2.js"></script>
        <script language="javascript" src="../js/jquery.json-2.3.js"></script>
        <script type="text/javascript" src="../js/jquery.ui.core.js"></script>
        <script type="text/javascript" src="../js/jquery.ui.widget.js"></script>
        <script type="text/javascript" src="../js/jquery.ui.dialog.js"></script>
        <script type="text/javascript" src="../js/jquery.ui.datepicker.js"></script>

        <script type="text/javascript" src="../js/myjs.js"></script>

        <link rel="stylesheet" href="../css/jquery.ui.all.css" type="text/css">
        <link media="screen,projector" type="text/css" href="../css/style.css" rel="stylesheet" />
        <link rel="shortcut icon" href="favicon.ico"> 
        <link href='http://fonts.googleapis.com/css?family=Alex+Brush' rel='stylesheet' type='text/css'>
        <style>      h3 {       font-family: 'Alex Brush', cursive;        font-size: 35px;   color: white     }    </style>
        <link href='http://fonts.googleapis.com/css?family=Finger+Paint' rel='stylesheet' type='text/css'>
        <style>      h4 {       font-family: 'Finger Paint', serif;        font-size: 25px;   color: white     }    </style>


        <link rel="stylesheet" href="../css/fx.slide.css" type="text/css" media="screen" />
    </head>

    <body >
        <script language="javascript">
          
            function getholiday(){
               // alert(document.getElementById("state").value.trim());
                var state = document.getElementById("state").value.trim();
                var type = document.getElementById("type").value.trim();
              //  alert("<%=resturl%>pubholservice/"+state+"/"+type);
                if(type == "XML")
                    $("#p8").html("<a href=\""+"<%=resturl%>pubholservice/"+state+"\" >"+"<%=resturl%>pubholservice/"+state+"</a>");
                if(type=="HTML")
                    $("#p8").html("<a href=\""+"<%=resturl%>pubholservice/"+state+"/show"+"\">"+"<%=resturl%>pubholservice/"+state+"/show"+"</a>");
            }
            
            function check(){
                var state = document.getElementById("state").value.trim();
                var date =  document.getElementById("date").value.trim();
                document.getElementById("mainframe").src="<%=resturl%>pubholservice/"+state+"/"+date;
            }
       
     
  
   
    
        </script>

        <div id="wrapper">  

            <header> 
                <a href="#" style="text-decoration:none"> <h3>CSE-Doodle</h3></a>
            </header>

            <nav>        
                <ul>            
                    <a href="../index.jsp">
                        <li class="active" >
                            <img src="../images/home.png" alt="home" />
                            <div class="tooltip">Home</div>
                        </li>
                    </a>

                    <a href="../Polls/MyPolls">
                        <li  >
                            <img src="../images/pictures.png" alt="news" />
                            <div class="tooltip">My Polls</div>
                        </li>
                    </a>

                    <a href="../Polls/MyVotes">
                        <li   >
                            <img src="../images/portfolio.png" alt="portfolio" />
                            <div class="tooltip">My Votes</div>
                        </li>
                    </a>



                    <a href="#" id ="toggleLogin">
                        <li  >
                            <img src="../images/person.png" alt="about_me" />
                            <div class="tooltip" id="llogin">Sign In</div>
                        </li>
                    </a>

                    <a href="#">
                        <li  >
                            <img src="../images/mail.png" alt="Holiday" />
                            <div class="tooltip">Holiday</div>
                        </li>
                    </a>
                </ul>

            </nav>
            <div align ="center">
                <div style="margin: 0px; overflow: hidden; position: relative; height: 0px; width: 600px">
                    <div id="login" style="margin: -100px 0px 0px; height: auto;">
                        <div class="loginContent">
                            <label for="log"><b>Username: </b></label>
                            <input class="field" type="text" name="log" id="log" value="" size="23" />
                            <input type="button" name="submit" value="" class="button_login" id="closeLogin" />
                        </div>
                    </div> 
                </div>
            </div>

            <article id="art1">        
                <div class="line_gradient"></div>                              

                <div class="reflex"></div>
                <div class="line short "></div>        
                <div class="text large  ">        
                    <div1 id="p1" style="display:block;z-index:1; font-size: 15px; font-weight:bolder; text-align: left  " >Holiday</div1>
                    <!-- <input type="button" value="" onclick="Init()"/>-->
                    <select name="aa" id="state">
                        <option value ="nsw">NSW</option>
                        <option value ="nt">NT</option>
                        <option value ="qld">QLD</option>
                        <option value ="vic">VIC</option>
                    </select>
                    <select name="bb" id ="type">
                        <option value ="XML">XML</option>
                        <option value ="HTML">HTML</option>
                    </select>
                    <a href="#" id ="Save5"> <img src="../images/ok.png"  style="width:20px" onclick="getholiday()" ></a>
                    <input type="text" name="aa" value="" id="date"/>
                    <a href="#" id ="Save6"> <img src="../images/ok.png"  style="width:20px" onclick="check()" ></a>
                    <br>
                    <div1 id="p8" style=" color: white"></div1>
                </div>   
                <iframe id="mainframe" name="mm" src="" width="450px" height="100%" marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="no"></iframe>
            </article>

            <footer>
                <input type="text" name="" value="" id="Userid" style="display: none"/>
                </br>
                2012 Yang Yu | CSE- Doodle
            </footer>
        </div>

    </body>
</html>
