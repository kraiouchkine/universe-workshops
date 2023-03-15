import ruby

/*
    Calls to the `redirect_to` method use its first argument as the target URL. Update your query to report the redirection argument.

    - `MethodCall.getAnArgument()` returns all possible arguments of the method call.
    - `MethodCall.getArgument(int i)` returns the argument at (0-based) index `i` of the method call.
    - The argument is an _expression_ in the program, represented by the CodeQL class `Ast::Expr`.
    - Introduce a new variable in the `from` clause to hold this expression, and output the variable in the `select` clause.
*/
from Ast::MethodCall redirectCall, // TODO add a new variable here
where
  redirectCall.getMethodName() = "redirect_to" and
  // TODO replace this
  none()
select redirectCall, // TODO output the new variable here