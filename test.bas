#include "lib/fbtesting/fbtesting.bas"
#include "interactive.bas"

using fbtesting

dim tester as Testing = Testing("hexfile")

sub TestGetLine(byref t as Testing)
   t.Skip()
   Const fileName = "test.txt"
   Dim fileNumber As Long = FreeFile
  
   if Open(fileName For Binary Access Read As #fileNumber) = 0 Then
      ReDim bytes(16) as ubyte
      GetLine(33, fileNumber, bytes())
      If ubound(bytes) <> -1 or lbound(bytes) <> 0 then t.Error("Not empty bytes.")
      Close(fileNumber)
   Else
      t.Error("Failed to open file.")
   End If
end sub

sub TestFull(byref t as Testing)
   dim bytes(...) as UByte = {00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00}
   dim result as string = MakeLine(0, 1, bytes())
   dim expected as string = " 00000000   00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ................"
   if result <> expected then t.Error("Expected  " +  expected + !"\n, but got " + result)
end sub

sub TestPartial(byref t as Testing)
   dim bytes(...) as UByte = {00, 00}
   dim result as string = MakeLine(0, 1, bytes())
   dim expected as string = " 00000000   00 00                                              ..              "
   if result <> expected then t.Error("Expected  " +  expected + !"\n, but got " + result)
end sub

sub TestEmpty(byref t as Testing)
   t.Skip()
   dim bytes(any) as UByte
   dim result as string = MakeLine(0, 1, bytes())
   dim expected as string = "                                                                               "
   if result <> expected then t.Error("Expected  " +  expected + !"\n, but got " + result)
end sub

tester.Test(@TestGetLine, "GetLine")
tester.Test(@TestFull, "full line")
tester.Test(@TestPartial, "partial line")
tester.Test(@TestEmpty, "empty line")

tester.Run()

if tester.Failed() then end 1
