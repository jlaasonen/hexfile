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
hexfile [-i <start index>] <filename>
```

Start index can be given in format supported by the [VALLNG](https://www.freebasic.net/wiki/KeyPgVallng) function.

Page Up & Page Down show the previuos and the page respectively. Up and down arrows scroll one line at the time.
Esc will end the program.

![image](https://user-images.githubusercontent.com/404469/208312277-d7a22c13-2530-4658-8931-4adaa6404e34.png)

## Acknowledgements

Inspired by the **hexfile** program in *[P.K. McBride, 1989, Programming in GW-BASIC](https://archive.org/details/programmingingwb0000mcbr)* chapter 15.6.
