%% /* Declarations */

%token TOK_EOF TOK_IDENTIFIER TOK_STRING TOK_INT TOK_BOOL
%token TOK_PRINT TOK_OUTPUT TOK_TABLE TOK_DECLARE TOK_CALL TOK_INPUT TOK_GETKEY TOK_RETURN

%token TOK_LPAREN TOK_RPAREN TOK_LBRACE TOK_RBRACE TOK_EQUALS TOK_COLON TOK_COMMA

%% /* Grammar Rules */

program : statementList 
        ;

statementList : statement statementList 
              | /* empty */
              ;

statement : outputStmt | assignmentStmt | tableStmt 
          | functionDecl | functionCall | returnStmt | callStmt 
          ;

outputStmt : TOK_OUTPUT argList 
           ;

argList : arg argList
        | arg
        ;

arg : TOK_IDENTIFIER | TOK_INT | TOK_BOOL | TOK_STRING 
    ;

assignmentStmt : TOK_IDENTIFIER TOK_EQUALS expression 
               ;

tableStmt : TOK_TABLE TOK_IDENTIFIER TOK_COLON '{' tableElements '}'
          ;

tableElements : tableItem (',' tableItem)*   /* One or more table entries */
              | /* empty */ 
              ;

tableItem : TOK_IDENTIFIER TOK_COLON expression /* Key-value style */
          | expression                        /* Array-like element */ 
          ;

returnStmt : TOK_RETURN expression ';'
           ;

functionDecl : TOK_DECLARE TOK_IDENTIFIER TOK_LPAREN paramList TOK_RPAREN '{' statementList '}'
             ;

paramList : TOK_IDENTIFIER (',' TOK_IDENTIFIER)* 
          | /* empty */
          ; 

functionCall : TOK_CALL TOK_IDENTIFIER TOK_LPAREN argList TOK_RPAREN 
             ;

callStmt : TOK_CALL TOK_IDENTIFIER ';'  /* Assume variable with function value */

expression : TOK_INT 
           | TOK_STRING
           | TOK_BOOL
           | TOK_IDENTIFIER /* Could be simple variable or function call */ 
           /* ... Add rules for operations, precedence if needed */ 
           ; 

%%

// Optionally, include error handling:
int yyerror(const char *msg) { 
    fprintf(stderr, "Parser error: %s\n", msg); 
    return 0; 
}
