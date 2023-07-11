#include "usage.bas"
#include "interactive.bas"

Const fileIndexArgument = "-i"

Dim fileName As String = ""
Dim firstIndexDisplay as Longint = 0

If __FB_ARGC__ = 2 Then
   fileName = Command(1)
Elseif __FB_ARGC__ = 4  And Command(1) = fileIndexArgument Then
   firstIndexDisplay = Vallng(Command(2))
   fileName = Command(3)
End If

Dim fileNumber As Long = FreeFile

If fileName = "" Then
   PrintUsage()
Elseif Open(fileName For Binary Access Read As #fileNumber) = 0 Then
   DumpInteractive(fileNumber, firstIndexDisplay)
   Close(fileNumber)
Else
   Print "Failed to open file '" + fileName + "'."
End If
