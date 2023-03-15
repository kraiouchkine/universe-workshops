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

from GetHandlerMethod method
select method