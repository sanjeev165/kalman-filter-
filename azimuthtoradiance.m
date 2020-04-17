[NUM,TXT,RAW]=xlsread('timeofazimuth.xls');
[NU,TX,RA]=xlsread('azimuth.xls');
 a=0;
 t=0;
 f=zeros();
for s=1:length(NUM)
    degrees=(a-NU(s))/(t-NUM(s));
    radians = degrees * 0.017453;
    a=NU(s);
    t=NUM(s);
    f=[f radians];
end