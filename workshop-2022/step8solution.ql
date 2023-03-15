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

predicate isRedirect(Ast::Expr redirectLocation, GetHandlerMethod method) {
  exists(Ast::MethodCall redirectCall |
    redirectCall.getMethodName() = "redirect_to" and
    redirectLocation = redirectCall.getArgument(0) and
    redirectCall.getEnclosingMethod() = method
  )
}

from Ast::Expr e, GetHandlerMethod method
where isRedirect(e, method)
select e, method