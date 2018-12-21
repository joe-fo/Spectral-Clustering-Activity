clear;
close all;

%% Load and plot dataset

load data_Spiral.mat

k = 3; % Number of classes (also number of clusters)
X = D(:, 1); % X values of dataset
Y = D(:, 2); % Y values of dataset
labels = L; % Labels of different classes

% Colors for plotting the dataset
colors = [0,0,0 ; 1,0,0 ; 0,1,0];

figure
scatter(X, Y, 20, colors(labels, :));
title("Original Dataset")

%% K-means clustering

% km are the labels produced by the k-means clustering
km = kmeans([X, Y],k);

figure
scatter(X, Y, 20, colors(km, :));
title("k-means")

%% Create the adjacency matrix

% FILL IN THIS VALUE
epsilon = 0; % Configuration parameter for adjacency matrix

A = zeros(size(X,1), size(Y,1));
for i = 1:size(X)
    for j = 1:size(Y)
        A(i, j) = (X(i)-X(j))^2 + (Y(i)-Y(j))^2; % Calculate distance between every pair of points
    end
end

% Threshold the distances for creating the adjacency matrix
A(A <= epsilon) = 1;
A(A > epsilon) = 0;

% Create degree matrix from adjacency matrix
D = zeros(size(A,1));
for i=1:size(A,1)
    D(i,i) = sum(A(i,:));
end

% Graph the connections made in the adjacency matrix
figure
gplot(A,[X,Y],'-*');
title("Adjacency Matrix");


%% Spectral Clustering

% Calculate the Laplacian Matrix
Lap = D - A;

% Calculate SVD
[U, S, V] = svd(Lap);

% FILL IN THIS LINE
eigenvectors = 0; 

% Cluster these eigenvectors using k-means
spec_labels = kmeans(eigenvectors,k);

% Plot the resulting clusters
figure
scatter(X, Y, 20, colors(spec_labels, :));
title("spectral clustering using SVD")
