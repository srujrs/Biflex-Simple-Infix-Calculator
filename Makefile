ex1: lex.yy.c ex1.tab.c
	gcc -o ex1 lex.yy.c ex1.tab.c -lm -lreadline
lex.yy.c: ex1.l
	flex ex1.l; 
ex1.tab.c: ex1.y
	bison -d ex1.y;  
clean:
	rm -f ex1 ex1.tab.* lex.yy.* 