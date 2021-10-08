library(igraph)

# For simplicity define platform C as the unsubscribed users
subscriptions = graph( edges=c("A","A", "B","B", "C","C", "A","B", "A","C", "B","A", "B", "C"))
#subscriptions$weights = c() 

# x_y shows transition from platform x to y
a_a = 0.5
a_b = 0.3
a_c = 1 - a_a - a_b
b_a = 0.2
b_b = 0.2
b_c = 1 - b_a - b_b
c_a = 0.2
c_b = 0.4
c_c = 1 - c_a - c_b

# Construct matrix A describing the flow trainsition
# Each platform is a row. Each column is a different time step
A = rbind(c(a_a, a_b, a_c), c(b_a, b_b, b_c), c(c_a, c_b, c_c))
rownames(A) = c( "A","B","C")
colnames(A) = c("A","B", "C")
A

## Now use the Spectram Theorem from class
e = eigen(A) # Compute eigenvalues & eigenvectors
ew = e$values # Store eigenvalues of A
ew

D = diag(ew) # Create diagonal matrix containing eigenvalues
D

U = e$vectors # Store eigenvectors of A
U

U_inv = t(U)  # Assumtion taken since U is symmetric

orth = round(U_inv %*% U,digits=0) # Check that eigenvectors are orthogonal
orth

# Reconstruct matrix A using the eigenvalue decomposition
B = U %*% D %*% U_inv # Reconstruct matrix A = B
B
A
