import ruby

/*
    Find all calls in the program to methods named `redirect_to`.

    - Add a `where` clause.
    - `MethodCall` has a predicate called `getMethodName()` that returns the method name as a `string`.
    - CodeQL string literals are written in "double quotes".
    - Use the equality operator `=` to assert that two CodeQL expressions are the same. NOTE: not `==`, just `=`.
*/
from Ast::MethodCall redirectCall
select redirectCall