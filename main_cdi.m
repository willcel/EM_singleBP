%%
clc
clear
% close all

%% ---------------------- 参数设置 ----------------------------------

%% 数据预处理的参数

pset = [1:0.5:6 7:8];  % 测点的坐标，文件夹的名称
ns = length(pset);                  % 测点的个数


%% 数据采样
nt = 56;                        % 抽道时间
t_st = 2.02e-3;           % 起始时间          
t_ed = 20*10^(-3);       % 结束时间 

%% 反演参数
nolayer = 5;                  % 划分的层数

%% 发射参数
hr = 0.01;   % 接收线圈的高度
rt = 0.5;                 % 发射线圈的半径 m
nturn = 3;              % 线圈的匝数
rr = 0.25;               % 接收线圈的半径 m
nturn1 = 20;          % 接收线 圈的匝数
xr = 0.58;    % 中心距

%{
for j = 2:ns
    path_code1 = ['.\exp_nanjing',num2str(j),'\'];   
    mkdir(path_code1)
%     cd()
    sourcefolder = '.\exp_nanjing1';
    copyfile(sourcefolder, path_code1)
end

%}
 

% 遍历每个测点
% for i=1:ns 
% j=1;
for i= 1:ns %1:ns
    path_code1 = ['.\exp_nanjing',num2str(i),'\'];   
    if ~exist(path_code1, 'dir')
        mkdir(path_code1)
        copyfile('.\exp_nanjing1\main.f90',path_code1)
    end
    
    parameter_settings = [nt; nolayer; ns; 1; i; t_st; t_ed; xr; hr; rt;  rr; nturn; nturn1]; 
    save('parameter_settings.txt','parameter_settings','-ascii')
    
    copyfile('parameter_settings.txt',path_code1)
    
    copyfile('point1set.txt',path_code1)
    copyfile('point2set.txt',path_code1)
    copyfile('point3set.txt',path_code1)
    copyfile('point4set.txt',path_code1)
    copyfile('vobs_20ms.txt',path_code1)  
    
    copyfile('rho_pro_tunnel_20ms.txt',path_code1)  
    copyfile('dep_pro_tunnel_20ms.txt',path_code1)  

%     winopen(['.\exp_nanjing',num2str(i),'\exp_nanjing',num2str(24),'.exe'])   % 运行fortran程序
    ;
    j=j+1;
end
