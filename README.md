# hexfile

Simple command-line tool which prints a hex dump of a file.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/jlaasonen/hexfile)

## Requirements

[FreeBASIC-1.09.0](https://freebasic.net/)

## Compiling

```
fbc -e -w all -w pedantic -w error hexfile.bas 
```

## Usage

```
hexfile <filename>
```

Page Up & Page Down show the previuos and the page respectively. Up and down arrows scroll one line at the time.
Esc will end the program.

![image](https://user-images.githubusercontent.com/404469/191337881-d9f60e39-1077-4deb-bc50-e8f87275d636.png)

## Acknowledgements

Inspired by the **hexfile** program in *[P.K. McBride, 1989, Programming in GW-BASIC](https://archive.org/details/programmingingwb0000mcbr)* chapter 15.6.
