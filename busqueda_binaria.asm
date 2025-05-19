
# Búsqueda binaria en MIPS ensamblador
# Asume:
# - A[] en memoria, base en $s0
# - valor a buscar en $s1
# - tamaño del arreglo en $s4
# - resultado en $s5

        addi $s2, $zero, 0      # low = 0
        addi $s3, $s4, -1       # high = n - 1

loop:   slt  $t0, $s3, $s2      # if high < low
        bne  $t0, $zero, not_found

        add  $t1, $s2, $s3      # mid = (low + high)
        srl  $t1, $t1, 1        # mid = mid / 2 (shift right)

        mul  $t2, $t1, 4        # offset = mid * 4
        add  $t3, $s0, $t2      # addr = base + offset
        lw   $t4, 0($t3)        # A[mid]

        beq  $t4, $s1, found    # if A[mid] == x
        slt  $t5, $t4, $s1      # if A[mid] < x
        bne  $t5, $zero, go_right

        addi $s3, $t1, -1       # high = mid - 1
        j loop

go_right:
        addi $s2, $t1, 1        # low = mid + 1
        j loop

found:
        add  $s5, $zero, $t1    # resultado = mid
        j end

not_found:
        addi $s5, $zero, -1     # resultado = -1

end:
        nop
