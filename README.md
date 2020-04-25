# Flex Bison Expression Calculator


All the codes are written in C-language and can be executed in Linux/UNIX environment.

|Index|
|---|
|[Goal](#Goal)|
|[Specifications](#Specifications)|
|[Compiling](#Compiling)|
|[Usage](#Usage)|
|[Algorithm](#Algorithm)|
|[Instructions](#Instructions)|

## Goal

1. Learn how to write and use [makefile.](http://www.delorie.com/djgpp/doc/ug/larger/makefiles.html)
2. Acquaint yourself with flex and bison

### Specifications:

You will extend calc.l and calc.y to parse programs whose syntax is defined below

Prog-->main() {Stmts}

Stmts --> ε | Stmt; Stmts

Stmt --> Id = E | Id *= E | Id += E | print E

E --> Integer | Id | E * E | E + E | (-Integer)

Integer --> digit+

* Prog is a program that contains one main function.
* Stmts is empty or a sequence of statements separated using ;
* Integer is either a positive integer or a negative integer enclosed in “(“ and “)”
* Id is an identifier, which is a sequence of one or more lower-case letters or digits. In addition, Id should start with a lower-case letter. For example, x, x1, xy are identifiers, but 1x and A are not.
* Expression E is an integer, an identifier, or an infix arithmetic expression with operators "*" and "+".These two operators are left-associative (e.g., 1 + 2 + 3 is equivalent to (1 + 2) + 3). "*" has higher precedence than “+”.
* Id = E assigns the value of an expression E to the variable Id, Id *= E assigns Id * E to Id, and Id += E assigns Id + E to Id. println E outputs the value of the expression E. Assume that Id is already assigned a value prior to the execution of Id *= E and Id += E.
* If there is any syntax error, you are expected to interpret the program until the statement where you find the error. Also, your error message must contain the line number where the error was found.
* Tokens may be separated by any number of white spaces, tabs, or newlines.

## Compiling
To compile the code open the directory in Linux/UNIX terminal and type ```make``` to compile the program. Once compiled, run the program by typing the following command in the prompt

```bash
./calc < input
```
Where input is the name of the input file. This should run the code! There are 12 test cases provided in the assignment problem statement. All the test cases should work file.



## Usage

* To clean the output files, open the directory in Linux terminal and type ```make clean```
* If you are using macOS, you will first need to install flex and bison. You can get them through homebrew using the following formula
```
brew install flex
brew install bison
```
Additionally,
```
export CMAKE_INCLUDE_PATH="/usr/local/opt/flex/include"
export CMAKE_LIBRARY_PATH="/usr/local/opt/flex/lib;/usr/local/opt/bison/lib"
export PATH="/usr/local/opt/flex/bin:/usr/local/opt/bison/bin:$PATH"
```

## Algorithm
* We have implemented an Integer Calculator for operations:'+' Addition, '*' Multiplication, '=' Assignment and Short Hand Operations: '+=' and '*='. 
* The grammar for which is defined in the [above](#Goal) section. All the variables are stored in a structure (symboltable) to maintain the symbol table. 
* The two arrays values[] and variables[] will maintain the data. 
* Another structure (operationtable) helps to evaluate the expressions. Based on the evaluation of expressions we update the values in the symbol table.

## Instructions
* While compilation of the code, there are several warnings which do not affect the code and all the test cases run.


## Terms and Policies

- This repository contains resources which are referenced from multiple online platforms. Users should use the resources for open source projects and self/ non-commercial purposes.
- If any conflict arises, the **user** shall be liable for the damage caused and not the Repository Owner.
- The Repository owner has published some propriety data and intellectual property of others for **ACADEMIC purpose only**.
- Which shall be referred by the user on his **own risk!** If found to be used for any non-Academic usage, **the user shall be liable for any legal proceedings caused in any jurisdiction.**

## Usage

Thank you for visiting my projects. Please use this repository wisely and strictly for Academic Purposes only. If any conflict arises report or contact to me directly via email at <connect@adityachaudhari.dev>

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
No Licenses required as of now. Users are requested to use the repo wisely.