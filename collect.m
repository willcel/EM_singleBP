
%%
bpresName = 'D:\willcel\code测线二_p1-21_0823\EM_singleBP\仿真结果\0824v1\';
name = [bpresName, 'rawdata'];
mkdir(name)
for i = 1:ns
    cd(['D:\willcel\code测线二_p1-21_0823\EM_singleBP\\exp_nanjing',num2str(i)])
    copyfile("res2d.dat",fullfile(name, ['res2dns',num2str(i),'.dat']))
    copyfile("err.dat",  fullfile(name,['errns',num2str(i),'.dat']))
    copyfile("log.dat",  fullfile(name,['logns',num2str(i),'.dat']))
end
fclose all;
cd ..