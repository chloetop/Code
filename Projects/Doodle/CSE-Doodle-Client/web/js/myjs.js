/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function Appendzero (obj) {
    if (obj < 10) return "0" + obj; else return obj;
}

function GetCurrentDateTime(){
    var now= new Date();
    var year=now.getFullYear();
    var month=now.getMonth()+1;
    var day=now.getDate();
    var hour=now.getHours();
    var minute=now.getMinutes();
    var second=now.getSeconds();
                   
    var CurrentDateTime = year+"-"+Appendzero(month)+"-"+Appendzero(day)+" "+Appendzero(hour)+":"+Appendzero(minute)+":"+Appendzero(second);
    return CurrentDateTime;
}
function CreateObject(pollid,initiator,title,description,type,lastmodify,descsion,oType,oContent,oSubCon,emailto,status)
{
    this.pollid = pollid;
    this.initiator = initiator;
    this.title = title;
    this.description = description;
    this.type = type;
    this.lastmodify = lastmodify;
    this.descsion = descsion;
    this.oType = oType;
    this.oContent = oContent;
    this.oSubCon = oSubCon;
    this.emailto = emailto;
    this.status = status;
}
function GetUser(){
    var uid ="";
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
                          
            uid = data.toString().trim();
            alert(initiator);
        },  
        error : function() {  
        },
        complete: function(){
        }
    });
    return uid;     
}
