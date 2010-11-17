function [] = jointAngle_plot(str_P, str_title)
%
% SYNOPSIS
%   [] = jointAngle_plot(str_P, str_title)
%
% ARGS
%   str_P       in      directory containing cop data
%   str_title   in      title for plot
%
% DESC
%   The basic purpose of this function is to parse the 
%   jointAngle.log output generated by a run of the RL
%   system.
%
%   The cop.log file adheres to a strict format:
%   col #       meaning
%   [1-6]       miscellaneous logging pre-pends
%   7           time (iteration of system)
%   8           episode
%   9           episode length
%   15          left hip Angle
%   18          left knee Angle
%   21          left Angle Angle
%   24          right hip Angle
%   27          right knee Angle
%   30          right Angle Angle
%
% HISTORY
%   31 October 2002
%   o Initial design and coding.
%

close all

n = 6;                         % Total number of plots

disp('Reading jointAngle.log data...');
homeDir=pwd;
cd(str_P)
!cat jointAngle.log | awk '{print $9" "$13" "$14" "$15" "$16" "$17" "$18'} > plot_jointAngle.log
load('plot_jointAngle.log');
cd(homeDir);

records = size(plot_jointAngle);
length  = records(1,1)-1;
t       = plot_jointAngle(1:length,1);

str_number  = sprintf('\t\t\t[%d samples read]', length);
disp(str_number);

joint = {'HIP', 'KNEE', 'ANKLE'};
h = figure(1);
set(h, 'Position', [200 200 800 800])

disp('Preparing plots...');
for i = 1:3
    % Left leg
    subplot(n/2,2,(i-1)*2+1)
    plot(t, plot_jointAngle(1:length,i+1))
    ylabel(joint{i})
    if i < 3
        set(gca, 'XTickLabel', [])
    end
    if i==3
        xlabel('(Left leg) time (50 ms intervals)');
    end

    % Right leg
    subplot(n/2,2,(i)*2)
    plot(t, plot_jointAngle(1:length,i+4))
    if i < 3
        set(gca, 'XTickLabel', [])
    end
    if i==3
        xlabel('(Right leg) time (50 ms intervals)');
    end
end