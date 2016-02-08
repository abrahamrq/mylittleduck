import ply.lex as lex

# List of tokens
reserved = {
	 'program' : 'PROGRAM',
   'int' : 'INT',
   'float' : 'FLOAT',
   'if' : 'IF',
   'var' : 'VAR',
   'else' : 'ELSE',
   'print' : 'PRINT'
}
tokens = ( 'INT', 'FLOAT', 'INTCONST', 'FLOATCONST','STRINGCONST', 
					 'PROGRAM', 'SEMICOLON', 'COLON', 'VAR', 'DIFFERENCE', 'LESSER', 
					 'GREATER', 'IF', 'OPENBRACKETS', 'CLOSEBRACKETS', 'ADD', 'SUB', 
					 'MULT', 'DIV', 'COMMA', 'EQUAL', 'PRINT', 'OPENPARENTHESIS', 
					 'CLOSEPARENTHESIS', 'ELSE', 'ID')

#Tokens definitions
t_ignore = ' \t\n'
t_STRINGCONST = r'\".*\"'
t_INTCONST = r'[0-9]+ '
t_FLOATCONST = r'[0-9]+\.+[0-9]+'
t_SEMICOLON = r';'
t_COLON = r':'
t_DIFFERENCE = r'<>'
t_LESSER = r'<'
t_GREATER = r'>'
t_OPENBRACKETS = r'{'
t_CLOSEBRACKETS = r'}'
t_ADD = r'\+'
t_SUB = r'-'
t_MULT = r'\*'
t_DIV = r'/'
t_COMMA = r','
t_EQUAL = r'='
t_OPENPARENTHESIS = r'\('
t_CLOSEPARENTHESIS = r'\)'

def t_ID(t):
  r'[a-zA-Z]+(_?[a-zA-Z0-9])*'
  t.type = reserved.get(t.value, 'ID')    # Check for reserved words
  return t

def t_error(t):
  print 'Lexer error: ', t
  exit(-1)
  t.lexer.skip(1)


lexer = lex.lex()