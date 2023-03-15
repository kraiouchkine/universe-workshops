import ruby

predicate isRedirect(Ast::Expr redirectLocation) {
    exists(Ast::MethodCall redirectCall |
        redirectCall.getMethodName() = "redirect_to" and
        redirectLocation = redirectCall.getArgument(0)
    )
}

from Ast::Expr e
where isRedirect(e)
select e