# Month 0
ma_0 = 0.30
mb_0 = 0.40
mc_0 = 0.30 # For simplicity define platform c as the unsubscribed users
control_0 = ma_0 + mb_0 + mc_0 # See if the sum of all platforms equals 1

# Month 1
ma_1 = ma_0 - ma_0*0.5 + mb_0*0.2 + mc_0*0.2
mb_1 = mb_0 + ma_0*0.3 - mb_0*0.8 + mc_0*0.4
mc_1 = mc_0 + ma_0*0.2 + mb_0*0.6 - mc_0*0.6
control_1 = ma_1 + mb_1 + mc_1 # After month 1 the sum should be 1 again

# Month 2
ma_2 = ma_1 - ma_1*0.5 + mb_1*0.2 + mc_1*0.2
mb_2 = mb_1 + ma_1*0.3 - mb_1*0.8 + mc_1*0.4
mc_2 = mc_1 + ma_1*0.2 + mb_1*0.6 - mc_1*0.6
control_2 = ma_2 + mb_2 + mc_2 # After month 2 the sum should be 1 again

# For matrix A creation. Each platform is a row
# Each column is a different time step
A = cbind(c(ma_0, mb_0, mc_0), c(ma_1, mb_1, mc_1), c(ma_2, mb_2, mc_2))
A