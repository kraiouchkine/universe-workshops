import ruby
import codeql.ruby.frameworks.ActionController

class GetHandlerMethod extends Ast::MethodBase {
  GetHandlerMethod() {
    this.(ActionControllerActionMethod).getARoute().getHttpMethod() = "get"
    or
    not exists(this.(ActionControllerActionMethod).getARoute()) and
    this = any(ActionControllerControllerClass c).getAMethod() and
    not this.getName().regexpMatch(".*(create|update|destroy).*")
  }
}

// Adapt the following predicate and `from, where, select` clauses so
// that `isRedirect` only outputs `Ast::Expr` that are in a `GetHandlerMethod`
predicate isRedirect(Ast::Expr redirectLocation) { // TODO: add a parameter
    exists(Ast::MethodCall redirectCall |
        redirectCall.getMethodName() = "redirect_to" and
        redirectLocation = redirectCall.getArgument(0)
        // TODO: add logic here
    )
}

// TODO: adapt this query to also output the `GetHandlerMethod`
from Ast::Expr e
where isRedirect(e)
select e