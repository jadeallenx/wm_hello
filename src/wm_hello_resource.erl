-module(wm_hello_resource).
-export([init/1, to_html/2, to_json/2, generate_etag/2]).
-export([encodings_provided/2, content_types_provided/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) ->
  {{trace, "/tmp"}, "Hello, world"}.

content_types_provided(Req, State) ->
  {
   [
      {"text/html", to_html}, 
      {"application/json", to_json}
   ], Req, State}.

to_json(Req, State) ->
  {mochijson2:encode({struct, [{greeting, list_to_binary(State)}]}), 
   wrq:set_resp_header(
     "Content-Type", 
     "application/json", 
    Req), 
   State}.


to_html(Req, State) ->
  {io_lib:format("<html><head><title>~s</title></head><body>~s</body></html>", [State, State]), 
      Req, State}.

generate_etag(Req, State) ->
  {mochihex:to_hex(crypto:md5(State)), Req, State}.

encodings_provided(Req, State) ->
  {[{"gzip", fun(X) -> zlib:gzip(X) end}], Req, State}.
