Const bytesPerLine = 16
Const nonAsciiByte = "."
Const asciiLowerBound = 31
Const asciiUpperBound = 127
Const tabWidth = 3
Const fileIndexWidth = 8

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
Open fileName For Binary Access Read As #fileNumber

Dim numberOfFullLines As Longint = (Lof(fileNumber)-1) \ bytesPerLine
Dim lastLineIndex As Longint = numberOfFullLines * bytesPerLine + 1
Dim lastPageIndex As Longint = lastLineIndex - bytesPerPage + bytesPerLine


Function ByteToAscii(Byval byte_ as Ubyte) as String
    If byte_ > asciiLowerBound And byte_ < asciiUpperBound Then
        Return Chr(byte_)
    Else
        Return nonAsciiByte
    End If
End Function


Sub PrintLine(Byval fileIndex as Longint, Byval fileNumber as Integer)
    Dim hexBytes As String = ""
    Dim asciiBytes As String = ""
    
    For byteIndex As integer = 1 To bytesPerLine
        Dim byte_ As Ubyte
        Get #fileNumber,fileIndex + byteIndex - 1,byte_
        
        asciiBytes += ByteToAscii(byte_)

        hexBytes += Hex(byte_, 2) + " "
        If byteIndex = bytesPerLine\2 Then hexBytes += " "
    Next
    
    Print Hex(fileIndex,fileIndexWidth);Space(tabWidth);hexBytes;_
          Space(tabWidth-1);asciiBytes
End Sub


Cls

Dim input_ As Long
Dim fileIndex As Longint = 1

Do
    Locate 1,1,0
    For line_ as Integer = 0 To linesPerPage - 1
        PrintLine(fileIndex + line_*bytesPerLine, fileNumber)  
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
