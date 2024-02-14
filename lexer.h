#ifndef LEXER_H
#define LEXER_H

#include <stdio.h>

// Token Types
enum TokenType {
    // Basics
    TOK_EOF,
    TOK_IDENTIFIER,
    TOK_STRING, 
    TOK_INT,
    TOK_BOOL,

    // Keywords
    TOK_PRINT, 
    TOK_OUTPUT,
    TOK_TABLE,
    TOK_DECLARE,
    TOK_CALL,
    TOK_INPUT,
    TOK_GETKEY,
    TOK_RETURN, // For returning values from functions

    // Symbols
    TOK_LPAREN, // (
    TOK_RPAREN, // )
    TOK_LBRACE, // {
    TOK_RBRACE, // }
    TOK_EQUALS,
    TOK_COLON,
    TOK_COMMA 
};

// Function to get the next token
int getNextToken();

#endif 
