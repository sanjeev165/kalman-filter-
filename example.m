clear all;
clc;
Ts=50;
[NUM,TXT,RAW]=xlsread('legolinear.xls');
[NU,TXT,RAW]=xlsread('legoangular.xls');

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
    plot(x(2),x(1),'*');
    xlabel('linear');
    ylabel('angular');
    title('linearvelocity');
    
    hold on;
    grid on;% the kalman filtered tracking node
    pause(0.01) %speed of loading frame
    n=[n x(1)];
    e=[e x(2)];
end
figure
plot(e,n,'*');
xlabel('linear');
ylabel('angular');
title('linearvelocity');
    

