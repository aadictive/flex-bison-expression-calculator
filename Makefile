PL1:
	flex -l calc.l
	bison -dv calc.y
	gcc -o calc calc.tab.c lex.yy.c -ll -w
	
clean:
	rm calc.output calc.tab.c calc.tab.h lex.yy.c calc