Sub PrintUsage()
   Const firstColumn = 4
   Const secondColumn = 12
   
   Dim controls(0 to ..., 2) as String = {_
      {"Down", "Scroll down one line."},_
      {"Up", "Scroll up one line."},_
      {"PgDown", "Show next page."},_
      {"PgUp", "Show previos page."},_
      {"End", "Jump to the end of the file."},_
      {"Home", "Jump to the beginning of the file."},_
      {"Esc", "Quit."}_
   }

   Print "hexfile - a simple commandline hexdumper"
   Print "  (c) 2021-2022 Jussi Laasonen. Licensed under the MIT license."
   Print "  See https://github.com/jlaasonen/hexfile for full license."
   Print
   Print "Usage: hexfile [-i <first index>] <file>"
   Print
   Print "Displays an interactive hex dump the file."
   Print
   Print "Controls:"
   
   For row As Integer = LBound(controls) To UBound(controls)
      Print Tab(firstColumn);controls(row,0);Tab(secondColumn);controls(row,1)
   Next
   
   Print
   Print "Options:"
   Print "  -i <first index>"
   Print "    Starts the displayed file index from the given index. Defaults to 0."
   Print "    The value is expected in decimal format. For binary, octal or hexadecimal"
   Print "    Use prefix &B, &O or &H respectively."
End Sub
