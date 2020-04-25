%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *temp1[100];
int temp1cnt=0; lcnt; i=0; k=0; p=0; sign=0; ex=0; flag=0; match=0;
float temp2;
%}

%token TOK_SEMICOLON TOK_ADD TOK_MUL TOK_NUM TOK_PRINT TOK_MAIN TOK_ID TOK_ASSIGN
%token TOK_OpenBracket TOK_CloseBracket TOK_OpenCurly TOK_CloseCurly TOK_NEGINT

%union{
	int int_val;
	struct symboltable s;
	struct operationtable o;
}

%code requires {
	struct symboltable
	{
		char temp[32];
		int vcnt;
		int tlcnt;
		int value[50];
		char var[50][32];
	};

	struct operationtable
	{
		int expression[22];
		int values[22];
		char variable[22][32]; 
	};
}

%code {
	struct symboltable level[50];
	int find(char *x)
	{
		match = 0;
		while(lcnt>0)	
		{
			for(i=0; i<level[lcnt].vcnt; i++)
			{
				if(strcmp(level[lcnt].var[i], x) == 0)
				{
					match = 1;
					return(i);
				}
			}
			lcnt--;
		}
	}
}

%type <int_val> TOK_NUM
%type <int_val> E
%type <id> TOK_ID
%type <id> Id 

%left TOK_ASSIGN
%left TOK_MUL TOK_ADD


%%
prog:
	TOK_MAIN TOK_OpenCurly stmts TOK_CloseCurly	
;


stmts:
	| stmt TOK_SEMICOLON stmts
;


stmt:
	Id TOK_ASSIGN E		{
							lcnt = yylval.s.tlcnt;
							i = find(temp1[temp1cnt-(flag+1)]);
							level[lcnt].value[i] = temp2;
							flag=0;
						}

	| TOK_PRINT TOK_ID	{
							lcnt = yylval.s.tlcnt;
							i = find(temp1[temp1cnt-1]);
							fprintf(stdout, "%d\n", level[lcnt].value[i]);
							i++;
						}

	| TOK_PRINT E		{
							fprintf(stdout, "%d\n",$<int_val>2);
						}

	| Id TOK_ADD TOK_ASSIGN E	{
									if(yylval.o.expression[k-1] == 3 || yylval.o.expression[k-1] == 5)
									{
										$<int_val>1 = yylval.o.values[k-1];
									}
									else if(yylval.o.expression[k-1] == 4)
									{
										lcnt = yylval.s.tlcnt;
										i = find(yylval.o.variable[k-1]);	
									}
									$<int_val>1 = level[lcnt].value[i];
									$<int_val>$ = $<int_val>1 + $<int_val>4; 
									level[lcnt].value[i] = $<int_val>$;
								}

	| Id TOK_MUL TOK_ASSIGN E	{
									if(yylval.o.expression[k-1] == 3 || yylval.o.expression[k-1] == 5)
									{
										$<int_val>1 = yylval.o.values[k-1];
									}
									else if(yylval.o.expression[k-1] == 4)
									{
										lcnt = yylval.s.tlcnt;
										i = find(yylval.o.variable[k-1]);	
									}
									$<int_val>1 = level[lcnt].value[i];
									$<int_val>$ = $<int_val>1 * $<int_val>4; 
									level[lcnt].value[i] = $<int_val>$;
								}
;


