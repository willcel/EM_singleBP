
%%
name = 'D:\0628wks\����2\EM_singleBP\������\0630v1\';
mkdir(name)
for i = 1:28
    ns = i;
    cd(['D:\0628wks\����2\EM_singleBP\\exp_nanjing',num2str(i)])
    copyfile("res2d.dat",fullfile(name, ['res2dns',num2str(ns),'.dat']))
    copyfile("err.dat",  fullfile(name,['errns',num2str(ns),'.dat']))
    copyfile("log.dat",  fullfile(name,['logns',num2str(ns),'.dat']))
end
fclose all;