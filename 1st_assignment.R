# Create Graphs
# library(igraph)
#subscriptions = graph( edges=c("A","A", "B","B", "C","C", "A","B", "A","C", "B","A", "B", "C"))
#subscriptions$weights = c() 

# x_y shows transition from platform x to y
# For simplicity define platform C as the unsubscribed users
a_a = 0.5
a_b = 0.3
a_c = 1 - a_a - a_b
b_a = 0.2
b_b = 0.2
b_c = 1 - b_a - b_b
c_a = 0.2
c_b = 0.4
c_c = 1 - c_a - c_b

## Construct matrix A describing the flow trainsition
# Each platform is a row. Each column is a different time step
A = rbind(c(a_a, a_b, a_c), c(b_a, b_b, b_c), c(c_a, c_b, c_c))
rownames(A) = c( "A","B","C")
colnames(A) = c("A","B", "C")
A

## Now use the Spectram Theorem from class
E = eigen(A) # Compute eigenvalues & eigenvectors
ew = E$values # Store eigenvalues of A
ew

D = diag(ew) # Create diagonal matrix containing eigenvalues
D

U = E$vectors # Store eigenvectors of A
U

U_inv = solve(U)
orth = round(U_inv %*% U,digits=0) # Check that eigenvectors are orthogonal
orth

# Reconstruct matrix A using the eigenvalue decomposition
B = round(U %*% D %*% U_inv,2) # Reconstruct matrix 
B == A ## Check if our decomposed matrix equals matrix A

## Define starting point u0 (Initial market shares)
u0 = c(0.30, 0.40, 0.30)

# Define function to compute u_k (transition for kth month)
Compute_uk = function(k,u0,U,D,U_inv) {
  return(U %*% (D^k) %*% U_inv %*% u0)
}

u_1 = Compute_uk(1, u0, U, D, U_inv) # Market shares after one month
u_1

u_2 = Compute_uk(2, u0, U, D, U_inv) # Market shares after two months
u_2

u_3 = Compute_uk(3, u0, U, D, U_inv) # Market shares after three months
u_3

c = U_inv %*% u0 # Equation taken from the live class to later compute u_inf
c

## Compute the steady state market
u_inf = c[1]*U[,1]
u_inf 

# Define method to compute difference between a given month and steady market
Compute_diff = function(u_k, u_inf) {
  return(u_k - u_inf)
}

diff_1 = Compute_diff(u_1, u_inf)
diff_1

diff_2 = Compute_diff(u_2, u_inf)
diff_2

diff_3 = Compute_diff(u_3, u_inf)
diff_3

# Conclusions: The steady market is closed to be reached after the first month.
# For the following months the difference becomes slightly smaller but without huge improvement.