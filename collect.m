
%%
name = 'D:\0628wks\EM_singleBP\·ÂÕæ½á¹û\0629v2\';
mkdir(name)
for i = 1:23
    ns = i;
    cd(['D:\0628wks\EM_singleBP\\exp_nanjing',num2str(i)])
    copyfile("res2d.dat",fullfile(name, ['res2dns',num2str(ns),'.dat']))
    copyfile("err.dat",  fullfile(name,['errns',num2str(ns),'.dat']))
    copyfile("log.dat",  fullfile(name,['logns',num2str(ns),'.dat']))
end
fclose all;