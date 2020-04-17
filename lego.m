mylego = legoev3('usb')
mymotor = motor(mylego,'D');
mymotor1 = motor(mylego,'A');
[NUM,TXT,RAW]=xlsread('sampledleft.xls');
[NU,TX,RA]=xlsread('sampledright.xls');
start(mymotor);
start(mymotor1);
 for s=1:length(NUM)
    vl=NUM(s)*10;
    vr=NU(s)*10;
    start(mymotor);
    start(mymotor1);
    mymotor.Speed = vl;
    mymotor1.Speed = vr;
    stop(mymotor1);
    stop(mymotor);
 end
stop(mymotor1);
stop(mymotor);
clear mylego;