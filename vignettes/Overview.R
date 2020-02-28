## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  results = 'markup'
)

## ------------------------------------------------------------------------
library(RestRserve)
backend = BackendRserve$new()
application = Application$new()

## ------------------------------------------------------------------------
request = Request$new(
  path = "/factorial", 
  method = "GET", 
  parameters_query = list(x = 10)
)

## ------------------------------------------------------------------------
application$add_get(path = "/factorial", function(req, res) {
  x = as.integer(req$get_param_query("x"))
  result = factorial(x)
  res$set_body(result)
})

## ------------------------------------------------------------------------
response = application$process_request(request)
response

## ------------------------------------------------------------------------
application = Application$new()
application$add_get("/hello", function(request, response) {
  response$body = "hello from RestRserve"
})

## ------------------------------------------------------------------------
request = Request$new(path = "/bye-bye", method = "GET")
response = application$process_request(request)
response$body

## ------------------------------------------------------------------------
request = Request$new(path = "/hello", method = "POST")
response = application$process_request(request)
response$body

## ------------------------------------------------------------------------
application$add_get("/power2", function(request, response) {
  x = request$get_param_query("x")
  response$body = x ** 2
})
request = Request$new(path = "/power2", method = "GET", parameters_query = list(x = "10"))
response = application$process_request(request)
response

## ------------------------------------------------------------------------
application$logger$set_log_level("debug")
response = application$process_request(request)

