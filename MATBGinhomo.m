%Take 2d color map of MATBG twist angle spacial distribution and convert to
%a distribution in the necessary gate voltage values to reach moire cell
%3/4 filling

%img from: Pierce, A.T., Xie, Y., Park, J.M. et al. Unconventional sequence 
%of correlated Chern insulators in magic-angle twisted bilayer graphene. Nat. 
%Phys. 17, 1210–1215 (2021). https://doi.org/10.1038/s41567-021-01347-4

RGB = imread('graphenemap.png');
imshow(RGB)
I = rgb2gray(RGB);
figure
imshow(I)
figure;
imhist(I);

%get twist angle distribution
[intensity_counts, intensity_values] = imhist(I);
intensity_max= max(intensity_values);
normint=intensity_values/intensity_max;
angles=1.06+normint*0.02;

bar(angles, intensity_counts);
xlabel('Twist Angle (deg)');
ylabel('Counts');
title('Histogram');

%convert to full filling local carrier density, a is the lattice constant
doc2=[];
a=0.246*10^(-7);
for i=1:256
   doc2=[doc2, (8/sqrt(3))*((angles(i)/a)*(pi/180))^2];
end

doc=double(doc2);
bar(doc, intensity_counts);
xlabel('n_s (cm^{-2})');
ylabel('Counts');
title('Histogram');

%get distribution of gate voltage corresponding to 3/4 filling, e is
%electron charge, C is the approximate capacitance of the device
e=1.6*10^(-19);
C=49.23*10^(-9);
V_34=doc*e*0.75/C;
bar(V_34, intensity_counts);
xlabel('gate voltage (V)');
ylabel('Counts');
title('Histogram');

%compute average gate voltage to get to 3/4 filling
z=0;
x=0;
for i=1:256
    z=z+intensity_counts(i);
    x=x+intensity_counts(i)*V_34(i);
end
V_avg=x/z;
fprintf('average V_g to get to 3/4 filling [V]:')
disp(V_avg)
