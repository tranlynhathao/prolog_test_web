% Main file to run the Web Prolog.
% Loads the demo and starts a server
% Start swipl

:- consult(load).

:- node(localhost, 3000).
