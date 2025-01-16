/** <module> Prolog Web Server **/
:- module(server, [ ]).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cookie)).
:- use_module(library(http/http_server_files)).
:- use_module(library(debug)).
:- use_module(library(apply)).
:- use_module(library(settings)).
:- use_module(library(http/http_authenticate)).

:- multifile user:file_search_path/2.
:- dynamic user:file_search_path/2.

:- prolog_load_context(directory, Dir), asserta(user:file_search_path(app, Dir)).

user:file_search_path(www, app(www)).
user:file_search_path(apps, app(apps)).

:- http_handler(root(apps), serve_files_in_directory(apps), [prefix]).
:- http_handler(root(.), serve_files_in_directory(www), [prefix]).

:- http_handler(root(tutorial), http_reply_file('www/tutorial.html', []), [prefix]).
:- http_handler(root(admin/server), http_reply_file('www/admin/server.html', []), [prefix, authentication(basic(passwd, admin))]).
