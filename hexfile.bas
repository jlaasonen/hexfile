Const bytesPerLine = 16
Const nonAsciiByte = "."
Const asciiLowerBound = 31
Const asciiUpperBound = 127
Const hexColumn = 11
Const asciiColumn = 64

Dim consoleDimensions As integer = Width()
Dim consoleHeight As integer = HiWord(consoleDimensions)

Dim fileName As string = Command(1)
Dim fileNumber As Long = FreeFile
Open fileName For Binary Access Read As #fileNumber


Function ByteToAscii(Byval byte_ as Ubyte) as String
    If byte_ > asciiLowerBound And byte_ < asciiUpperBound Then
        Return Chr(byte_)
    Else
        Return nonAsciiByte
    End If
End Function


Sub PrintLine(Byval fileIndex as Integer, Byval fileNumber as Integer)
    Dim asciiBytes As string = ""
    
    Print Hex(fileIndex,6);Tab(hexColumn);
    
    For byteIndex As integer = 1 To bytesPerLine
        Dim byte_ As Ubyte
        Get #fileNumber,fileIndex + byteIndex - 1,byte_
        
        asciiBytes += ByteToAscii(byte_)

        Print Hex(byte_, 2);" ";
        If byteIndex = bytesPerLine\2 Then Print " ";
    Next
    
    Print Tab(asciiColumn);asciiBytes
End Sub


Dim fileIndex As Integer = 1

Do
    PrintLine(fileIndex, fileNumber)  
    fileIndex += bytesPerLine
    If (fileIndex\bytesPerLine) mod (consoleHeight-1) = 0 Then Sleep
Loop Until Eof(fileNumber)

Close(fileNumber)