E: 	 
	intd				
	| Id	{
				flag++;	
			}
	| E TOK_ADD E	{
						k = 1; ex=1;
						while(k < 22)
						{
							if(yylval.o.expression[k] == 1)
							{
								if(yylval.o.expression[k-1] == 3 || yylval.o.expression[k-1] == 5)
								{
									$<int_val>1 = yylval.o.values[k-1];
								}
								else if(yylval.o.expression[k-1] == 4)
								{
									lcnt = yylval.s.tlcnt;
									i = find(yylval.o.variable[k-1]);
									$<int_val>1 = level[lcnt].value[i]; 	
								}		
						
								if(yylval.o.expression[k+1] == 3 || yylval.o.expression[k+1] == 5)
								{
                                	$<int_val>3 = yylval.o.values[k+1];
                                }
                                else if(yylval.o.expression[k+1] == 4)
								{
									lcnt = yylval.s.tlcnt;	
									i = find(yylval.o.variable[k+1]);	
                                    $<int_val>3 = level[lcnt].value[i]; 
								}                
								break;
							}
							k++;
						}
						if(sign==1)
						{
							$<int_val>$ = -$<int_val>1 + $<int_val>3;
						} else 
						{
							$<int_val>$ = $<int_val>1 + $<int_val>3; 
						} 
						temp2 = $<int_val>$;

						yylval.o.expression[k] = 0;
						yylval.o.expression[k-1] = 5;
						yylval.o.expression[k+1] = 5;

						for(p=k-1; p>=1; p--) 
						{
							if(yylval.o.expression[p] == 5 && (yylval.o.expression[p-1] != 1 || yylval.o.expression[p-1] != 2))
							{
								yylval.o.values[p] = temp2;
							}
						}

						for(p=k+1; p<22; p++)
                        {
                            if(yylval.o.expression[p] == 5 && (yylval.o.expression[p+1] != 1 || yylval.o.expression[p+1] != 2))
                            { 
                            	yylval.o.values[p] = temp2;        
							}
                        } 
					}

	| E TOK_MUL E	{
						k = 1;
                        while(k < 22)
                        {
                            if(yylval.o.expression[k] == 2)
                            {
								if(yylval.o.expression[k-1] == 3 || yylval.o.expression[k-1] == 5)
                                    {
                                        $<int_val>1 = yylval.o.values[k-1];
                                    }
                                    else if(yylval.o.expression[k-1] == 4)
                                    {
                                    	lcnt = yylval.s.tlcnt;
                                       	i = find(yylval.o.variable[k-1]);
                                        $<int_val>1 = level[lcnt].value[i];
                                    }
                                    if(yylval.o.expression[k+1] == 3 || yylval.o.expression[k+1] == 5)
                                    {       
                                        $<int_val>3 = yylval.o.values[k+1];
                                    }  
                                    else if(yylval.o.expression[k+1] == 4)
                                    {
                                    	lcnt = yylval.s.tlcnt;
                                        i = find(yylval.o.variable[k+1]);
                                        $<int_val>3 = level[lcnt].value[i];
                                    }
									break;
                        	}
                            k++;
                        }

                        $<int_val>$ = $<int_val>1 * $<int_val>3;
                        temp2 = $<int_val>$;

                        yylval.o.expression[k] = 0;
                        yylval.o.expression[k-1] = 5;
                        yylval.o.expression[k+1] = 5;

                        for(p=k-1; p>=1; p--)
                        {
                            if(yylval.o.expression[p] == 5 && (yylval.o.expression[p-1] != 1 || yylval.o.expression[p-1] != 2))
                            {
                            yylval.o.values[p] = temp2;
                        	}
                        }

                        for(p=k+1; p<22; p++)
                        {
                            if(yylval.o.expression[p] == 5 && (yylval.o.expression[p+1] != 1 || yylval.o.expression[p+1] != 2))
                            {
                             	yylval.o.values[p] = temp2;
                            }
                        }
				}

	| TOK_NEGINT intd TOK_CloseBracket	{
											$<int_val>$ = -1 * temp2; 
											temp2 = -1 * temp2;
											sign=1;
										}
;


intd:
	TOK_NUM	{
				$<int_val>$ = $<int_val>1; 
				temp2 = $<int_val>$;
			}
;


Id:
	TOK_ID	{
				temp1[temp1cnt] = $<s>1.temp;
				temp1cnt++;
			}
;


%%


int yyerror(char *str)
{
	extern int yylineno;
	printf("Parsing error: line %d - %s\n", yylineno, str);
	return 1; 
}


int main()
{
	struct symboltable level[50];
   	yyparse();
   	return 0;
}
