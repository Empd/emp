%% EMP.erl
%%
%% @copyright 2011-2012 The EMP Group <http://www.emp-d.com/>
%% @end
%%
%% This library is free software; you can redistribute it and/or
%% modify it under the terms of the GNU Lesser General Public
%% License as published by the Free Software Foundation; either 
%% version 2.1 of the License, or (at your option) any later version.
%% 
%% This library is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%% Lesser General Public License for more details.
%% 
%% You should have received a copy of the GNU Lesser General Public
%% License along with this library.  If not, see <http://www.gnu.org/licenses/>.
%% ----------------------------------------------------------------------------
%% @doc 
%%  The application module and starting point of the OTP tree that makes up
%%  the Extensible Monitoring Platform (EMP).    
%% @end
%% ----------------------------------------------------------------------------
-module(emp).
-behaviour(application).

%% External API
-export([start/0, stop/0]).

%% Application callbacks
-export([start/2, prep_stop/1, stop/1]).


%% ===================================================================
%% External API
%% ===================================================================

%% @doc Start the EMP application.
start() -> 
    io:format("Starting EMP..."),
    application:start(emp),
    io:format("Done!~n").

%% @doc Stop the EMP application.
stop() ->
    io:format("Stopping EMP..."),
    application:stop(emp),
    io:format("Done!~n").


%% ===================================================================
%% Application callbacks
%% ===================================================================

%% @doc Called by `application` module to start up the EMP OTP tree.
start(_StartType, StartArgs) ->
    emp_sup:start_link(StartArgs). % start daemon

%% @doc Called right before stopping EMP OTP tree.
prep_stop( _State ) ->
    emplog:debug("EMP is shutting down...").

%% @doc Called after killing emp. Unused.
stop(_State) ->
    ok.

