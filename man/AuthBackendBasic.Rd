% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AuthBackendBasic.R
\name{AuthBackendBasic}
\alias{AuthBackendBasic}
\title{Basic authorization backend}
\description{
Creates AuthBackendBasic class object.
}
\examples{
# init users database
user_db = list(
  "user-1" = "password-1",
  "user-2" = "password-2"
)
# define authentication handler
auth_fun = function(user, password) {
  if (is.null(user_db[[user]])) return(FALSE) # not found
  if (!identical(user_db[[user]], password)) return(FALSE) # incorrect
  return(TRUE)
}
# init backend
auth_backend = AuthBackendBasic$new(FUN = auth_fun)

# test backend
# define credentials (see RFC)
creds = jsonlite::base64_enc("user-1:password-1")
# generate request headers
h = list("Authorization" = sprintf("Basic \%s", creds))
# simulate request
rq = Request$new(path = "/", headers = h)
# init response object
rs = Response$new()
# perform authentication
auth_backend$authenticate(rq, rs) # TRUE

}
\references{
\href{https://datatracker.ietf.org/doc/html/rfc7617}{RFC7617}
\href{https://en.wikipedia.org/wiki/Basic_access_authentication}{Wikipedia}
}
\seealso{
\link{AuthMiddleware} \link{Request} \link{Response}

Other AuthBackend: 
\code{\link{AuthBackend}},
\code{\link{AuthBackendBearer}},
\code{\link{AuthMiddleware}}
}
\concept{AuthBackend}
\section{Super class}{
\code{\link[RestRserve:AuthBackend]{RestRserve::AuthBackend}} -> \code{AuthBackendBasic}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-AuthBackendBasic-new}{\code{AuthBackendBasic$new()}}
\item \href{#method-AuthBackendBasic-authenticate}{\code{AuthBackendBasic$authenticate()}}
\item \href{#method-AuthBackendBasic-clone}{\code{AuthBackendBasic$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-AuthBackendBasic-new"></a>}}
\if{latex}{\out{\hypertarget{method-AuthBackendBasic-new}{}}}
\subsection{Method \code{new()}}{
Creates AuthBackendBasic class object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{AuthBackendBasic$new(FUN)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{FUN}}{Function to perform authentication which takes two arguments -
\code{user} and \code{password}.  Returns boolean - whether access is allowed for
a requested \code{user} or not.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-AuthBackendBasic-authenticate"></a>}}
\if{latex}{\out{\hypertarget{method-AuthBackendBasic-authenticate}{}}}
\subsection{Method \code{authenticate()}}{
Provide authentication for the given request.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{AuthBackendBasic$authenticate(request, response)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{request}}{\link{Request} object.}

\item{\code{response}}{\link{Response} object.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
Boolean - whether access is allowed for a requested \code{user} or not.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-AuthBackendBasic-clone"></a>}}
\if{latex}{\out{\hypertarget{method-AuthBackendBasic-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{AuthBackendBasic$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
