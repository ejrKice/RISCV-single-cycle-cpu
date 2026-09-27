addi x1, x0, 5  # x1= 5
addi x2, x0, 3  #x2= 3
add x3, x1, x2
sub x4, x1, x2
and x5, x1, x2
or x6, x1, x2
slt x7, x2, x1
slt x8, x1, x2
sub x9, x2, x1
slt x10, x9, x1
addi x11, x1, -3
addi x12, x0, -1
addi x13, x3, 100
sw x3 0(x0)
sw x9 4(x0)
sw x13 7(x1)
lw x14 0(x0)
lw x15 4(x0)
lw x16 7(x1)
lw x17 12(x0)
nop
nop
