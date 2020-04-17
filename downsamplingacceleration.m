[NUM,TXT,RAW]=xlsread('accelerationaxisx.xls');
 e=zeros();
for s=1:length(NUM)
 
    e=[e NUM(s)];
end
y=downsample(e,5);
