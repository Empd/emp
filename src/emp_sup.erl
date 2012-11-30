%% EMP_Sup.erl
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
%%  The primary supervisor of the EMP application OTP tree. This watches over 
%%  three separate applications which together form EMP. The Logging Server 
%%  (EMPLOG), the State database (EMPDB), and the EMP Daemon (EMPD) are all
%%  started in that order.
%% @end
%% ----------------------------------------------------------------------------
-module(emp_sup).
-behaviour(supervisor).

-export([start_link/1, init/1]).

%% Helper macro for declaring children of supervisor
-define( CHILD(Name, App, Args), 
            {Name, {App, start, [normal, Args]}, 
                permanent, 20000, supervisor, dynamic} ).


%% ====================================================================
%% External functions
%% ====================================================================

%% @doc Start the supervisor, called from EMP application module.
start_link( _StartArgs ) ->
    process_flag(trap_exit, true),
    supervisor:start_link({global, ?MODULE}, ?MODULE, []).


%% ====================================================================
%% Server functions
%% ====================================================================

%% @private
%% @doc Initialize the logging system, the database, and the daemon.
init([]) ->
    {ok, {emplog_app, Emplog_args}} = application:get_key(emplog, mod),  
    {ok, {empdb_app, Empdb_args}} = application:get_key(empdb, mod),
    {ok, {empd_app, Empd_args}} = application:get_key(empd, mod),
    
    {ok,{{one_for_one, 5, 60}, 
         [  % Order required.
            ?CHILD(emplog, emplog_app, Emplog_args),
            ?CHILD(empdb, empdb_app, Empdb_args),
            ?CHILD(empd, empd_app, Empd_args) 
         ]}}.
