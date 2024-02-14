#include "lexer.h"
#include <ctype.h>
#include <string.h>

// ... (Keyword array as provided previously)

int currentChar = ' ';

// Helper to advance in input
void nextChar() {
    currentChar = getchar();
}

// Handles identifiers and keywords
int getIdentifierToken() {
    char identifierStr[100]; // Limit identifier length
    int index = 0;

    while (isalnum(currentChar) || currentChar == '_') {
        identifierStr[index++] = currentChar;
        nextChar();
    }
    identifierStr[index] = '\0';

    // Keyword check
    for (int i = 0; i < NumKeywords; i++) {
        if (strcmp(identifierStr, Keywords[i]) == 0) {
            return i + 1; // Special token IDs for keywords
        }
    }

    return TOK_IDENTIFIER;
}

// Handles integer numbers (very basic for now)
int getNumberToken() {
    int num = 0;
    while (isdigit(currentChar)) {
        num = num * 10 + (currentChar - '0'); 
        nextChar();
    }
    return TOK_INT;
}

// Handles string literals 
int getStringToken() {
    char strBuffer[100]; 
    int index = 0;

    nextChar(); // Skip the opening quote
    while (currentChar != '"' && currentChar != EOF) {
        strBuffer[index++] = currentChar;
        nextChar();
    } 

    strBuffer[index] = '\0';
    nextChar(); // Skip closing quote

    return TOK_STRING;
}

// Gets the next token from input
int getNextToken() {
    while (isspace(currentChar)) {
        nextChar();
    }

    if (isalpha(currentChar)) { 
        return getIdentifierToken();
    } else if (isdigit(currentChar)) { 
        return getNumberToken();
    } else if (currentChar == '"') {
        return getStringToken(); 
    } 

    switch (currentChar) {
        case '(': nextChar(); return TOK_LPAREN;
        case ')': nextChar(); return TOK_RPAREN;
        case '{': nextChar(); return TOK_LBRACE;
        case '}': nextChar(); return TOK_RBRACE;
        case '=': nextChar(); return TOK_EQUALS;
        case ':': nextChar(); return TOK_COLON; 
        case ',': nextChar(); return TOK_COMMA;
        case EOF: return TOK_EOF;
        default:  nextChar(); return -1;  // Indicate error (temporary)
    }
}
