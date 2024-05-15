
function D = max_directivity(p)
lambda = 1;
d = lambda/2;
k = 2*pi/lambda;
N = 10;

%Directivity calculation
f1 =  @(n,m) (p(n)*p(m))*sinc((n-m)/pi)*k*d; 
f2 =  @(n,m) (p(N-n+1)*p(N-m+1))*sinc((n-m)/pi)*k*d; 
doublesum1 = 0;
doublesum2 = 0;

for n=1:N/2
    for m=1:N/2
        doublesum1 = doublesum1  + f1(n,m);
    end
end
for n=(N/2+1):N
    for m=(N/2+1):N
        doublesum2 = doublesum2  + f2(n,m);
    end
end
D = -10*log10(k*d*(2*sum(p))^2/doublesum1+doublesum2);
end