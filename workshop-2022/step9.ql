/**
 * @name URL redirection
 * @kind problem
 * @id rb/url-redirection
 */
import ruby
import codeql.ruby.frameworks.ActionController
import codeql.ruby.Concepts
import codeql.ruby.dataflow.RemoteFlowSources
import codeql.ruby.TaintTracking

class GetHandlerMethod extends Ast::MethodBase {
    GetHandlerMethod() {
      this.(ActionControllerActionMethod).getARoute().getHttpMethod() = "get"
      or
      not exists(this.(ActionControllerActionMethod).getARoute()) and
      this = any(ActionControllerControllerClass c).getAMethod() and
      not this.getName().regexpMatch(".*(create|update|destroy).*")
    }
  }

predicate isRedirect(DataFlow::Node redirectLocation, GetHandlerMethod method) {
    exists(Http::Server::HttpRedirectResponse redirectCall |
      redirectCall.getRedirectLocation() = redirectLocation and
      redirectCall.asExpr().getExpr().getEnclosingMethod() = method
    )
  }

class UrlRedirectionConfig extends TaintTracking::Configuration {
  UrlRedirectionConfig() { this = "UrlRedirectionConfig" }
  override predicate isSource(DataFlow::Node source) {
    // TODO: replace this
    // CodeQL offers `RemoteFlowSource` to represent remote flow sources.
    // Use `instanceof` to check if the source is a remote flow source.
  }
  override predicate isSink(DataFlow::Node sink) {
    // TODO: replace this
  }
}

from UrlRedirectionConfig config, DataFlow::Node source, DataFlow::Node sink
where config.hasFlow(source, sink)
select sink, "Potential URL redirection"