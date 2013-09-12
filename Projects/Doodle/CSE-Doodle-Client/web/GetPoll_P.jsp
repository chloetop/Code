<%-- 
    Document   : GetPoll_P
    Created on : 2012-10-11, 0:35:35
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%  String pid = request.getAttribute("pid").toString().trim();
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
           
        var newoid="";
        function Init(){
               
                   
            getfunc("<%=resturl%>Polls/<%=pid%>",null);
            if($("#log").val().trim() !=""){
                $("#com_uid").val($("#log").val().trim());
                $('#com_uid').attr("readonly","readonly");
                $("#uid").val($("#log").val().trim());
                $('#uid').attr("readonly","readonly");
            }
             
                                      
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
                $("#llogin").html($("#log").val().trim());
                $("#Userid").val($("#log").val().trim());
                   
                // document.getElementById("com_uid").value = "";
                Init();
                   
            });
        })
        function clear(){
            newoid = "";
            document.getElementById("uid").value="";
            var   getCK=document.getElementsByTagName('input');   
            for(var i=0;i<getCK.length;i++)   
            {   
                var whichObj=getCK[i];   
                if(whichObj.type=="checkbox")   
                    whichObj.checked=false;  
            } 
            document.getElementById("com_uid").value = "";
            document.getElementById("comment").value = "";
        }
        function getfunc(strurl,para){
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
                  //  alert($.toJSON(data));
                    var a = $.toJSON(data);
                      
                    $("#p1").html(data.pb.Poll_Title.trim());
                    //Poll initiated by
                    $("#p2").html("Poll initiated by "+data.pb.Poll_Initiator.trim() + " | <img src=\"../images/Clock.png\" alt=\"Latest Activity\"  width =\"15\"/> "+ data.pb.Poll_Lastmodify.trim());
                    //Poll_Description
                    $("#p3").html(data.pb.Poll_Description.trim());
                    Ptype = data.pb.Poll_Type.trim();
                    if(data.pb.Poll_Type.trim() == 1)
                        $("#art2").show();
                    else if(data.pb.Poll_Type.trim() == 2)
                        $("#art3").show();
                    if(data.pb.Poll_Status.trim() == 3)
                    {
                        $("#Save1").hide();
                        $("#Save2").hide();
                        $("#Save4").hide();
                           
                    }
                       
                    //display:block;z-index:1; font-size: 25px; font-weight:bolder; text-align: left 
                    var ht = "<table >";
                    var h1 = "<tr><td ></td><td ></td>"
                    var h2 = "<tr><td ></td><td></td>";
                    var h3 = "";
                    var h4 = "<tr><td ></td><td style=\"white-space:nowrap; \"><img src=\"../images/Person_small.png\"  width =\"15\"/><input type=\"text\" name=\"\" value=\"\" id=\"uid\" style=\"width:60px\"/></td>";
                    var h7 = "<select name=\"des\" id =\"des\">";
                    var h8 ="Result: ";
                    for(var i = 0; i < data.ops.length; i++){
                        h1 += "<td width=\"120px\">"+data.ops[i].oContent.trim()+"</td>";
                        h2 += "<td>"+data.ops[i].SubCon.trim()+"</td>";
                        h4 += "<td><input type=\"checkbox\" name=\"aa\" value=\""+data.ops[i].oID.trim()+"\" id=\""+data.ops[i].oID.trim()+"\" style=\"width:60px\" onClick=\"boxclick('"+data.ops[i].oID.trim()+"')\"/></td>";
                        h7 += "<option value=\""+data.ops[i].oID.trim()+"\">"+data.ops[i].oContent.trim()+" "+data.ops[i].SubCon.trim()+"</option>";
                        if(data.ops[i].oID.trim() == data.pb.Poll_Descsion.trim())
                            h8 +=data.ops[i].oContent.trim()+" "+data.ops[i].SubCon.trim();
                    }
                    for(var j = 0; j < data.vts.length; j++){
                        
                        if(data.vts[j].Vote_Creator !=document.getElementById("Userid").value.trim())
                            h3 += "<tr><td ></td><td>"+data.vts[j].Vote_Creator+"</td>";
                        else{
                            if(data.pb.Poll_Status.trim() != 3)
                                h3 += "<tr><td style=\"white-space:nowrap; \"><a href=\"javascript:Deletevote('"+data.vts[j].Vote_ID+"');\" ><img src=\"../images/trash.png\" height=\"20px\" width=\"20px\"/></a>&nbsp<a href=\"javascript:Editvote('"+data.vts[j].Vote_ID+"');\" ><img src=\"../images/comment_edit.png\" height=\"20px\" width=\"20px\"/></a></td><td>"+data.vts[j].Vote_Creator+"</td>";
                            else
                                h3 += "<tr><td ></td><td>"+data.vts[j].Vote_Creator+"</td>";
                        }
                        for(var i = 0; i < data.ops.length; i++){
                            if(data.vts[j].Vote_Option.trim() == data.ops[i].oID.trim()){
                                h3 +="<td><img src=\"../images/selected.png\"  width =\"20\"/></td>";
                            }
                            else{ h3 +="<td></td>";}
                        }
                        h3 +="</tr>";  
                    }
                           
                    h1 += "</tr>"
                    h2 += "</tr>"
                    h4 += "</tr>"
                    h7 += "</select> <a href=\"#\" id =\"Save3\"> <img src=\"../images/ok.png\"  style=\"width:20px\" onclick=\"SaveDes()\" ></a>";
                    if(data.pb.Poll_Status != 3 && data.pb.Poll_Initiator ==$("#Userid").val())
                        $("#p7").html(h7);
                    else if(data.pb.Poll_Status == 3)
                        $("#p7").html(h8);
                    if(data.pb.Poll_Type.trim() == 1)
                    {
                        ht = h1 + h2 + h3 + h4 + "</table>";
                        $("#p4").html(ht);
                    }
                    else if(data.pb.Poll_Type.trim() == 2)
                    { 
                        ht = h2 + h3 + h4 + "</table>";
                        $("#p5").html(ht);
                    }
                    var ht6 = "<table>";
                    for(var i = 0; i < data.comms.length; i++){
                        if(data.comms[i].Comment_Creator !=document.getElementById("Userid").value.trim())
                            ht6 += "<tr><td></td><td></td><td>"+data.comms[i].Comment_Creator+"</td><td>"+data.comms[i].Comment_DateTime+"</td><td align=left>Says: "+data.comms[i].Comment_Content+"</td></tr>";
                        else
                        {
                            if(data.pb.Poll_Status.trim() != 3)
                                ht6 += "<tr><td><a href=\"javascript:Deletecomm('"+data.comms[i].Comment_ID+"');\" ><img src=\"../images/trash.png\" height=\"20px\" width=\"20px\"/></a></td><td><a href=\"javascript:Editcomm('"+data.comms[i].Comment_ID+"');\" ><img src=\"../images/comment_edit.png\" height=\"20px\" width=\"20px\"/></a></td><td>"+data.comms[i].Comment_Creator+"</td><td>"+data.comms[i].Comment_DateTime+"</td><td align=left>Says: "+data.comms[i].Comment_Content+"</td></tr>";
                            else
                                ht6 += "<tr><td></td><td></td><td>"+data.comms[i].Comment_Creator+"</td><td>"+data.comms[i].Comment_DateTime+"</td><td align=left>Says: "+data.comms[i].Comment_Content+"</td></tr>";
                        }
                    }
                    ht6 += "</table>";
                    $("#p6").html(ht6);
                },  
                error : function() {  
                },
                complete: function(){
                }
            });
        }
        function SaveDes(){
            var descsion = document.getElementById("des").value.trim();
            var poll = new CreateObject("<%=pid%>", $("#Userid").val(),"","","","",descsion,"","","","","3");
            var Json = $.toJSON(poll);
          //  alert(Json);
             
            $.ajax( { 
                url : "<%=resturl%>Polls/Poll",  
                type : "PUT",  
                data : Json,   //or [1,2,3]--- array;
                dataType : "html",                   //html-->string .....json-->object
                contentType:"application/json",  
                async : false,                      //asynchronous  or
                beforeSend: function(){
                    // Handle the beforeSend event
                   // alert("start");
                },
                success : function(data) {  
                //    alert(data); 
                    Init();
                },  
                error : function() {  
                    // alert(document.getElementById("title").value);  
                },
                complete: function(){
                    // Handle the complete event
                   // alert("end");
                    //  alert(document.getElementById("title").value); 
                }
            });
                
            
        }
        function Deletevote(voteid){
          //  alert(voteid);
            var c_uid = document.getElementById("Userid").value.trim();
            var uid = document.getElementById("uid").value.trim();
            var vote = new voteobj("",uid,"<%=pid%>",c_uid,"",voteid,"");
            var Json = $.toJSON(vote);
         //   alert(Json);
            $.ajax( { 
                url : "<%=resturl%>Polls/Vote",  
                type : "DELETE",  
                data : Json,   //or [1,2,3]--- array;
                dataType : "html",                   //html-->string .....json-->object
                contentType:"application/json",  
                async : false,                      //asynchronous  or
                beforeSend: function(){
                    // Handle the beforeSend event
                  //  alert("start");
                },
                success : function(data) {  
                  
                    clear();
                    Init();
                },  
                error : function() {  
                    // alert(document.getElementById("title").value);  
                },
                complete: function(){
                    // Handle the complete event
                 //   alert("end");
                    //  alert(document.getElementById("title").value); 
                }
            });
        }
            
        function Editvote(voteid){
          //  alert(voteid +"---" +newoid);
            var c_uid = document.getElementById("Userid").value.trim();
            var uid = document.getElementById("uid").value.trim();
            var vote = new voteobj(newoid,uid,"<%=pid%>",c_uid,"",voteid,"");
            var Json = $.toJSON(vote);
          //  alert(Json);
            $.ajax( { 
                url : "<%=resturl%>Polls/Vote",  
                type : "PUT",  
                data : Json,   //or [1,2,3]--- array;
                dataType : "html",                   //html-->string .....json-->object
                contentType:"application/json",  
                async : false,                      //asynchronous  or
                beforeSend: function(){
                    // Handle the beforeSend event
                   // alert("start");
                },
                success : function(data) {  
                   
                    clear();
                    Init();
                },  
                error : function() {  
                    // alert(document.getElementById("title").value);  
                },
                complete: function(){
                    // Handle the complete event
                  //  alert("end");
                    //  alert(document.getElementById("title").value); 
                }
            });
        }
            
            
        function Deletecomm(commid){
           // alert(commid);
            var c_uid = document.getElementById("Userid").value.trim();
            var comm = new voteobj("","","<%=pid%>",c_uid,"","",commid);
            
            var Json = $.toJSON(comm);
           // alert(Json);
            $.ajax( { 
                url : "<%=resturl%>Polls/Comment",  
                type : "DELETE",  
                data : Json,   //or [1,2,3]--- array;
                dataType : "html",                   //html-->string .....json-->object
                contentType:"application/json",  
                async : false,                      //asynchronous  or
                beforeSend: function(){
                    // Handle the beforeSend event
                   // alert("start");
                },
                success : function(data) {  
                   
                    clear();
                    Init();
                },  
                error : function() {  
                    // alert(document.getElementById("title").value);  
                },
                complete: function(){
                    // Handle the complete event
                  //  alert("end");
                    //  alert(document.getElementById("title").value); 
                }
            });
        }
        function Editcomm(commid){
           // alert(commid);
            var c_uid = document.getElementById("Userid").value.trim();
            var cont = document.getElementById("comment").value.trim();
            var comm = new voteobj("","","<%=pid%>",c_uid,cont,"",commid);
            
            var Json = $.toJSON(comm);
           // alert(Json);
            $.ajax( { 
                url : "<%=resturl%>Polls/Comment",  
                type : "PUT",  
                data : Json,   //or [1,2,3]--- array;
                dataType : "html",                   //html-->string .....json-->object
                contentType:"application/json",  
                async : false,                      //asynchronous  or
                beforeSend: function(){
                    // Handle the beforeSend event
                 //   alert("start");
                },
                success : function(data) {  
                   
                    clear();
                    Init();
                },  
                error : function() {  
                    // alert(document.getElementById("title").value);  
                },
                complete: function(){
                    // Handle the complete event
                 //   alert("end");
                    //  alert(document.getElementById("title").value); 
                }
            });
        }
        function boxclick(oid){
                
            var   getCK=document.getElementsByTagName('input');   
            for(var i=0;i<getCK.length;i++)   
            {   
                var whichObj=getCK[i];   
                if(whichObj.value == oid)
                {
                            
                    if(whichObj.checked == false)
                        newoid = "";
                    else
                        newoid = oid;
                    continue;
                }
                if(whichObj.type=="checkbox")   
                    whichObj.checked=false;  
                        
            } 
                              
        }
        function voteobj(oid,uid,pid,c_uid,cont,vote_id,comm_id){
                
            this.oid = oid;
            this.uid = uid;
            this.pid = pid;
            this.c_uid = c_uid;
            this.cont = cont;
            this.time = GetCurrentDateTime();
            this.vote_id = vote_id;
            this.comm_id = comm_id
                
        }
        function SaveRate(){
                
            var Pobj;
               
            var uid = document.getElementById("uid").value.trim();
            var c_uid = document.getElementById("com_uid").value.trim();
            var cont = document.getElementById("comment").value.trim();
            Pobj= new voteobj(newoid,uid,"<%=pid%>",c_uid,cont,"","");
                 
            var Json = $.toJSON(Pobj);
          //  alert(Json);
            $.ajax( { 
                url : "<%=resturl%>Polls/<%=pid%>",  
                type : "PUT",  
                data : Json,   //or [1,2,3]--- array;
                dataType : "html",                   //html-->string .....json-->object
                contentType:"application/json",  
                async : false,                      //asynchronous  or
                beforeSend: function(){
                    // Handle the beforeSend event
                  //  alert("start");
                },
                success : function(data) {  
                    
                    clear();
                    Init();
                },  
                error : function() {  
                    // alert(document.getElementById("title").value);  
                },
                complete: function(){
                    // Handle the complete event
                   // alert("end");
                    //  alert(document.getElementById("title").value); 
                }
            });
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

                    <a href="../Polls/Holiday">
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
                    <div1 id="p1" style="display:block;z-index:1; font-size: 35px; font-weight:bolder; text-align: left  " >DateTime</div1>
                    <br>
                    <div1 id="p2" style="display:block;z-index:1; font-size: 15px;  text-align: left  " >title</div1>
                    <br />
                    <div1 id="p3" style="display:block;z-index:1; font-size: 15px;  text-align: left  " >title</div1>
                    <br />
                    <div1 id="p7" style="display:block;z-index:1; font-size: 15px;  text-align: left  " >Descision</div1>
                    <br />
                </div>   
            </article>
            <article id="art2" style="display:none">        
                <div class="line_gradient"></div>                              
                <div class="text large  ">        
                    <div1 id="p4" style=" " >time</div1>
                    <br>
                    <div  > 
                        <!--<input type="submit" value="" style=" background-image:  url('../images/ok.png')" onclick="SaveRate()" onmouseover="javasript: this.style.cursor='hand';"/>-->
                        <a href="#" id ="Save4"> <img src="../images/ok.png"  style="width:60px" onclick="SaveRate()" ></a>
                    </div>
                </div>   
            </article>
            <article id="art3"  style="display:none">        
                <div class="line_gradient"></div>                              

                <div class="text large  ">        
                    <div1 id="p12" style="display:block;z-index:1; font-size: 35px; font-weight:bolder; text-align: left  " >Text Type</div1>
                    <br>
                    <div1 id="p5" style=" " >test</div1>
                    <br>
                    <div  >                        
                        <a href="#" id ="Save1" > <img src="../images/ok.png"  style="width:60px" onclick="SaveRate()" ></a>
                    </div>
                </div>   
            </article>
            <article id="art4"  >        
                <div class="line_gradient"></div>                              

                <div class="text large  ">        
                    <div1 id="p12" style="display:block;z-index:1; font-size: 35px; font-weight:bolder; text-align: left  " >Comment</div1>
                    <br>
                    <div align="left"><img src="../images/Person_small.png"  width ="15"/><input type="text" name="" value="" id="com_uid" style="width:60px"/>
                        <a href="#" id ="Save2"> <img src="../images/ok.png"  style="width:20px" onclick="SaveRate()" ></a>
                    </div>
                    <br>
                    <div align="left"><textarea name="" rows="4" cols="20" id="comment"></textarea></div>
                    <br>
                    <div1 id="p6" style=" " ></div1>
                    <br>

                </div>   
            </article>
            <footer>
                <input type="text" name="" value="" id="Userid" style="display: none"/>
                </br>
                2012 Yang Yu | CSE- Doodle
            </footer>
        </div>
    </body>
</html>
