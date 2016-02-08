import ply.yacc as yacc
import lex
tokens = lex.tokens

def p_program(p):
  '''program : PROGRAM ID SEMICOLON vars block'''
  p[0] = "Valid"

def p_vars(p):
  '''vars : VAR declaration
          |'''

def p_ids(p):
  '''ids : ID idsloop'''

def p_idsloop(p):
  '''idsloop : COMMA idsloop2
             |'''

def p_idsloop2(p):
  '''idsloop2 : ID COMMA idsloop2
              | ID'''

def p_type(p):
  '''type : INT
          | FLOAT'''

def p_declaration(p):
  '''declaration : ids COLON type SEMICOLON declarationloop'''

def p_declarationloop(p):
  '''declarationloop : declaration
                     |'''

def p_block(p):
  '''block : OPENBRACKETS statutesloop CLOSEBRACKETS'''

def p_statutesloop(p):
  '''statutesloop : statute statutesloop
                  |'''

def p_statute(p):
  '''statute : assignment
             | condition
             | writting'''

def p_expression(p):
  '''expression : exp expressionaux'''

def p_expressionaux(p):
  '''expressionaux : comparer exp
                   |'''

def p_comparer(p):
  '''comparer : GREATER
              | LESSER
              | DIFFERENCE'''

def p_exp(p):
  '''exp : term expaux'''

def p_expaux(p):
  '''expaux : operation exp
            |'''

def p_operation(p):
  '''operation : ADD
               | SUB'''

def p_term(p):
  '''term : factor termaux'''

def p_termaux(p):
  '''termaux : operation2 term
             |'''

def p_operation2(p):
  '''operation2 : MULT
                | DIV'''

def p_factor(p):
  '''factor : OPENBRACKETS expression CLOSEBRACKETS
            | optionaloperator constvar'''

def p_optionaloperator(p):
  '''optionaloperator : operation
                      |'''

def p_constvar(p):
  '''constvar : ID
              | INTCONST
              | FLOATCONST'''

def p_assignment(p):
  '''assignment : ID EQUAL expression SEMICOLON'''

def p_writting(p):
  '''writting : PRINT OPENPARENTHESIS expstring writtingloop CLOSEPARENTHESIS SEMICOLON'''

def p_expstring(p):
  '''expstring : expression
               | STRINGCONST'''

def p_writtingloop(p):
  '''writtingloop : COMMA expstring writtingloop
                  |'''

def p_condition(p):
  '''condition : IF OPENPARENTHESIS expression CLOSEPARENTHESIS block elsecondition SEMICOLON'''

def p_elsecondition(p):
  '''elsecondition : ELSE block
                   |'''

def p_error(p):
    if type(p).__name__ == 'NoneType':
      print('Syntax error')
    else:
      print('Syntax error at token', p.type, p.value)
# Build the parser
parser = yacc.yacc(start='program')

def check(filename):
  f = open(filename, 'r')
  data = f.read()
  f.close()
  if parser.parse(data) == 'Valid':
    print('VALID!')