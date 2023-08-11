%%
clc
clear
% close all

%% ---------------------- �������� ----------------------------------

%% ����Ԥ����Ĳ���

pset = [1:0.5:6 7:8];  % �������꣬�ļ��е�����
ns = length(pset);                  % ���ĸ���


%% ���ݲ���
nt = 56;                        % ���ʱ��
t_st = 2.02e-3;           % ��ʼʱ��          
t_ed = 20*10^(-3);       % ����ʱ�� 

%% ���ݲ���
nolayer = 5;                  % ���ֵĲ���

%% �������
hr = 0.01;   % ������Ȧ�ĸ߶�
rt = 0.5;                 % ������Ȧ�İ뾶 m
nturn = 3;              % ��Ȧ������
rr = 0.25;               % ������Ȧ�İ뾶 m
nturn1 = 20;          % ������ Ȧ������
xr = 0.58;    % ���ľ�

%{
for j = 2:ns
    path_code1 = ['.\exp_nanjing',num2str(j),'\'];   
    mkdir(path_code1)
%     cd()
    sourcefolder = '.\exp_nanjing1';
    copyfile(sourcefolder, path_code1)
end

%}
 

% ����ÿ�����
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

%     winopen(['.\exp_nanjing',num2str(i),'\exp_nanjing',num2str(24),'.exe'])   % ����fortran����
    ;
    j=j+1;
end
