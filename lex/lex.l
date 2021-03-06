%{
	#include <string.h>
	char *yylval;  /* semantic value of token */
	enum yyconstants {EQ = 1, LP, RP, LB, RB, SEMICOLON, TITLE, BODY, H1, H2, H3, H4, H5, H6, STYLE, 		COLOR, ALIGNMENT, FONT, PARAGRAPH, BOLD, ITALIC, UNDERLINE, LINK, IMAGE, ID, VALUE, COMMENT};
%}
delim    [ |\t|\n|,]+
letter	[A-Za-z]
number	[0-9]+
id	{letter}({letter}|{number})*
value	(["]([^,\n\t]+)["])|[A-Z]{2,}|{number}
comment \/{2}(.)+(\n)|\/\*(.)+\\*\/

%%
{delim}     	{/* no action and no return */}
TITLE 		{yylval = "TITLE"; return TITLE;}
body  		{yylval = "BODY"; return BODY;}
heading1	{yylval = "H1"; return H1;}
heading2	{yylval = "H2"; return H2;}
heading3	{yylval = "H3"; return H3;}
heading4	{yylval = "H4"; return H4;}
heading5	{yylval = "H5"; return H5;}
heading6	{yylval = "H6"; return H6;}
style		{yylval = "STYLE"; return STYLE;}
color		{yylval = "COLOR"; return COLOR;}
alignment	{yylval = "ALIGNMENT"; return ALIGNMENT;}
font		{yylval = "FONT"; return FONT;}
paragraph	{yylval = "PARAGRAPH"; return PARAGRAPH;}
isBold		{yylval = "BOLD"; return BOLD;}
isItalic	{yylval = "ITALIC"; return ITALIC;}
isUnderline	{yylval = "UNDERLINE"; return UNDERLINE;}
link		{yylval = "LINK"; return LINK;}
image		{yylval = "IMAGE"; return IMAGE;}
{id}		{yylval = yytext; return ID;}
{value}		{yylval = yytext; return VALUE;}
{comment}	{yylval = yytext; return COMMENT;}
"="		{yylval = "EQ"; return EQ;}
"("		{yylval = "LP"; return LP;}
")"		{yylval = "RP"; return RP;}
"{"		{yylval = "LB"; return LB;}
"}"		{yylval = "RB"; return RB;}
";"		{yylval = "SEMICOLON"; return SEMICOLON;}
.		printf("Unexpected lexical structure!: %s\n", yytext);

%%
main(){
  int t;
  // open a file handle to a particular file:
  FILE *myfile = fopen("input.in", "r");
  // make sure it's valid:
  if (!myfile) {
	printf("I can't open input.in!\n");
	return -1;
  }

  FILE *outputFile = fopen("output.out", "w");


  yyin = myfile;
  while (t=yylex()){
    if(t==ID)
      fprintf(outputFile, "ID(%s) ",yylval);
    else if(t==VALUE)
      fprintf(outputFile, "VALUE(%s) ",yylval);
    else if(t==COMMENT){
      fprintf(outputFile, "COMMENT \n");
    }
    else if (t==SEMICOLON)
      fprintf(outputFile, "%s\n", yylval);
    else
      fprintf(outputFile, "%s ",yylval);
    }
  printf("\n");
}

