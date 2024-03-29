clear all;
clc;
Ts=50;
[NUM,TXT,RAW]=xlsread('legolinear.xls');
[NU,T,RA]=xlsread('legoangular.xls');

R = [5.1 0 0; 0 1.938 0;0 0 1.5]; %coviarance of the noise
Q = [0.1 0 0;0 10 0;0 0 10]; % covariance of the observation noise
p = [10 0 0;0 10 0;0 0 10]; % estimate of initial state
A=[1,0,0;0,1,0;0,0,1];
xk=[0;0;0];
H = [1,0,0;0,1,0;0,0,1];
vk=0;
wk=0;
t=0:1:length(NUM);
%=0:1:length(NU);
n=zeros();
e=zeros();
b=zeros();
u=zeros();
   %disp(input);
for s=1:length(NUM)
input=[NUM(s);NU(s);xk(3)] ;
v=NUM(s);
w=NU(s);
 x = (A*xk)+ [vk*Ts*cos(xk(3)+wk*5*Ts);vk*Ts*cos(xk(3)+wk*5*Ts);Ts*wk];
    % Estimate the error covariance 
    p = A*p*A' + Q;
    % Kalman Gain Calculations
    K = (p*H')*(inv(H*p*H'+R));
  
    % Update the estimation
    if(~isempty(input)) %Check if we have an input
        x = xk + K*(input - H*xk);
    end
    xk=x;
    vk=v;
    wk=w;
    %disp(x);
    % Update the error covariance
    p = (eye(size(p,1)) - K*H)*p;
    % Save the measurements for plotting
    Kalman_Output = H*x;
   % x = [x; x(1:2)];
   % x_estimation(s)=x(2); %estimation in horizontal position
   %y_estimation(s)=x(1); %estimation in vertical position
    %j=0:.01:2*pi; %parameters of nodes  
  
  % plot(r*sin(j)+y(2),r*cos(j)+y(1),'.b'); % the actual moving mode
    b=[b v];
    u=[u w];
    n=[n x(1)];
    e=[e x(2)];
end
figure
subplot(2,2,1);
plot3(t,u,b);
xlabel('linear');
ylabel('angular');
title('lego encoders');
subplot(2,2,2);
plot3(t,e,n);
xlabel('linear');
ylabel('angular');
title(' kalman filter result');
subplot(2,2,3);
plot(t,b,t,u,t,n,t,e);
xlabel('time');
ylabel('velocity');
title('directions');
legend('linear velocity','angular veloctiy','kalman linear velocity','kalman angular velocity');

    

    