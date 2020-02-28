## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  results= 'markup'
)

## -----------------------------------------------------------------------------
library(RestRserve)

app = Application$new(content_type = "application/json")

backend = BackendRserve$new()

app$add_get("/foo", function(request, response) {
  body = RestRserve::to_json(request$parameters_query)
  response$set_body(body)
  # specify that there is no need to specially encode the body as
  # we've already set it to a JSON
  response$encode = identity
})


## -----------------------------------------------------------------------------
req = Request$new(path = "/foo", method = "GET", parameters_query = list(key1 = "value1", key2 = "value2"))
resp = app$process_request(req)
resp$body

## -----------------------------------------------------------------------------
logging_middleware = Middleware$new(
  process_request = function(request, response) {
    msg = list(
      middleware = "logging_middleware",
      request_id = request$id,
      request = list(headers = request$headers, method = request$method, path = request$path), 
      timestamp = Sys.time()
    )
    msg = RestRserve::to_json(msg)
    cat(msg, sep = '\n')
  },
  process_response = function(request, response) {
    msg = list(
      middleware = "logging_middleware",
      # we would like to have a request_id for each response in order to correlate
      # request and response
      request_id = request$id,
      response = list(headers = response$headers, status_code = response$status_code, body = response$body),
      timestamp = Sys.time()
    )
    msg = to_json(msg)
    cat(msg, sep = '\n')
  },
  id = "logging"
)

app$append_middleware(logging_middleware)

## -----------------------------------------------------------------------------
req = Request$new(path = "/foo", method = "GET", parameters_query = list(key1 = "value1", key2 = "value2"))
resp = app$process_request(req)

## -----------------------------------------------------------------------------
req = Request$new(path = "/foo2", method = "GET", parameters_query = list(key1 = "value1", key2 = "value2"))
resp = app$process_request(req)

## -----------------------------------------------------------------------------
gzip_middleware = Middleware$new(
  process_request = function(request, response) {
    msg = list(
      middleware = "gzip_middleware",
      request_id = request$id,
      timestamp = Sys.time()
    )
    msg = to_json(msg)
    cat(msg, sep = '\n')
  },
  process_response = function(request, response) {
    
    # compress body
    response$set_header("Content-encoding", "gzip")
    response$set_body(memCompress(response$body, "gzip"))
    
    msg = list(
      middleware = "gzip_middleware",
      request_id = request$id,
      timestamp = Sys.time()
    )
    msg = to_json(msg)
    cat(msg, sep = '\n')
  },
  id = "gzip"
)
app$append_middleware(gzip_middleware)

## -----------------------------------------------------------------------------
req = Request$new(path = "/foo", method = "GET", parameters_query = list(key1 = "value1", key2 = "value2"))
resp = app$process_request(req)

## -----------------------------------------------------------------------------
rawToChar(memDecompress(resp$body, "gzip"))

