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

    <body onload="Init()">
        <script language="javascript">
          
               
            function Init(){
                
                var strurl = "<%=resturl%>MyVotes/"+$("#Userid").val().trim();
                var para = null;
                $.ajax( { 
                    url : strurl,  
                    type : "GET",  
                    data : para,   //or [1,2,3]--- array;
                    dataType : "json",                   //html-->string .....json-->object------response value type
                    contentType:"application/x-www-form-urlencoded",       //  request value type
                    async : false,                      //asynchronous  or
                    beforeSend: function(){
                    },
                    success : function(data) {  
                        //                        alert($.toJSON(data));
                        //                        alert(data.length);
                        var ht1 = "<table>";
                        ht1 += "<tr><td width=80px>Title</td><td width=200px>Dexcription</td><td width=150px>Lastmodified</td></tr>" 
                        for(var i = 0; i< data.length ;i++){
                            ht1 += "<tr><td><a href=\"../Polls/"+data[i].Poll_ID.trim()+"\">"+data[i].Poll_Title.trim()+"</a></td><td>"+data[i].Poll_Description.trim()+"</td><td>"+data[i].Poll_Lastmodify.trim()+"</td></tr>" 
                        }
                        ht1 +="</table>";
                        $("#p1").html(ht1);
                    },  
                    error : function() {  
                    },
                    complete: function(){
                    }
                });
            }
            
            
            $(function(){
                $("#toggleLogin").toggle(function(){
                    $("#login").parent("div").animate({ height : 100 } , 520 );
                    $("#login").animate({marginTop : 0 } , 500 );
                    $(this).blur();
                },function(){
                    $("#login").parent("div").animate({ height : 0 } , 500 );
                    $("#login").animate({marginTop : -100 } , 520 ); 
                    $(this).blur();
                });
                $("#closeLogin").click(function(){
                    $("#login").parent("div").animate({ height : 0 } , 500 );
                    $("#login").animate({marginTop : -100 } , 520 ); 
                    $.ajax( { 
                        url : "SetUser.jsp",  
                        type : "POST",  
                        data : "type=1&Uid="+$("#log").val().trim(),   //or [1,2,3]--- array;
                        dataType : "html",                   //html-->string .....json-->object
                        contentType:"application/x-www-form-urlencoded",  
                        async : false,                      //asynchronous  or
                        beforeSend: function(){
                        },
                        success : function(data) {  
                            $("#llogin").html($("#log").val().trim());
                            $("#Userid").val($("#log").val().trim());
                            Init();
                        },  
                        error : function() {  
                        },
                        complete: function(){
                        }
                    });
                   
                       
                   
                   
                });
            })
       
       
     
  
   
    
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

                    <a href="#">
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

                    <a href="../Polls/Holiday">
                        <li  >
                            <img src="../images/mail.png" alt="contact" />
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
                    <div1 id="p1" style="display:block;z-index:1; font-size: 15px; font-weight:bolder; text-align: left  " ></div1>
                    <!-- <input type="button" value="" onclick="Init()"/>-->
                </div>   
            </article>

            <footer>
                <input type="text" name="" value="" id="Userid" style="display:none"/>
                </br>
                2012 Yang Yu | CSE- Doodle
            </footer>
        </div>
    </body>
</html>
