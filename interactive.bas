Const bytesPerLine = 16
Const tabWidth = 3
Const fileIndexWidth = 8
Const firstIndex = 1

Const asciiLowerBound = 31
Const asciiUpperBound = 127
Const emptyByte = "  "
Const emptyAsciiByte = " "
Const nonAsciiByte = "."

Enum Keys Explicit
   Up = &H48FF
   PageUp = &H49FF
   Down = &H50FF
   PageDown = &H51FF
   Home = &H47FF
   End_ = &H4FFF
   Esc = 27
End Enum


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


Function MakeLine(Byval firstIndexDisplay as Longint, Byval fileIndex as Longint, bytes() as UByte) as String
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

      If byteIndex = (bytesPerLine\2)-1 Then 
         hexBytes += "  "
      Else
         hexBytes += " "
      End If
   Next

   Dim displayIndex as Const Longint = fileIndex - firstIndex + firstIndexDisplay
   Return Space(1) + Hex(displayIndex,fileIndexWidth) + Space(tabWidth) +_
      hexBytes + Space(tabWidth-1) + asciiBytes
End Function


Sub DumpInteractive(Byval fileNumber as Integer, Byval firstIndexDisplay as Longint)
   Dim consoleDimensions As Integer = Width()
   Dim linesPerPage as Integer = HiWord(consoleDimensions)
   Dim bytesPerPage As Integer = bytesPerline * linesPerPage

   Dim numberOfFullLines As Longint = (Lof(fileNumber)-1) \ bytesPerLine
   Dim lastLineIndex As Longint = numberOfFullLines * bytesPerLine + firstIndex
   Dim lastPageIndex As Longint = lastLineIndex - bytesPerPage + bytesPerLine
   If lastPageIndex < firstIndex Then lastPageIndex = firstIndex End If

   Cls

   Dim input_ As Long
   Dim fileIndex As Longint = firstIndex

   Do
      Locate 1,1,0
      For lineNumber as Integer = 1 To linesPerPage
         Dim lineIndex as Longint = fileIndex + (lineNumber-1)*bytesPerLine
         Redim bytes(bytesPerLine) as UByte
         GetLine(lineIndex, fileNumber, bytes())
         Dim lineText as String = MakeLine(firstIndexDisplay, lineIndex, bytes())
         If lineNumber = linesPerPage Then
            Print lineText;
         Else
            Print lineText
         End If
      Next

      input_ = Getkey
      Select Case as Const input_
         Case Keys.PageUp: fileIndex -= bytesPerPage
         Case Keys.Up: fileIndex -= bytesPerLine
         Case Keys.PageDown: fileIndex += bytesPerPage
         Case Keys.Down: fileIndex += bytesPerLine
         Case Keys.Home: fileIndex = firstIndex
         Case Keys.End_: fileIndex = lastPageIndex
      End Select

      If fileIndex < firstIndex Then fileIndex = firstIndex
      If fileIndex > lastPageIndex Then fileIndex = lastPageIndex
   Loop Until input_ = Keys.Esc
End Sub
