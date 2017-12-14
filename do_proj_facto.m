function [R,S,Q] = do_proj_facto(c)     %% c in Mx2xN form

N = size(c,3); %% Number of frames
M = size(c,1); %% Number of points

W = zeros(2*N,M); %% Defining the measurement matrix

c = c - mean(c);  %% mean shift

i = 1;
for j = 1:N
W(i,:) = c(:,1,j)';     %% construct the measurement matrix: 
W(i+1,:) = c(:,2,j)';
i = i + 2;
end

[~,~,Wt] = do_facto(W);      %%% Do the factorization
[R,S,~] = do_facto(Wt);      %%% Do the factorization


A = [];
b = [];

for i = 1:2:2*N
    r1 = R(i,:);
    r2 = R(i+1,:);
    
    A = [A; (r1(1))^2, 2*r1(2)*r1(1),2*r1(1)*r1(3),(r1(2))^2,(r1(3))^2,2*r1(2)*r1(3); (r2(1))^2, 2*r2(2)*r2(1),2*r2(1)*r2(3),(r2(2))^2,(r2(3))^2,2*r2(2)*r2(3); (r2(1)*r1(1)), r2(2)*r1(1) + r1(2)*r2(1), r2(1)*r1(3) + r2(3)*r1(1), r2(2)*r1(2) , r2(3)*r1(3), r2(2)*r1(3)+r2(3)*r1(2);];      %% Solving for A (a symmetric matrix)
    b = [b; 1;1; 0];
    
end

x = A\b;        %%%% Determining A
AA = [x(1) x(2) x(3); x(2) x(4) x(6); x(3) x(6) x(5)]; %%% Determining A (symmetric positive definite)
Q = chol(AA,'lower');       %%% Cholesky Factorization

R = R*Q;                %% Fixing ambiguities in the orientations (rotations) and 3D locations
S = Q\S;
S = S';

end

function [R,S,Wt] = do_facto(W)         %%%% Do factorization

[U,D,V] = svd(W);
Wt = U(:,1:3)* (D(1:3,1:3)) * V(:,1:3)'; %%% Keeping all values corresponding to the 3 largest eigenvalues of D
R = U(:,1:3)* (D(1:3,1:3))^(0.5);
S = ((D(1:3,1:3))^(0.5))*V(:,1:3)';
end
%  conj(a11)*(a11*(q1*conj(q1) + q2*conj(q2) + q3*conj(q3)) + a12*(q4*conj(q1) + q5*conj(q2) + q6*conj(q3)) + a13*conj(q3)) + conj(a12)*(a11*(q1*conj(q4) + q2*conj(q5) + q3*conj(q6)) + a12*(q4*conj(q4) + q5*conj(q5) + q6*conj(q6)) + a13*conj(q6)) + conj(a13)*(a13 + a11*q3 + a12*q6)
