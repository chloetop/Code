<%-- 
    Document   : index
    Created on : 2012-10-5, 22:05:36
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            String pid = request.getParameter("pid").toString().trim();
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

        <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
        <script language="javascript" src="js/jquery.json-2.3.js"></script>
        <script type="text/javascript" src="js/jquery.ui.core.js"></script>
        <script type="text/javascript" src="js/jquery.ui.widget.js"></script>
        <script type="text/javascript" src="js/jquery.ui.dialog.js"></script>
        <script type="text/javascript" src="js/jquery.ui.datepicker.js"></script>

        <script type="text/javascript" src="js/myjs.js"></script>

        <link rel="stylesheet" href="css/jquery.ui.all.css" type="text/css">
        <link media="screen,projector" type="text/css" href="css/style.css" rel="stylesheet" />
        <link rel="shortcut icon" href="favicon.ico"> 
        <link href='http://fonts.googleapis.com/css?family=Alex+Brush' rel='stylesheet' type='text/css'>
        <style>      h3 {       font-family: 'Alex Brush', cursive;        font-size: 35px;   color: white     }    </style>
        <link href='http://fonts.googleapis.com/css?family=Finger+Paint' rel='stylesheet' type='text/css'>
        <style>      h4 {       font-family: 'Finger Paint', serif;        font-size: 25px;   color: white     }    </style>


        <link rel="stylesheet" href="css/fx.slide.css" type="text/css" media="screen" />
    </head>

    <body onload="Init()">
        <script language="javascript">
            //            $(function() {
            //                
            //                $('#datepicker').datepicker( { onSelect: function(dateText, inst) { alert(dateText);} } );
            //            });
           
            function Init(){
                $.ajax( { 
                    url : "SetUser.jsp",  
                    type : "POST",  
                    data : "type=2",   //or [1,2,3]--- array;
                    dataType : "html",                   //html-->string .....json-->object
                    contentType:"application/x-www-form-urlencoded",  
                    async : false,                      //asynchronous  or
                    beforeSend: function(){
                    },
                    success : function(data) {  
                        if(data.toString().trim()=="")
                            $("#llogin").html("Sign In");
                        else
                            $("#llogin").html(data.toString().trim());
                    },  
                    error : function() {  
                    },
                    complete: function(){
                    }
                });
                ////////////////////////////////data/////////////////////////////////////////
            
                $.ajax( { 
                    url : "<%=resturl%>Polls/<%=pid%>",  
                    type : "GET",  
                    data : null,   //or [1,2,3]--- array;
                    dataType : "json",                   //html-->string .....json-->object------response value type
                    contentType:"application/x-www-form-urlencoded",       //  request value type
                    async : false,                      //asynchronous  or
                    beforeSend: function(){
                    },
                    success : function(data) {  
                      //  alert($.toJSON(data));
                        $("#title").val(data.pb.Poll_Title.trim());
                        $("#type").val(data.pb.Poll_Type.trim());
                        $("#description").val(data.pb.Poll_Description.trim());
                        $("#name").val(data.pb.Poll_Initiator.trim());
                       // alert(data.pb.Poll_Title.trim());
                       
                             
                  
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
                            // alert(data);
                        },  
                        error : function() {  
                        },
                        complete: function(){
                        }
                    });
                    $("#llogin").html($("#log").val());
                });
            })
            
            var tid=0;
            
            function ajaxfun(dataobj,strurl){
               
             //   alert(strurl);
              //  alert($.toJSON(dataobj));
                var Json = $.toJSON(dataobj);
                $.ajax( { 
                    url : strurl,  
                    type : "PUT",  
                    data : Json,   //or [1,2,3]--- array;
                    dataType : "html",                   //html-->string .....json-->object
                    contentType:"application/json",  
                    async : false,                      //asynchronous  or
                    beforeSend: function(){
                        // Handle the beforeSend event
                 
                    },
                    success : function(data) {  
                      //  alert(data); 
                        
                    },  
                    error : function() {  
                        // alert(document.getElementById("title").value);  
                    },
                    complete: function(){
                        // Handle the complete event
                       
                        //  alert(document.getElementById("title").value); 
                    }
                });
            }
           
            function Createpoll(){
                //                Poll_ID varchar(100) primary key,
                //                Poll_Title varchar(100),
                //                Poll_Description varchar(100),
                //                Poll_Initiator varchar(100),
                //                Poll_Type int,
                //                Poll_Lastmodify varchar(100),
                //                Poll_Descsion varchar(100)
                //structure poll
                var status = "1"; // 1----create; 2-----rating 3---over
                var pollid = "<%=pid%>";
                var initiator = "";
                $.ajax( { 
                    url : "SetUser.jsp",  
                    type : "POST",  
                    data : "type=2",   //or [1,2,3]--- array;
                    dataType : "html",                   //html-->string .....json-->object
                    contentType:"application/x-www-form-urlencoded",  
                    async : false,                      //asynchronous  or
                    beforeSend: function(){
                    },
                    success : function(data) {  
                        initiator = data.toString().trim(); 
                        if(initiator=="")
                            initiator = $("#name").val();
                    },  
                    error : function() {  
                    },
                    complete: function(){
                    }
                });
                    
                var title = document.getElementById("title").value.trim();
                var description = document.getElementById("description").value.trim();
                var type = document.getElementById("type").value.trim(); //1=date  ;  2=text;
                var lastmodify = GetCurrentDateTime();
                var descsion = "";
                var emailto = document.getElementById("emailto").value.trim(); 
                
                //                Option_ID varchar(100) primary key,
                //                Option_Poll varchar(100),
                //                Option_Poll_Type varchar(100),
                //                Option_Content varchar(100),
                //                Option_Time varchar(100)
                var oType = type.trim();
                var oContent="";// date or lid
                var oSubCon="";  // time or location
                if(oType=="1"){
                    oContent = document.getElementById("date").value.trim(); 
                    var day = oContent.split(';');
                    for(var i = 0; i< day.length-1;i++)
                        for(var j=1;j<=3;j++){
                            if(document.getElementById(day[i]+"_"+j).value.trim()!="")
                                oSubCon += day[i]+" "+document.getElementById(day[i]+"_"+j).value.trim()+";"; 
                        }
                }
                if(oType=="2"){
                    oContent = document.getElementById("lid").value.trim();    
                    var loc = oContent.split(';');
                    for(var i=0;i<loc.length-1;i++){
                        oSubCon += document.getElementById(i).innerHTML.trim()+";";
                    }
                }
                var poll = new CreateObject(pollid,initiator,title,description,type,lastmodify,descsion,oType,oContent,oSubCon,emailto,status);
               
                setTimeout(ajaxfun(poll,"<%=session.getAttribute("Url").toString().trim()%>Polls/Poll"),3000);
                
            }
            function Next3(){
                document.getElementById("art4").style.display = "none";
                document.getElementById("art5").style.display = "block";
                Createpoll();
            }
            function Back3(){
                document.getElementById("art3").style.display = "block";
                document.getElementById("art4").style.display = "none";
            }
            function Deletetext(t){
              
                // return;
                var texts="";
                var lid = "";
                var newid=0;
                for(var i=0;i<tid;i++){
                    if(i==t)
                        continue;
                    texts += "<a href=\"javascript:Deletetext('"+newid+"');\" ><img src=\"images/trash.png\" height=\"20px\" width=\"20px\"/></a><label id='"+newid+"' style=\"font-size: 25px;font-family: 'Finger Paint', serif;\">"+document.getElementById(i).innerHTML.trim()+"</label></br>";
                    lid += newid+";";
                    newid++;
                }
                tid=newid;
                document.getElementById("ops").innerHTML=texts;
                document.getElementById("lid").value = lid;
            }
            
            function Add(){
                var ops = document.getElementById("ops").innerHTML.trim();
                var op =  document.getElementById("op").value.trim();
                document.getElementById("ops").innerHTML +="<a href=\"javascript:Deletetext('"+tid+"');\" ><img src=\"images/trash.png\" height=\"20px\" width=\"20px\"/></a><label id='"+tid+"' style=\"font-size: 25px;font-family: 'Finger Paint', serif;\">"+op+"</label></br>";
                // ops +="<a href=\"javascript:Deletedate('"+d[j]+"');\" ><img src=\"images/trash.png\" height=\"20px\" width=\"20px\"/></a>"+d[j]+"</br>";
                document.getElementById("lid").value += tid+";";
                tid++;
            }
            function Typechange(){
                var t =  document.getElementById("type").value;
                if(t==1){ //date-->text
                    document.getElementById("datepannel").style.display = "none";
                    document.getElementById("textpannel").style.display = "block";
                    document.getElementById("type").value="2";
                    document.getElementById("date").value="";
                    document.getElementById("selectedate").innerHTML="";
                    document.getElementById("ltype").innerHTML="Calendar View";
                    
                }
                else{ //text--> date
                    document.getElementById("datepannel").style.display = "block";
                    document.getElementById("textpannel").style.display = "none";
                    document.getElementById("op").value="";
                    document.getElementById("ops").innerHTML="";
                    document.getElementById("type").value="1";
                    tid=0;
                    document.getElementById("ltype").innerHTML="Free Text";
                }
            }
            function Next2(){
                document.getElementById("art3").style.display = "none";
                document.getElementById("art4").style.display = "block";
            }
            function Back2(){
                document.getElementById("art2").style.display = "block";
                document.getElementById("art3").style.display = "none";
            }
            function Deletedate(d2){
                var ds=$("#date")[0].value;
              
                var d = ds.split(';');
                //  alert(d[0]);
                ds="";
                var i=0;
                var tag = 0;
                for(i = 0; i< d.length - 1;i++){
                    if(d[i]==d2){
                        tag =1;
                        break;
                    }
                                    
                }
                var sd="";
                for(var j = 0; j< d.length - 1;j++){
                    if(tag==1 && j==i)
                        continue;
                    else{
                        ds+=d[j]+";";
                        sd+="<a href=\"javascript:Deletedate('"+d[j]+"');\" ><img src=\"images/trash.png\" height=\"20px\" width=\"20px\"/></a>"+d[j]+"&nbsp;&nbsp;&nbsp; <input type=\"text\"  value=\"\" id='"+d[j]+"_1' style=\"width:60px\"/>&nbsp;&nbsp;&nbsp;<input type=\"text\"  value=\"\" id='"+d[j]+"_2' style=\"width:60px\"/>&nbsp;&nbsp;&nbsp;<input type=\"text\"  value=\"\" id='"+d[j]+"_3' style=\"width:60px\"/></br>";
                    }
                }
                    
                $('#date').val(ds);
                // <a href="javascript:Deletedate();" ><img src="images/trash.png" height="20px" width="20px"/></a>aa</br>
                           
                
                $('#selectedate').html(sd);
                    
            }
            function Next1(){
                document.getElementById("art2").style.display = "none";
                document.getElementById("art3").style.display = "block";
                $(function() {
                    $('#datepicker').datepicker({  dateFormat: 'yy-mm-dd',
                        //altField: '#date',
                        onSelect:function(dateText, inst){
                            // alert(dateText);
                            // alert($("#date")[0].value);
                            var ds=$("#date")[0].value;
                            if(ds==""){
                                $("#date").val(dateText+";");
                                sd="<a href=\"javascript:Deletedate('"+dateText+"');\" ><img src=\"images/trash.png\" height=\"20px\" width=\"20px\"/></a>"+dateText+"&nbsp;&nbsp;&nbsp; <input type=\"text\"  value=\"\" id='"+dateText+"_1' style=\"width:60px\"/>&nbsp;&nbsp;&nbsp;<input type=\"text\"  value=\"\" id='"+dateText+"_2' style=\"width:60px\"/>&nbsp;&nbsp;&nbsp;<input type=\"text\"  value=\"\" id='"+dateText+"_3' style=\"width:60px\"/></br>";
                            }
                            else{
                                var d = ds.split(';');
                                //  alert(d[0]);
                                ds="";
                                var i=0;
                                var tag = 0;
                                for(i = 0; i< d.length - 1;i++){
                                    if(d[i]==dateText){
                                        tag =1;
                                        break;
                                    }
                                    
                                }
                                var sd="";
                                for(var j = 0; j< d.length - 1;j++){
                                    if(tag==1 && j==i)
                                        continue;
                                    else{
                                        ds+=d[j]+";";
                                        sd+="<a href=\"javascript:Deletedate('"+d[j]+"');\" ><img src=\"images/trash.png\" height=\"20px\" width=\"20px\"/></a>"+d[j]+"&nbsp;&nbsp;&nbsp; <input type=\"text\"  value=\"\" id='"+d[j]+"_1' style=\"width:60px\"/>&nbsp;&nbsp;&nbsp;<input type=\"text\"  value=\"\" id='"+d[j]+"_2' style=\"width:60px\"/>&nbsp;&nbsp;&nbsp;<input type=\"text\"  value=\"\" id='"+d[j]+"_3' style=\"width:60px\"/></br>";
                                    }
                                }
                                if(tag==0){
                                    ds+=dateText+";";
                                    sd+="<a href=\"javascript:Deletedate('"+dateText+"');\" ><img src=\"images/trash.png\" height=\"20px\" width=\"20px\"/></a>"+dateText+"&nbsp;&nbsp;&nbsp; <input type=\"text\"  value=\"\" id='"+dateText+"_1' style=\"width:60px\"/>&nbsp;&nbsp;&nbsp;<input type=\"text\"  value=\"\" id='"+dateText+"_2' style=\"width:60px\"/>&nbsp;&nbsp;&nbsp;<input type=\"text\"  value=\"\" id='"+dateText+"_3' style=\"width:60px\"/></br>";
                                }
                                $('#date').val(ds);
                                // <a href="javascript:Deletedate();" ><img src="images/trash.png" height="20px" width="20px"/></a>aa</br>
                           
                            }
                            $('#selectedate').html(sd);
                        }
                    });
                  
               
                });
            }
            function Back1(){
                document.getElementById("art1").style.display = "block";
                document.getElementById("art2").style.display = "none";
            }
            function Schedule(){
                document.getElementById("art1").style.display = "none";
                document.getElementById("art2").style.display = "block";
            }
            function showPic(text){
                var x,y;
                //                x = event.clientX;
                //                y = event.clientY;
                //                 
                //                document.getElementById("Layer1").style.left = x+100;
                //                document.getElementById("Layer1").style.top = y;
                document.getElementById("Layer1").innerHTML = "<h1>"+text+"</h1>";
                document.getElementById("Layer1").style.display = "block";
            }
            function hiddenPic(){
                document.getElementById("Layer1").innerHTML = "<a href=\"javascript:Schedule();\"><h1>Schedule an event</h1></a>";
                //  document.getElementById("Layer1").style.display = "none";
            }
        </script>

        <div id="wrapper">  

            <header> 
                <a href="#" style="text-decoration:none"> <h3>CSE-Doodle</h3></a>
            </header>

            <nav>        
                <ul>            
                    <a href="index.jsp">
                        <li class="active" >
                            <img src="images/home.png" alt="home" />
                            <div class="tooltip">Home</div>
                        </li>
                    </a>

                    <a href="Polls/MyPolls">
                        <li  >
                            <img src="images/pictures.png" alt="news" />
                            <div class="tooltip">My Polls</div>
                        </li>
                    </a>

                    <a href="Polls/MyVotes">
                        <li   >
                            <img src="images/portfolio.png" alt="portfolio" />
                            <div class="tooltip">My Votes</div>
                        </li>
                    </a>

                                   

                    <a href="#" id ="toggleLogin">
                        <li  >
                            <img src="images/person.png" alt="about_me" />
                            <div class="tooltip" id="llogin">Sign In</div>
                        </li>
                    </a>

                    <a href="Polls/Holiday">
                        <li  >
                            <img src="images/mail.png" alt="contact" />
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
           

            <article id="art2" >        
                <div class="line_gradient"></div>                              

                <div class="reflex"></div>
                <div class="line short "></div>        
                <div class="text large  ">        


                    <table>
                        <tr>
                            <td>
                                <label style="font-size: 25px;font-family: 'Finger Paint', serif;">Title</label>
                            </td>
                            <td>
                                <input type="text" name="" value="" id="title"/>
                            </td>
                        </tr>
                        <tr style="display:none">
                            <td>
                                <label style="font-size: 25px;font-family: 'Finger Paint', serif;" >Type</label>
                            </td>
                            <td align="left">
                                <input type="text" name="" value="1" id="type"/>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label style="font-size: 25px;font-family: 'Finger Paint', serif;" >Description</label>
                            </td>
                            <td>
                                <textarea name="" rows="4" cols="20" id="description">
                                </textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label style="font-size: 25px;font-family: 'Finger Paint', serif;">Your Name</label>
                            </td>
                            <td>
                                <input type="text" name="" value="" id="name"/>
                            </td>
                        </tr>
                        <tr style="display:none">
                            <td>
                                <label style="font-size: 25px;font-family: 'Finger Paint', serif;">Email</label>
                            </td>
                            <td>
                                <input type="text" name="" value="" id="email"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"  rowspan="1">
                                <a href="javascript:Back1();"><img src="images/left.png" width="50px" height="25" alt="Back" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="javascript:Next1();"><img src="images/right.png" width="50px" height="25" alt="Next" /></a>
                            </td>

                        </tr>
                    </table>
                </div>   
            </article>
            <article id="art3" style=" display: none">        
                <div class="line_gradient"></div>                              

                <div class="reflex"></div>
                <div class="line short "></div>        
                <div class="text large  ">
                    <div1 style="display:block;z-index:1;font-family: 'Finger Paint', serif; font-size: 25px;  " > <a href="javascript:Typechange();" id="ld" ><h4 id="ltype">Free Text</h4></a></div1>
                    </br>
                    <!--                    <a href="javascript:Typechange('2');" id="lt"><h4>Free text</h4></a>-->
                    <div id="datepannel">
                        <div id="datepicker" style="color: black" align="center"></div>
                        <input type="text" name="" value="" id="date" style="display:none"/>
                        <div  align="left">
                            <h4>Selected dates:</h4>
                            <div id="selectedate" style=";font-family: 'Finger Paint', serif; font-size: 20px;">

                            </div>
                        </div>
                    </div>

                    <div id="textpannel" style=" display: none">
                        <input type="text" name="" value="" id="op"/> <a href="javascript:Add();"><img src="images/zoom_in.png" width="19px" height="19px" alt="Add" /></a>
                        <div  align="left">
                            <input type="text" name="" value="" id="lid" style="display:none"/>
                            <h4>Options:</h4>
                            <div id="ops" style=";font-family: 'Finger Paint', serif; font-size: 20px;">

                            </div>
                        </div>
                    </div>
                    <a href="javascript:Back2();"><img src="images/left.png" width="50px" height="25" alt="Back" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:Next2();"><img src="images/right.png" width="50px" height="25" alt="Next" /></a>
                </div>
            </article>
            <article id="art4" style=" display: none">        
                <div class="line_gradient"></div>                              

                <div class="reflex"></div>
                <div class="line short "></div>        
                <div class="text large  ">
                    <img src="images/letter.png" width="50px" height="50" alt="letter" /><label style="font-size: 25px;font-family: 'Finger Paint', serif;">You send the invitation</label>
                    </br>
                    <input type="text" name="" value="" id="emailto"/>
                    </br>
                    <a href="javascript:Back3();"><img src="images/left.png" width="50px" height="25" alt="Back" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="javascript:Next3();"><img src="images/right.png" width="50px" height="25" alt="Next" /></a>
                </div>
            </article>
            <article id="art5" style=" display: none">        
                <div class="line_gradient"></div>                              

                <div class="reflex"></div>
                <div class="line short "></div>        
                <div class="text large  ">
                    <img src="images/success.jpg" width="50px" height="50" alt="letter" /><label style="font-size: 25px;font-family: 'Finger Paint', serif;">Your poll has been modified.</label>
                    </br>

                </div>
            </article>
            <footer>

                </br>
                2012 Yang Yu | CSE- Doodle
            </footer>
        </div>
    </body>
</html>
