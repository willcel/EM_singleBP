
%%
name = 'D:\�������06021_���ٵ���\������\0614v2\';
mkdir(name)
for i = 1:17
    ns = i;
    cd(['D:\�������06021_���ٵ���\\exp_nanjing',num2str(i)])
    copyfile("res2d.dat",fullfile(name, ['res2dns',num2str(ns),'.dat']))
    copyfile("err.dat",  fullfile(name,['errns',num2str(ns),'.dat']))
    copyfile("log.dat",  fullfile(name,['logns',num2str(ns),'.dat']))
end
fclose all;