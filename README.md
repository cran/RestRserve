# RestRserve <a href='http://restrserve.org'><img src='man/figures/logo.png' align="right" height="128" /></a>

[![Travis-CI Build Status](https://travis-ci.org/rexyai/RestRserve.svg?branch=master)](https://travis-ci.org/rexyai/RestRserve)
[![Build status](https://ci.appveyor.com/api/projects/status/diyn9rjeh6wbwm1g/branch/master?svg=true)](https://ci.appveyor.com/project/dselivanov/restrserve/branch/master)
[![codecov](https://codecov.io/gh/rexyai/RestRserve/branch/master/graph/badge.svg)](https://codecov.io/gh/rexyai/RestRserve/branch/master)
[![License](https://eddelbuettel.github.io/badges/GPL2+.svg)](http://www.gnu.org/licenses/gpl-2.0.html)
[![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![gitter](https://img.shields.io/gitter/room/RestRserve/community.svg?color=61D6AD&style=popout)](https://gitter.im/RestRserve/community)
<a href="https://www.rexy.ai"><img src="https://s3-eu-west-1.amazonaws.com/rexy.ai/images/favicon.ico" height="32" width="32"></a>

[RestRserve](https://github.com/rexyai/RestRserve) is an R web API framework for building **high-performance** AND **robust** microservices and app backends. With [Rserve](https://github.com/s-u/Rserve) backend on UNIX-like systems it is **parallel by design**. It will handle incoming requests in parallel - each request in a separate fork (all the credits should go to [Simon Urbanek](https://github.com/s-u)).

## Quick start

Creating application is as simple as:
```r
library(RestRserve)
app = Application$new()
app$add_get(
  path = "/hello", 
  FUN = function(request, response) {
    response$set_body("Hello from RestRserve")
  })
backend = BackendRserve$new()
backend$start(app, http_port = 8080)
```

Now you can type `http://localhost:8080/hello` in your favorite browser and see (surprisingly!) *Hello from RestRserve*.


## Learn RestRserve

- follow [quick start guide on http://restrserve.org/](http://restrserve.org/articles/RestRserve.html) for more details.
- check out "Articles" section on http://restrserve.org/
- browse [examples on https://github.com/rexyai/RestRserve](https://github.com/rexyai/RestRserve/tree/master/inst/examples)

## Features

- Easy to install, small number of dependencies
- Fully featured http server with the **support for URL encoded and multipart forms**
- Build **safe and secure applications** - RestRserve supports *https*, provides building blocks for basic/token authentication
- Concise and intuitive syntax
- **Raise meaningful http errors** and allows to interrupt request handling from any place of the user code
- Comes with **many examples** - see `inst/examples`
- Saves you from boilerplate code:
  - automatically decodes request body from the common formats
  - automatically encodes response body to the common formats
  - automatically parses URI templates (such as `/get/{item_id}`)
  - helps to expose OpenAPI and Swagger/Redoc/Rapidoc UI
- It is [fast](http://restrserve.org/articles/benchmarks/Benchmarks.html)!

![](vignettes/img/bench-rps.png)

## Installation

### From source
```r
remotes::install_github("rexyai/RestRserve")
```

### Docker

Automated docker builds from docker-hub: [https://hub.docker.com/r/rexyai/restrserve/](https://hub.docker.com/r/rexyai/restrserve/)

## Contributing

Guidelines for filing issues / pull requests - [CONTRIBUTING.md](https://github.com/rexyai/RestRserve/blob/master/CONTRIBUTING.md).

## Acknowledgements

- [Simon Urbanek](https://github.com/s-u/) (@s-u) for awesome [Rserve](https://github.com/s-u/Rserve) and all the work on R itself and on his other packages
- [Jeff Allen](https://github.com/trestletech) (@trestletech) for his work on Swagger UI in [plumber](https://github.com/trestletech/plumber) (from where we took inspiration for our implementation)
- [Brodie Gaslam](https://github.com/brodieG) (@brodieG) for help with understanding on how to get traceback from try-catch function calls. Also thanks [Hadley Wickham](https://github.com/hadley) (@hadley) for `evaluate::try_capture_stack` function which we use for this purpose.

## Known limitations

- RestRserve is primarily tested on UNIX systems. While it works natively on Windows please don't expect it to be as performant as on UNIX-like systems. If you really want to use it on Windows - consider to try [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/faq) and report back.
- Keep in mind that every request is handled in a separate process (fork from a parent R session). While this feature allows to handle requests in parallel it also restricts reuse of certain objects which are not fork-safe (notably database connections, rJava objects, etc)

## Related projects

- [Rook](https://github.com/jeffreyhorner/Rook)
- [FastRWeb](https://CRAN.R-project.org/package=FastRWeb)
- [opencpu](https://www.opencpu.org/)
- [plumber](https://www.rplumber.io/)
- [fiery](https://github.com/thomasp85/fiery)
- [jug](https://github.com/Bart6114/jug) (development discontinued)
