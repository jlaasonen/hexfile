# hexfile

[![Test](https://github.com/jlaasonen/hexfile/actions/workflows/test.yml/badge.svg)](https://github.com/jlaasonen/hexfile/actions/workflows/test.yml)

Simple command-line tool which prints a hex dump of a file.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/jlaasonen/hexfile)

## Requirements

- [FreeBASIC-1.10.0](https://freebasic.net/)
- [fbtesting](https://github.com/jlaasonen/fbtesting) for testing. Copy fbtesting files under `lib/fbtesting`.
- [task](https://taskfile.dev/) (optional) building and running tests.

## Compiling

Compile using _task_

```
task build
```

, or with plain _fbc_

```
fbc -e -w all -w pedantic -w error hexfile.bas 
```

## Testing

Compile and run tests with _task_

```
task test
```

, or with plain _fbc_

```
fbc -e -w all -w pedantic -w error test.bas
./test
```

## Usage

```
hexfile [-i <start index>] <filename>
```

Start index can be given in format supported by the [VALLNG](https://www.freebasic.net/wiki/KeyPgVallng) function.

Page Up & Page Down show the previuos and the page respectively. Up and down arrows scroll one line at the time.
Esc will end the program.

![image](https://github.com/jlaasonen/hexfile/assets/404469/0ddbc8a7-246b-4782-8b7b-3b73bf0421c7)

## Acknowledgements

Inspired by the **hexfile** program in *[P.K. McBride, 1989, Programming in GW-BASIC](https://archive.org/details/programmingingwb0000mcbr)* chapter 15.6.




