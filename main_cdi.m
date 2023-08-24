%%
clc
% clear
% close all

%% 拷贝电压、电流、初值文件
% {
specName = 'code测线三_p1-25_0823';
cd( fullfile('D:\willcel\',specName,'\EM_datapre') )
path_code1 = fullfile('D:\willcel\',specName,'\EM_singleBP');
copyfile('point1set.txt',path_code1)
copyfile('point2set.txt',path_code1)
copyfile('point3set.txt',path_code1)
copyfile('point4set.txt',path_code1)
copyfile('vobs_20ms.txt',path_code1)  

copyfile('rho_pro_tunnel_20ms.txt',path_code1)  
copyfile('dep_pro_tunnel_20ms.txt',path_code1)  
cd(path_code1)

%}

%% ---------------------- 参数设置 ----------------------------------

%% 数据预处理的参数

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
