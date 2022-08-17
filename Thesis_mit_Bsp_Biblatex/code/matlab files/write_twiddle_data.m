function [ImatFFT2,prod,Conv_mat_my] = write_twiddle_data(I,K,string1)


W=fft(eye(size(I)));
n=size(I,1);
m=size(I,2);
radius=floor(size(K,1)/2);

%[x,m,fsize]=padarrays(I,K,'valid');

Ipad=padarray(I,[0 0],0,'both');

mm=CircularExtension2D(rot90(K,2),size(Ipad,1),size(Ipad,2));
W_f=fft(eye(size(mm)));

ImatFFT2=W*Ipad*W.';
FmatFFT2=W_f*mm*W_f.';


prod=ImatFFT2.*FmatFFT2;

prod=prod'; %(adjungierte transpose+conj)

Conv_mat_my=1/n^2*(W*prod*W.')';
Conv_mat_my=Conv_mat_my(1+radius:n-radius,1+radius:n-radius);
%FFT2=ifft2(fft2(Ipad).*fft2(mm),'symmetric');
%FFT2=FFT2(1+radius:n-radius,1+radius:n-radius);
%FFT=ifft2(fft2(x).*fft2(m));
%FFT=FFT(4:27,4:27);
matconv=conv2(I,rot90(K,2),'valid');
%norm(FFT-matconv,'fro');
%norm(FFT2-matconv,'fro');
norm(Conv_mat_my-matconv,'fro');

Filter_sql=zeros(n^2,4);
k=1;
for i=1:n
    
    for j=1:n
   
        Filter_sql(k,:)=[i j real(W_f(i,j)) imag(W_f(i,j))];
        k=k+1;
    end
    
end

writematrix(Filter_sql,string1);
end

