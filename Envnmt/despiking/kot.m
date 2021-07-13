function [alpha,beta,vel]=kot(vel,x,y,z)
% Function to transfer cartesian co-ordinates (velocity components into
% flow direction), i.e., maximize x-component and minimize (0) y and z-components
% Input: vel - variable with columns of c-ordinates 
%        x, y, z - number of columns  with co-ordinates
% Output: vel - variable with transferred co-ordinates
%         Attention: New co-ordinates will be written in 3 columns
%         following x, y, z-columns
alpha=atan(mean(vel(:,y))/mean(vel(:,x)));
if mean(vel(:,x))<0 && mean(vel(:,y))>=0
    alpha=alpha+pi();
elseif mean(vel(:,x))<0 && mean(vel(:,y))<0
    alpha=alpha-pi();
end
um=mean(vel(:,x))*cos(alpha)+mean(vel(:,y))*sin(alpha);
beta=atan(mean(vel(:,z))/um);
if um<0 && mean(vel(:,z))>=0
    beta=beta+pi();
elseif um<0 && mean(vel(:,z))<0
    beta=beta-pi();
end
col=[x y z]; newcol=max(col)+1;
vel(:,newcol)=vel(:,x)*cos(alpha)*cos(beta)+vel(:,y)*sin(alpha)*cos(beta)+vel(:,z)*sin(beta);
vel(:,newcol+1)=-vel(:,x)*sin(alpha)+vel(:,y)*cos(alpha);
vel(:,newcol+2)=-vel(:,x)*cos(alpha)*sin(beta)-vel(:,y)*sin(alpha)*sin(beta)+vel(:,z)*cos(beta);

