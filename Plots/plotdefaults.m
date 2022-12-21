function plotdefaults(varargin)
% Default values
defaultFont = 'Inter';
defaultTextFontSize = 14;
defaultAxisFontSize = 14;
defaultLineThickness = 1.5;

% Parse inputs
p = inputParser;
addParameter(p,'Font',defaultFont,@ischar);
addParameter(p,'TextFontSize',defaultTextFontSize);
addParameter(p,'AxisFontSize',defaultAxisFontSize);
addParameter(p,'LineThickness',defaultLineThickness);
parse(p,varargin{:});

% Assign inputs
font = p.Results.Font;
size = p.Results.TextFontSize;
axSize = p.Results.AxisFontSize;
width = p.Results.LineThickness;

set(0,'defaultlinelinewidth',width);
set(0,'defaulttextfontname',font);
set(0,'defaultaxesfontname',font);
set(0,'DefaulttextFontSize',size);
set(0,'DefaultaxesFontSize',axSize);
