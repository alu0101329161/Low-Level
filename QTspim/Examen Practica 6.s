#JOSEPH GABINO RODRIGUEZ

.data		# directiva que indica la zona de datos
titulo1:	.asciiz	"Introduzca el primer operando en flotante: \n"
titulo2:	.asciiz	"Introduzca el segundo operando en flotante: \n"

    .text		# directiva que indica la zona de código	
	
suma:
    #recibe 2 operando en $f1 y en $f2 y devuelve el resultado en $f6
    add.s $f0,$f1,$f2                       #guardo en $f0 el resultado
	addi $sp, $sp,-4                        #dejo hueco en la pila
	
	jr $ra                                  #acaba la funcion suma
	
solicita:

   #solicita por consola 2 flotantes
   la	$a0,titulo1                         #pido el primer operando
   li	$v0,4
   syscall
   
   li  $v0,6                                #leo el primer operando por teclado  y lo guardo $a0          
   syscall
   mov.s $f1,$f0
   
   la	$a0,titulo2                         #pido el segundo operando
   li	$v0,4
   syscall
   
   li  $v0,6                                #leo el segundo operando por teclado y lo guardo en $a1          
   syscall
   mov.s $f2,$f0
	
   sw $ra,4($sp)                           #meto $ra
   jal suma                                #hago una llamada a la funcion que suma los operandos y me devuelve el resultado
   lw $ra,0($sp)                           #recupero el valor de la suma
   
	#hago lass comparaciones para que devuelva un 1 si el resultado es mayor que cada operando
	#hago las comparaciones para que devuelva un 0 si el resultado en menor que cada operando
	c.eq.s
	bc1t    ,
	
	
	
	jr $ra                                  #acaba la funcion solicita
	
	
main: #hago un bucle hasta que devuelva un 0 (resultado menor que cada operando

do:
    jal solicita
	beq $t0,1,do     #$cuando devuelva un 0 acaba

    li $v0,10        #Finaliza el programa
    syscall