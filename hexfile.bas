Const bytesPerLine = 16
Const tabWidth = 3
Const fileIndexWidth = 8

Const asciiLowerBound = 31
Const asciiUpperBound = 127
Const emptyByte = "  "
Const emptyAsciiByte = " "
Const nonAsciiByte = "."

Const Up = &H48FF
Const PageUp = &H49FF
Const Down = &H50FF
Const PageDown = &H51FF
Const Esc = 27
            
Dim consoleDimensions As Integer = Width()
Dim consoleHeight As Integer = HiWord(consoleDimensions)
Dim linesPerPage as Integer = consoleHeight - 1
Dim bytesPerPage As Integer = bytesPerline * linesPerPage

Dim fileName As String = Command(1)
Dim fileNumber As Long = FreeFile


Sub GetLine(Byval fileIndex as Longint, Byval fileNumber as Integer, bytes() as UByte)
   Dim bytesread As UInteger

   If Get(#fileNumber,fileIndex,bytes(), ,bytesread) = 0 Then
      ReDim Preserve bytes(bytesread)
   Else
      Erase bytes
   End If
End Sub


Function ByteToAscii(Byval byte_ as Ubyte) as String
    If byte_ > asciiLowerBound And byte_ < asciiUpperBound Then
        Return Chr(byte_)
    Else
        Return nonAsciiByte
    End If
End Function


Sub PrintLine(Byval fileIndex as Longint, bytes() as UByte)
    Dim hexBytes As String = ""
    Dim asciiBytes As String = ""
    
    For byteIndex As Integer = LBound(bytes) To LBound(bytes) + bytesPerLine - 1
         If byteIndex <= UBound(bytes) Then
           Dim byte_ As UByte = bytes(byteIndex)
           asciiBytes += ByteToAscii(byte_)
           hexBytes += Hex(byte_, 2)
         Else
           asciiBytes += emptyAsciiByte
           hexBytes += emptyByte
         End If

         If byteIndex = bytesPerLine\2 Then 
            hexBytes += "  "
         Else
            hexBytes += " "
         End If
    Next
    
    Print Hex(fileIndex,fileIndexWidth) + Space(tabWidth) + hexBytes +_
          Space(tabWidth-1) + asciiBytes
End Sub


If Open(fileName For Binary Access Read As #fileNumber) = 0 Then
   Dim numberOfFullLines As Longint = (Lof(fileNumber)-1) \ bytesPerLine
   Dim lastLineIndex As Longint = numberOfFullLines * bytesPerLine + 1
   Dim lastPageIndex As Longint = lastLineIndex - bytesPerPage + bytesPerLine
   If lastPageIndex < 1 Then lastPageIndex = 1 End If

   Cls

   Dim input_ As Long
   Dim fileIndex As Longint = 1

   Do
       Locate 1,1,0
       For line_ as Integer = 0 To linesPerPage - 1
          Dim lineIndex as Longint = fileIndex + line_*bytesPerLine
          ReDim bytes(bytesPerLine) as UByte
          GetLine(lineIndex, fileNumber, bytes())
          PrintLine(lineIndex, bytes())  
       Next
    
       input_ = Getkey
       Select Case input_
           case PageUp: fileIndex -= bytesPerPage
           case Up: fileIndex -= bytesPerLine
           Case PageDown: fileIndex += bytesPerPage
           Case Down: fileIndex += bytesPerLine
       End Select
       
       If fileIndex < 1 Then fileIndex = 1
       If fileIndex > lastPageIndex Then fileIndex = lastPageIndex
   Loop Until input_ = Esc

   Close(fileNumber)
Else
   Print "Failed to open file '" + fileName + "'."
End If
