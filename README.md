## EMP ##

This is the primary repo of the Extensible Monitoring Platform.


### Downloading the Source ###

There are several links to the side that can download the source as a 
standalone. However we recommend forking or cloning the master repo:

	git clone https://<username>@github.com/dstar4138/emp.git
	
And if you would like to live on the wild side, use the experimental branch:

	git checkout -b experimental origin/experimental
	

### Experimenting With EMP ###

We made a script for you so you can load EMP up in a terminal and not have to 
worry about compiling a release binary. But first you will need to compile the 
source into bytecode.

    make emp
    
This will grab all dependencies into a directory called `deps` and then 
compile everything. If there are errors please let us know! Now you can load 
emp's shell up by typing:

    ./startemp.sh

This will start everything up as long as no errors appear! This is the erlang
virual machine shell, but it automatically starts EMP when its run. You will
be able to run testing functions from here.

If you are familiar with Erlangs Observer program, feel free to start it up 
and see the processes running. At this point you can pop open empi and log in 
as root (which is the only default account at the moment).


### Testing EMP ###

We are still in the process of writing our testing framework, but since we are 
using Erlangs built in EUnit, testing with rebar is a snap!

    make eunit
    
This will test all dependencies and emp itself using the EUnit testing 
framework.


### Compiling ###

We also use rebar for our compiling of EMP into a standalone binary. We 
streamlined this process into one makefile:

    make compile

This will generate a `rel` directory. The binary will be located at 
`rel/emp/bin/emp`. 

NOTICE: you do not need to compile a release version of EMP currently, you can 
do everything you need within the `./loaderl.sh` or `./startemp.sh` scripts!


### Running EMP release binaries ###

Go into the release directory and launch emp:

    cd rel/emp/bin
    ./emp start
	
Then to view it in the shell you can attach to the running node:
    
    ./emp attach

	
### Installing EMP ###

TODO: look at `rebar -v generate` and `rebar install` for more information
