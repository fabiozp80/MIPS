.data
bienvenida: .asciiz "==VAMOS A CALCULAR n NUMEROS DE LA SERIE FIBONACCI=="  # Define una cadena de bienvenida.
entrada: .asciiz "Ingrese el numero de elementos para la serie de Fibonacci: "  # Define una cadena que se utilizará para pedir al usuario el número que sera el n.
elementos: .asciiz "\nLos nuemeros Fibonacci son: "   # Define la cadena para presentar los elementos fibonacci calculados
separador: .asciiz ", "  # Define la cadena para los numeros

.text
.globl main


main:
    li $v0, 4              # Carga el código de operación 4 para la syscall de impresión de cadenas.
    la $a0, bienvenida     # Carga la dirección de la cadena de bienvenida en el registro $a0.
    syscall                # Llama al sistema para imprimir la cadena de bienvenida.
    
    # Imprime la entrada y lee el número n
    li $v0, 4              # syscall para imprimir cadena
    la $a0, entrada         # Carga la dirección del prompt
    syscall                # Realiza la syscall

    li $v0, 5              # syscall para leer un entero
    syscall                # Realiza la syscall
    move $a1, $v0          # Mueve el valor leído (n) a $a1

    # Verifica que el numero sea mayor que 0, si es menor que 1, se procede a finalizar el programa
    blt $a1, 1, fin        # Si n < 1, salta al final

    # Inicializa los dos primeros números de la serie de Fibonacci
    li $t0, 0              # t0 = 0, primer número de Fibonacci
    li $t1, 1              # t1 = 1, segundo número de Fibonacci

    li $v0, 4              # Carga el código de operación 4 para la syscall de impresión de cadenas.
    la $a0, elementos      # Carga la dirección de la cadena de presentacion de elementos 'elementos'
    syscall

    # Imprime el primer número de la serie
    li $v0, 1              # syscall para imprimir entero
    move $a0, $t0          # Prepara t0 para imprimir
    syscall                # Imprime t0
    
    jal coma_separador     # Imprime el separador ', '

    li $a3, 1              # Inicializa contador de ciclo en 1
    j bucle_condicion      # Salta directamente a la condición del bucle

# Bucle que se va a ejecutar por cada paso desde 1 hasta n
bucle:
    add $t2, $t0, $t1      # t2 = t0 + t1, calcula el próximo número de Fibonacci
    move $t0, $t1          # Actualiza t0 con el valor de t1
    move $t1, $t2          # Actualiza t1 con el valor de t2 (nuevo número de Fibonacci)

    move $a0, $t2          # Prepara el número de Fibonacci actual para imprimir
    li $v0, 1              # syscall para imprimir entero
    syscall                # Imprime el número de Fibonacci actual
    
    addi $a3, $a3, 1       # Incrementa el contador del bucle
    
    beq $a3, $a1, fin      # Si a3 ya alcanzo n, entonces sale para no imprimir el ultimo separador
    
    jal coma_separador     # Salta a imprimir el separador ', '

# Evaluador si aun se esta dentro del bucle
bucle_condicion:
    blt $a3, $a1, bucle    # Si aún no hemos alcanzado n (a3 < n), repite el bucle

# Final del programa
fin:
    li $v0, 10             # syscall para terminar el programa
    syscall                # Termina el programa
    
# Impresor del separador ', '
coma_separador:
    li $v0, 4              # Carga el código de operación 4 para la syscall de impresión de cadenas.
    la $a0, separador      # Carga la dirección de la cadena del separador ', '
    syscall		   # Imprime el separador
    jr $ra		   # regresa a la direccion almacenada en ra