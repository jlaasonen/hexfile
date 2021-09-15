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

Dim fileIndex As Integer = 1

Do
    Dim asciiBytes As string = ""
    Print Hex(fileIndex,6);Tab(hexColumn);

    For byteIndex As integer = 1 To bytesPerLine
        Dim byte_ As Ubyte
        Get #fileNumber,,byte_
        
        If byte_ > asciiLowerBound and byte_ < asciiUpperBound Then
            asciiBytes += Chr(byte_)
        Else
            asciiBytes += nonAsciiByte
        End If
        
        Print Hex(byte_, 2);" ";
        If byteIndex = bytesPerLine\2 Then Print " ";
        
        fileIndex += 1
    Next
    
    Print Tab(asciiColumn);asciiBytes
    If (fileIndex\bytesPerLine) mod (consoleHeight-1) = 0 Then Sleep
Loop Until Eof(fileNumber)

Close(fileNumber)
