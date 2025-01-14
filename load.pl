% Main file to load the pengines demo. This file is included from
%   - debug.pl for local debbuging
%   - daemon.pl to run pengines as a Unix service

%  :- use_module(library(pengines)).

:- use_module(library(http/http_error)).
:- use_module(server).
:- use_module(storage).

% :- use_module('../web_prolog.pl')
%:- use_module(lib/admin/admin).
%:- use_module(lib/admin/server_statistics).
