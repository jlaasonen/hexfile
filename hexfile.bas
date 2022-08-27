Const bytesPerLine = 16
Const tabWidth = 3
Const fileIndexWidth = 8

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


Dim consoleDimensions As Integer = Width()
Dim consoleHeight As Integer = HiWord(consoleDimensions)
Dim linesPerPage as Integer = consoleHeight
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


Function MakeLine(Byval fileIndex as Longint, bytes() as UByte) as String
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

   Return Hex(fileIndex,fileIndexWidth) + Space(tabWidth) + hexBytes +_
		Space(tabWidth-1) + asciiBytes
End Function


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
      For lineNumber as Integer = 1 To linesPerPage
         Dim lineIndex as Longint = fileIndex + (lineNumber-1)*bytesPerLine
         Redim bytes(bytesPerLine) as UByte
         GetLine(lineIndex, fileNumber, bytes())
         Dim lineText as String = MakeLine(lineIndex, bytes())
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
         Case Keys.Home: fileIndex = 0
         Case Keys.End_: fileIndex = lastPageIndex
      End Select

      If fileIndex < 1 Then fileIndex = 1
      If fileIndex > lastPageIndex Then fileIndex = lastPageIndex
   Loop Until input_ = Keys.Esc

   Close(fileNumber)
Else
   Print "Failed to open file '" + fileName + "'."
End If
