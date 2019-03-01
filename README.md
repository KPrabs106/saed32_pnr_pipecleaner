# saed32_pnr_pipecleaner
Sample place and route flow for EE 272 designed for the Synopsys SAED32nm EDK.

The EDK is located at /cad/synopsys_EDK3/SAED32_EDK.

# Directories
rtl - You should put your synthesized gate-level netlist here.
syn - Synthesis flow used to synthesize pipecleaner design. Don't worry about this.
pnr - Place and route directory. Essentially everything you do will be here.


# Environment setup
Put the following lines into your .cshrc
~~~
setenv LD_LIBRARY_PATH /usr/lib:\$LD_LIBRARY_PATH
mkdir -p ~/.modules # included to suppress warning

source /cad/modules/tcl/init/csh
module load base
module load genesis2
module load incisive/15.20.022
module load lc
module load syn/latest
module load dc_shell/latest
module load cdesigner/latest
module load icc/latest
module load hercules
module load vcs/latest
module load starrc/latest
module load cx/2009.09
module load icvalidator/M-2016.12
setenv MC_HOME /cad/synopsys/saed_mc/v2.3.0
setenv SAED_MC_32_28_PDK $MC_HOME/etc/techs/SAED_PDK_32/
setenv PERL5LIB $MC_HOME/lib:$PERL5LIB
setenv PATH $MC_HOME/bin:$PATH
setenv SAED32_28_PDK /cad/synopsys/SAED_PDK32nm
setenv SAED32_PATH /cad/synopsys_EDK3/SAED32_EDK`
~~~

Or, if you're using bash, put the following into your .bashrc
~~~
export LD_LIBRARY_PATH=/usr/lib:\$LD_LIBRARY_PATH
mkdir -p ~/.modules # included to suppress warning

source /cad/modules/tcl/init/bash
module load base
module load genesis2
module load incisive/15.20.022
module load lc
module load syn/latest
module load dc_shell/latest
module load icc/latest
module load cdesigner/latest
module load hercules
module load vcs/latest
module load starrc/latest
module load cx/2009.09
module load icvalidator/M-2016.12
export MC_HOME=/cad/synopsys/saed_mc/v2.3.0
export SAED_MC_32_28_PDK=$MC_HOME/etc/techs/SAED_PDK_32/
export PERL5LIB=$MC_HOME/lib:$PERL5LIB
export PATH=$MC_HOME/bin:$PATH
export SAED32_28_PDK=/cad/synopsys/SAED_PDK32nm
export SAED32_PATH=/cad/synopsys_EDK3/SAED32_EDK
~~~
