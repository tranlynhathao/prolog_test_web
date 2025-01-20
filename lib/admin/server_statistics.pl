:- module(server_statistics, []).
:- use_module(library(pairs)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_stream)).
:- use_module(library(pengines)).

:- http_handler(root(statistics), statistics, []).

statistics(_Request) :-
  server_statistics(Stats),
  reply_json(Stats).

server_statistics(_{  servers:Servers,
  requests:Count,
  bytes_sent:Sent,
  pengines:Pengines
}) :-
  findall(Port-ID, http_current_worker(Port, ID), Workers),
  group_pairs_by_key(Workers, Servers0),
  cgi_statistics(requests(Count)),
  pengine_statistics(Pengines).

servers_stats([], []).
servers_stats([H|T], [Json|List]) :-
  servers_stats2(H, Json),
  servers_stats(T, List).

servers_stats2(Port-Workers, _{port:Port, started:ST, cputime:CPU, workers:N}) :-
  length(Workers, N),
  http_server_property(Port, start_time(StartTime)),
  format_time(string(ST), '%+', StartTime),
  statistics(process_cputime, CPU).

pengine_statistics(Stats) :-
  findall(Stat, pengine_stats(_Pengine, Stat), Stats).

pengine_stats(Pengine, Stats) :-
  pengine_property(Pengine, self(_)),
  catch(pengine_stats2(Pengine, Stats), _, fail).

pengine_stats2(Pengine, pengine{type:remote, application:App}) :-
  pengine_property(Pengine, remote(_Server)), !,
  pengine_property(Pengine, application(App)).

pengine_stats2(Pengine,
  pengine{
    application{
      type:local,
      application:App,
      cputime:CPU,
      stacks:_{ global:Global, local:Local, trail:Trail}
  }
}) :- !,
  pengine_property(Pengine, application(App)),
  pengine_property(Pengine, thread(Thread)),
  thread_statistics(Thread, cputime, CPU),
  thread_statistics(Thread, globalused, Global),
  thread_statistics(Thread, localused, Local),
  thread_statistics(Thread, trailused, Trail).
