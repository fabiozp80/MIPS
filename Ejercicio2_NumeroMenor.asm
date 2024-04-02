.data
bienvenida: .asciiz "VAMOS A COMPARAR TRES NUMEROS Y ENCONTRAR EL MENOR"       # Define una cadena de bienvenida.
captura: .asciiz "Por favor, ingrese un numero: "                              # Define una cadena que se utilizar� para pedir al usuario un n�mero.
resultado: .asciiz "El numero menor es: "                                      # Define una cadena que preceder� al resultado.
salto: .asciiz "\n"                                                            # Define una cadena para un salto de l�nea.

.text
main:
    li $v0, 4                              # Carga el c�digo de operaci�n 4 para la syscall de impresi�n de cadenas.
    la $a0, bienvenida                     # Carga la direcci�n de la cadena de bienvenida en el registro $a0.
    syscall                                # Llama al sistema para imprimir la cadena de bienvenida.

    li $v0, 4                              # Carga el c�digo de operaci�n 4 para la syscall de impresi�n de cadenas (para imprimir el salto de l�nea).
    la $a0, salto                          # Carga la direcci�n de la cadena de salto de l�nea en el registro $a0.
    syscall                                # Llama al sistema para imprimir el salto de l�nea.

    jal captura_numero                     # Salta a la funci�n captura_numero (sistema guarda la direcci�n de retorno en $ra, automaticamente).
    move $t0, $v0                          # Mueve el valor capturado en $v0 al registro $t0.
    jal captura_numero                     # Repite el proceso de captura de n�mero.
    move $t1, $v0                          # Mueve el segundo valor capturado en $v0 al registro $t1.
    jal captura_numero                     # Repite el proceso de captura de n�mero una vez m�s.
    move $t2, $v0                          # Mueve el tercer valor capturado en $v0 al registro $t2.

    blt $t0, $t1, compara_tercero          # Compara los registros $t0 y $t1; si $t0 es menor, salta a compara_tercero.
    move $t0, $t1                          # Si $t1 es meno, mueve $t1 a $t0.

compara_tercero:			   # Bloque compara_tercero para comparar el que ahora es el menor $t0 con el $t2 (tercero)
    blt $t0, $t2, muestra_resultado        # Compara $t0 con $t2; si $t0 es menor, salta a muestra_resultado.
    move $t0, $t2                          # Si $t2 es menor, mueve $t2 a $t0.

muestra_resultado:			   # Bloque muestra resultado, para mostrar en pantalla el numero que resulto es menor de los 3
    li $v0, 4                              # Carga el c�digo de operaci�n para la syscall de impresi�n de cadenas.
    la $a0, resultado                      # Carga la direcci�n de la cadena que preceder� al resultado en el registro $a0.
    syscall                                # Llama al sistema para imprimir la cadena del resultado.

    li $v0 1                               # Carga el c�digo de operaci�n para la syscall de impresi�n de enteros.
    move $a0, $t0                          # Mueve el n�mero m�s grande (ahora en $t0) al registro $a0 para imprimirlo.
    syscall                                # Llama al sistema para imprimir el n�mero m�s grande.

    li $v0, 10                             # Carga el c�digo de operaci�n para la syscall de terminaci�n del programa.
    syscall                                # Llama al sistema para terminar el programa.

captura_numero:				   # Bloque Captura n�mero, que captura un numero y lo pone en $v0
    li $v0, 4                              # Carga el c�digo de operaci�n para la syscall de impresi�n de cadenas (para imprimir la cadena de captura).
    la $a0, captura                        # Carga la direcci�n de la cadena de captura en el registro $a0.
    syscall                                # Llama al sistema para imprimir la solicitud de n�mero.

    li $v0, 5                              # Carga el c�digo de operaci�n para la syscall de lectura de enteros.
    syscall                                # Llama al sistema para leer un n�mero entero del usuario.

    jr $ra                                 # Salta de vuelta a la direcci�n almacenada en el registro de retorno $ra.
