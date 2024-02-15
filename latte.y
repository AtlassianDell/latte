%{
#include <stdio.h>

// Data types for values
typedef struct {
  char *str_val;
  int int_val;
  bool bool_val; 
} Value;

// Hold variable value
Value var; 
%}

%union{
   char *str_val;
   int int_val;
   bool bool_val;
}

%token <str_val> STRING
%token <int_val> INT
%token <bool_val> BOOL
%token OUTPUT VARNAME
%token PLUS MINUS TIMES DIVIDE MODULO 

%% 

commands:
    | commands command 
    ;

command:
    OUTPUT output_list  { printf("%s", $2); } 
    | VARNAME '=' value   { $$ = $3; }
    ;

output_list: 
    output_element
    | output_list output_element 
    ;

output_element:
    STRING 
    | INT 
    | BOOL
    | '#' VARNAME '#'  { printf("%s", var.str_val); } 
    | math_expression  { printf("%d", $1); } 
    | symbol           { printf("%s", $1); } 
    ;

math_expression:
    INT PLUS INT        { $$ = $1 + $3; }
    | INT MINUS INT       { $$ = $1 - $3; }
    | INT TIMES INT       { $$ = $1 * $3; }
    | INT DIVIDE INT      { $$ = $1 / $3; } 
    | INT MODULO INT      { $$ = $1 % $3; }
    | INT                 { $$ = $1; }  
    ;

symbol: 
    '+' | '-' | '*' | '/' | '%' 
    /* Include other desired symbols here */
    ;

%%

int main() {
  yyparse();
  return 0;
} 
