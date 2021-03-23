/*
 * Nibble lexical grammar in ANTLR4 notation.
 */

lexer grammar EJSONLexer;

import UnicodeClasses;

DelimitedComment: '/*' (DelimitedComment | .)*? '*/' -> channel(HIDDEN) ;

LineComment: '//' ~[\r\n]* -> channel(HIDDEN) ;

WS: [\u0020\u0009\u000C] -> skip ;

NL: ('\n' | '\r' '\n'?) -> skip ;

LCURL: '{' ;
RCURL: '}' ;
LSQUARE: '[' ;
RSQUARE: ']' ;
LPAREN: '(' ;
RPAREN: ')' ;
DOT: '.' ;
COLON: ':' ;
COMMA: ',' ;
QUEST: '?' ;

ADD: '+' ;
SUB: '-' ;
MUL: '*' ;
DIV: '/' ;
MOD: '%' ;

AND: '&&' ;
OR: '||' ;
NOT: '!' ;
LT: '<' ;
GT: '>' ;
LE: '<=' ;
GE: '>=' ;

fragment FALSE: 'false' ;
fragment TRUE: 'true' ;
fragment NULL: 'null' ;

// SECTION: digits

fragment UNDERLINE: '_' ;

fragment BinDigit: [01];

fragment BinDigitOrSeparator: BinDigit | UNDERLINE ;

fragment DecDigit: [0-9] ;

fragment DecDigitOrSeparator: DecDigit | UNDERLINE ;

fragment HexDigit: [0-9a-fA-F];

fragment HexDigitOrSeparator: HexDigit | UNDERLINE ;

fragment HexDigits: HexDigit HexDigitOrSeparator*;

fragment OctDigit: [0-7] ;

fragment OctDigitOrSeparator: OctDigit | UNDERLINE ;

fragment Exponent: [eE] [+-]? DecDigit+ ;

// SECTION: literals

BinLiteral: '0' [bB] BinDigit (BinDigitOrSeparator* BinDigit)?;

HexLiteral: '0' [xX] HexDigit (HexDigitOrSeparator* HexDigit)? ;

IntegerLiteral: DecDigit (DecDigitOrSeparator* DecDigit)? ;

OctLiteral: '0' [cC] OctDigit (OctDigitOrSeparator* OctDigit)? ;

FloatLiteral: (DecDigit (DecDigitOrSeparator* DecDigit)?)? DOT (DecDigit (DecDigitOrSeparator* DecDigit)?)? Exponent? ;

BooleanLiteral
	: TRUE
	| FALSE
	;

NullLiteral
	: NULL
	;

// SECTION: lexicalIdentifiers

fragment Letter
	: UNICODE_CLASS_LL
  | UNICODE_CLASS_LM
  | UNICODE_CLASS_LO
  | UNICODE_CLASS_LT
  | UNICODE_CLASS_LU
  | UNICODE_CLASS_NL
	;

Identifier
	: Letter (Letter | UNDERLINE | UNICODE_CLASS_ND)*
	;

fragment UniCharacterLiteral
    : '\\u' HexDigit HexDigit HexDigit HexDigit
    | '\\u' LCURL HexDigit+ RCURL
    ;

fragment EscapedIdentifier
    : '\\' ('t' | 'b' | 'r' | 'n' | '\'' | '"' | '\\' | '$')
    ;

fragment EscapeSeq
    : UniCharacterLiteral
    | EscapedIdentifier
    ;

// SECTION: strings

QUOTE_OPEN: '"' -> pushMode(LineString);

TRIPLE_QUOTE_OPEN: '"""' -> pushMode(MultiLineString);

mode LineString;

QUOTE_CLOSE
    : '"' -> popMode
    ;

LineStrText
    : ~('\\' | '"' | '$')+ | '$'
    ;

LineStrEscapedChar
    : EscapedIdentifier
    | UniCharacterLiteral
    ;

LineStringExprStart: '${' -> pushMode(DEFAULT_MODE) ;

mode MultiLineString;

TRIPLE_QUOTE_CLOSE
    : MultiLineStringQuote? '"""' -> popMode
    ;

MultiLineStringQuote
    : '"'+
    ;

MultiLineStrText
    :  ~('"' | '$')+ | '$'
    ;

MultiLineStringExprStart: '${' -> pushMode(DEFAULT_MODE) ;