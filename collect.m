
%%
bpresName = 'D:\willcel\测线0823\EM_singleBP\仿真结果\0823v2\';
name = [bpresName, 'rawdata'];
mkdir(name)
for i = 1:ns
    cd(['D:\willcel\测线0823\EM_singleBP\\exp_nanjing',num2str(i)])
    copyfile("res2d.dat",fullfile(name, ['res2dns',num2str(i),'.dat']))
    copyfile("err.dat",  fullfile(name,['errns',num2str(i),'.dat']))
    copyfile("log.dat",  fullfile(name,['logns',num2str(i),'.dat']))
end
fclose all;