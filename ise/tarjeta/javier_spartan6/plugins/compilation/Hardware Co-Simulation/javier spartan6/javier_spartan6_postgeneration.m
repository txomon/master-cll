%
% Filename:    javier_spartan6_postgeneration.m
%
% Description: Defines board-specific parameters (e.g. ucf file, 
%              non-memory mapped ports) before invoking the 
%              generic JTAG post-generation callback function.

function st = javier_spartan6_postgeneration(params)

  % Device position in the boundary scan chain (beginning at 1).
  params.('boundary_scan_position') = '1';

  % Instruction register length of every scan chain device. 
  params.('instruction_register_lengths') = '[6]';

  % Constraints file to use for this compilation target.
  params.('ucf_template') = 'javier_spartan6.ucf'; 

  % You may use your own top-level netlist file by uncommenting the 
  % following line and setting the 'vendor_toplevel' field accordingly.
  % params.('vendor_toplevel') = 'javier_spartan6_toplevel';

  % If you use your own top-level, you must tell SysGen what netlist 
  % files are required.  Set the 'vendor_netlists' field to a cell 
  % array listing the required file names. 
  % params.('vendor_netlists') = {'javier_spartan6_toplevel.ngc','javier_spartan6.edf'};

  % Invoke the JTAG post-generation callback function to run
  % Xilinx tools and create a run-time co-simulation token.
  try
    st = xlJTAGPostGeneration(params);
  catch
    errordlg(['-- An unknown error was encountered while running ' ...
             'the JTAG hardware co-simulation flow for the ' ...
             'javier spartan6']);
    st = 1;
  end
