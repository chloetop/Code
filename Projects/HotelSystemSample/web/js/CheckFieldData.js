//检查用户的输入，日期、字符串、数值
// Browser Detection
isMac = (navigator.appVersion.indexOf("Mac")!=-1) ? true : false;
NS4 = (document.layers) ? true : false;
IEmac = ((document.all)&&(isMac)) ? true : false;
IE4plus = (document.all) ? true : false;
IE4 = ((document.all)&&(navigator.appVersion.indexOf("MSIE 4.")!=-1)) ? true : false;
IE5 = ((document.all)&&(navigator.appVersion.indexOf("MSIE 5.")!=-1)) ? true : false;
ver4 = (NS4 || IE4plus) ? true : false;
NS6 = (!document.layers) && (navigator.userAgent.indexOf('Netscape')!=-1)?true:false;

function IsNumNull(s)
{
    if (s==""){
        return false;
    }else{
        return  true;
    }
}  
function IsEmail(strEmail) {
    if (strEmail.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
        return true;
    else
        return false;
}

function IsString(Str)
{
    var checkOK = "abcdefghijklmnopqrstuvwxyzABCDEFGHIGKLMNOPQRSTUVWXYZ0123456789_";
    var checkStr = Str;
    var allValid = true;
    for (i = 0;  i < checkStr.length;  i++){
        ch = checkStr.charAt(i);
        for (j = 0;  j < checkOK.length;  j++)
            if (ch == checkOK.charAt(j))
                break;
        if (j == checkOK.length){
            allValid = false;
            break;
        }
    }
    return allValid;
}

//检查合法日期
function IsDate(dateStr) 
{
    var str = dateStr.trim();  
    var datePat = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$/;
    
    var matchArray = str.match(datePat); // is the format ok?
    if (matchArray == null) 
    {
        return false;
    }
    var d = new Date(matchArray[1], matchArray[3]-1,matchArray[5]);
    return (d.getFullYear()==matchArray[1]&&(d.getMonth()+1)==matchArray[3]&&d.getDate()==matchArray[5]);
}   
//检查合法日期并时间
function IsDateTime(dateStr) 
{
    var datePat,d,matchArray;
    var str =  dateStr.trim();  
    //字符串大于11认为是日期＋时间
    if(str.length > 11)
    {
        datePat = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/;
        matchArray = str.match(datePat); // is the format ok?
        if (matchArray == null) 
        {
            return false;
        }
        d = new Date(matchArray[1], matchArray[3]-1,matchArray[5],matchArray[6],matchArray[7],matchArray[8]);
        return (d.getFullYear()==matchArray[1]&&(d.getMonth()+1)==matchArray[3]&&d.getDate()==matchArray[5]&&d.getHours()==matchArray[6]&&d.getMinutes()==matchArray[7]&&d.getSeconds()==matchArray[8]);
    }
    //否则认为只是日期
    else
    {
        datePat = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$/;
        matchArray = str.match(datePat); // is the format ok?
        if (matchArray == null) 
        {
            return false;
        }
        d = new Date(matchArray[1], matchArray[3]-1,matchArray[5]);
        return (d.getFullYear()==matchArray[1]&&(d.getMonth()+1)==matchArray[3]&&d.getDate()==matchArray[5]);
    }
}
//比较日期大小
function CompareDate(dateStr1,dateStr2)
{
    var str1 = dateStr1.trim();
    if(str1.length <11)str1 += " 00:00:00";
    var str2 = dateStr2.trim();
    if(str2.length <11)str2 += " 00:00:00";
    
    var day1,day2,month1,month2,year1,year2,matchArray1,matchArray2,datePat;
    var hour1,hour2,minute1,minute2,second1,second2;
    var date1,date2;

    datePat = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/;
    matchArray1 = str1.match(datePat); // is the format ok?
    matchArray2 = str2.match(datePat);
    if (matchArray1 == null) 
    {
        return false;
    }
    // is the format ok?
    if (matchArray2 == null) 
    {
        return false;
    }
    year1 = matchArray1[1];
    month1 = matchArray1[3]; 
    day1 = matchArray1[5];
    
    hour1 = matchArray1[6];
    minute1 = matchArray1[7];
    second1 = matchArray1[8];

    year2 = matchArray2[1];
    month2 = matchArray2[3]; 
    day2 = matchArray2[5];
    
    hour2 = matchArray2[6];
    minute2 = matchArray2[7];
    second2 = matchArray2[8];

    date1 = new Date(year1,month1-1,day1,hour1-1,minute1-1,second1-1);
    date2 = new Date(year2,month2-1,day2,hour2-1,minute2-1,second2-1);

    if(date1 > date2)
    {
            
        return 1;
    }
    if(date1 == date2)
    {
           
        return 0;
    }
    if(date1 < date2)
    {
        
        return -1;
    }
  
}
//检查是否是数字

function IsNum(s)
{
    var Number = "0123456789.";
    var tag = 0;
    for (i = 0; i < s.length;i++)
    {   
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if(c == '.')tag +=1;
        if(tag > 1)return false;
        if (Number.indexOf(c) == -1) return false;
    }
    return true;
}

//检查是否是电话号码

function IsTelNum(s)
{
    var Number = "0123456789-";
    var tag = 0;
    for (i = 0; i < s.length;i++)
    {   
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if(c == '-')tag +=1;
        if(tag > 1)return false;
        if (Number.indexOf(c) == -1) return false;
    }
    return true;
}

//检查最大值
function IsNumMax(s,y)
{
    if (s>y)  {
        return false;
    }else{
        return  true;
    }
}
//检查最小值
function IsNumMin(s,y)
{
    if(s<y) {
        return false;
    }else{
        return  true;
    }
}  
//检查是否为空

//检查字符串长度
function IsMaxLen(str,ilen)
{
    if(str.length > ilen){
        return false;
    }else{
        return  true;
    }
}
function IsMinLen(str,ilen)
{
    if(str.length < ilen){
        return false;
    }else{
        return  true;
    }
}

String.prototype.trim= function()  
{  
    // 用正则表达式将前后空格  
    // 用空字符串替代。  
    return this.replace(/(^\s*)|(\s*$)/g, "");  
}
