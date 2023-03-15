import ruby
/*
    Recall that predicates allow you to encapsulate logical conditions in a reusable format. 

    You can translate from the previous query clause to a predicate by:
      - Converting some variable declarations in the `from` part to the variable declarations of an `exists`
      - Placing the `where` clause conditions (if any) in the body of the exists
      - Adding a condition which equates the `select` to one of the parameters of the predicate.

    Convert your previous query to a predicate which identifies the set of expressions in the program 
    which are arguments of `redirect_to` method calls. You can use the following template:
*/
predicate isRedirect(Ast::Expr redirectLocation) {
  exists(Ast::MethodCall redirectCall |
    // TODO replace this
    none()
  )
}

from Ast::Expr e
where isRedirect(e)
select e