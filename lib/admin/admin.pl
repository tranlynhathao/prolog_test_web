:- module(admin, []).

:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- use_module(library(pairs)).
:- use_module(library(settings)).
:- use_module(library(pengines)).

:- http_handler(root(admin/show_settings), show_settings, []).
:- http_handler(root(admin/set_settings), set_settings, []).


show_settings(Request) :-
  http_parameters(
    Request,
    [  type(Type, [])  ]),
    ( Type == server
      -> findall(M-N, (current_setting(M:N), server_properties(M)), List); Type == applications
      -> findall(M-N, (current_setting(M:N), application_properties(M)), List
    )
  ),
  keysort(List, Sorted0),
  delete(Sorted0, pengine-_, Sorted),
  group_pairs_by_key(Sorted, ByModule),
  show_modules(ByModule, JsonByModule),
  reply_json(json([settings=JsonByModule])).

server_properties(http).
server_properties(storage).
