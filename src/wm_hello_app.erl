%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the wm_hello application.

-module(wm_hello_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for wm_hello.
start(_Type, _StartArgs) ->
    wm_hello_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for wm_hello.
stop(_State) ->
    ok.
