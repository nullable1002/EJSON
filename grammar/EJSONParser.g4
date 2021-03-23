/*
 * Nibble syntax grammar in ANTLR4 notation.
 */

parser grammar EJSONParser;

options {
	tokenVocab = EJSONLexer;
}

andOptr
	: AND
	;

orOptr
	: OR
	;

prefixOptr
	: NOT
	| ADD
	| SUB
	;

suffixOptr
	: indexing
	;

additiveOptr
	: ADD
	| SUB
	;

multiplicativeOptr
	: MUL
	| DIV
	| MOD
	;

indexing
	: LSQUARE valueExpr RSQUARE (LSQUARE valueExpr RSQUARE)*
	;

comparisonOptr
	: LT
	| LE
	| GT
	| GE
	;

ejson
	: LCURL (declaration (COMMA declaration)*)? RCURL
	;

declaration
	: identifier COLON expression
	;

identifier
	: Identifier
	;

expression
	: valueExpr
	| compoundExpr
	;

valueExpr
	: checkExpr
	;

checkExpr
	: conjuctionExpr (QUEST valueExpr COLON valueExpr)?
	;

conjuctionExpr
	: disjunctionExpr (andOptr valueExpr)*
	;

disjunctionExpr
	: comparisonExpr (orOptr valueExpr)*
	;

comparisonExpr
	: multiplicativeExpr (comparisonOptr multiplicativeExpr)*
	;

multiplicativeExpr
	: additiveExpr (multiplicativeOptr valueExpr)*
	;

additiveExpr
	: prefixExpr (additiveOptr valueExpr)*
	;

prefixExpr
	: prefixOptr? suffixExpr
	;

suffixExpr
	: primaryExpression suffixOptr?
	;

primaryExpression
	: NullLiteral
	| BooleanLiteral
	| BinLiteral
	| OctLiteral
	| IntegerLiteral
	| FloatLiteral
	| stringLiteral
	| identifier
	| memberAccess
	| parenthesizedExpr
	;

parenthesizedExpr
	: LPAREN valueExpr (COMMA valueExpr) RPAREN
	;

memberAccess
	: identifier indexing? (DOT identifier indexing?)+
	;

stringLiteral
	: lineStringLiteral
	| multiLineStringLiteral
	;

lineStringLiteral
	: QUOTE_OPEN (lineStringContent | lineStringExpression)* QUOTE_CLOSE
	;

lineStringContent
	: LineStrText
	| LineStrEscapedChar
	;

lineStringExpression
	:	LineStringExprStart expression RCURL
	;

multiLineStringLiteral
	: TRIPLE_QUOTE_OPEN (multiLineStringContent | multiLineStringExpression | MultiLineStringQuote)* TRIPLE_QUOTE_CLOSE
	;

multiLineStringContent
	: MultiLineStrText
	| MultiLineStringQuote
	;

multiLineStringExpression
	: MultiLineStringExprStart expression RCURL
	;

compoundExpr
	: objectExpr
	| arrayExpr
	;

arrayExpr
	: LSQUARE (expression (COMMA expression)*)? RSQUARE
	;

objectExpr
	: LCURL (declaration (COMMA declaration)*)? RCURL
	;