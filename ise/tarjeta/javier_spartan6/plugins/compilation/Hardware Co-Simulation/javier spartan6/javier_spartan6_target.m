%
% Filename:    javier_spartan6_target.m
%
% Description: This file defines the supported and default compilation
%              settings for the javier spartan6
%

function settings = javier_spartan6_target

  % Define parts supported by the target.
  part0.('family') = 'spartan6';
  part0.('part') = 'xc6slx45';
  part0.('speed') = '-3';
  part0.('package') = 'csg324';
  settings.('supported_parts').('allowed') = {part0};

  % Target has a fixed, free-running clock period.
  settings.('sysclk_period').('allowed') = '10';

  % Define post-generation callback function.
  settings.('postgeneration_fcn') = 'javier_spartan6_postgeneration';

  % Set default target directory for this target.
  settings.('directory') = './netlist';

  % List supported synthesis tools.
  settings.('synthesis_tool') = 'XST';

  % Define pre-compile callback function.
  settings.('precompile_fcn') = 'xlJTAGPreCompile';

  % Define post-generation callback function.
  settings.('getimportblock_fcn') = 'xlGetHwcosimBlockName';

  % Disable the clock location constraint field.
  settings.('clock_loc').('allowed') = 'Fixed';

  % Define a hardware co-simulation settings GUI.
  settings.('settings_fcn') = 'xlJTAGXFlowSettings';
