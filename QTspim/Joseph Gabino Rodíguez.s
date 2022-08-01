
#JOSEPH GABINO RODRIGUEZ

maxdim=1000                                                           #maxima dimension de la matriz dinamica

	.data

matrix_1:	.space maxdim                                             # matrix dinamica

matrix:     .word	11, 12, 13, 21, 22, 23, 31, 32, 33, 41, 42, 43    #matriz estatica
	
nrows:		.word	4                                                 #numero de columnas   
ncols:		.word	3                                                 #numero de filas
 
msgintro_0:		 .asciiz "//PRACTICA 4. TRABAJANDO CON MATRIX //\n"
msgintro_0_1:	 .asciiz "MATRIX ESTATICA: \n"
msgintro_0_2:	 .asciiz "MATRIX DINAMICA: \n"
opciones:        .asciiz "ELIJA OPCION <0> PARA SALIR, <1> PARA INVERTIR FILA, <2> PARA INVERTIR COLUMNA O <3> PARA CARGAR UNA MATRIX DESDE TECLADO:  \n"
inv_nrows:	     .asciiz "SELECCIONE FILA [1, "
inv_ncols:	     .asciiz "SELECCIONE COLUMNA [1, "
close_1:		 .asciiz "]: "
salto:	         .asciiz "\n"
espacio:	     .asciiz "  "
opcion:	         .asciiz " opcion =  "
fila:	         .asciiz " fila =  "
columna:	     .asciiz " columna =  "
msgintro_1:	     .asciiz "INTRODUZCA EL NUMERO DE FILAS DE SU MATRIX: \n"
msgintro_2:	     .asciiz "INTRODUZCA EL NUMERO DE COLUMNAS DE SU MATRIX: \n"
msgintro_3:	     .asciiz "INTRODUZCA LOS ELEMENTOS DE LA MATRIX FILA A FILA:  \n"
fin:	         .asciiz "////////PROGRAMA FINALIZADO ////////\n "

	.text

main:
	
	la $a0,msgintro_0                 #imprimimos por pantalla la cadena msgintro_0
	li $v0,4
	syscall
	la $a0,msgintro_0_1               #imprimimos por pantalla la cadena msgintro_0_1
	li $v0,4
	syscall

    li $t2, 4                         #$t2 almaceno size=4(necesario para el desplazamiento)
	la $s0, matrix                    #direccion base matriz en s0(luefo almaceno la dinamica)

Inicio:                               #etiqueta para que  matrix dinámica repita el mismo proceso q la estatica(opcion3)
    lw $t3, ncols                     #guardar columnas en t3
	lw $t4, nrows                     #guardar filas en t4
	li $t0, 0                         #$t0 guardo indice
	
Bucle_1:	
    li $t1, 0                         #contador para ir a la siguiente fila
	
Bucle_1_2:
 #calculo desplazamiento
	mul $t5, $t3, $t0                #t0 donde esta el indice por numero de columnas y guardo en t5
	addu $t5, $t5, $t1               #t5 le sumo contador t1
	mul $t5, $t5, $t2                #t5 = t5 por 4 q es el tamaño cada elemnto
	addu $t5,$t5,$s0                 #carga el elemento segun la posicion en la q se encuentre

	lw $a0, 0($t5)                   #Imprime el elemento en ese momento a medida que avanza el bucle va imprimiendo posiciones en adelante (+4)
	li $v0, 1
	syscall

	la $a0,espacio                   #imprimimos por pantalla la cadena "___"
	li $v0,4
	syscall

	addi $t1, $t1, 1
    blt $t1, $t3, Bucle_1_2          #si t1 q es un contador es mayor que las columnas, sale

	addi $t0, $t0, 1                 #aumento contador para que avanse a la siguiente posicion 

	la $a0,salto                     #imprimimos por pantalla la cadena \n
	li $v0,4
	syscall

	blt  $t0, $t4, Bucle_1          #salta a la siguiente fila
	
#AQUI EMPIEZA EL MENU DONDE PUEDES ELEGIR LA OPCION

	li $s1,-1                      #aqui guardamos Bucle_0 

Bucle_0:  
	bge $s1, 0, comprobar1         #comprueba si la cifra introducida es mayor que 0
	b fin_1               #si la cifra no es mayor que 0 directamente saltamos al contenido del bucle

comprobar1:
	ble $s1, 3, fin_Bucle_0        #una vez comprobado que la cifra > que 0 comprobamos que sea < que 2

fin_1:
	la $a0,opciones                #imprimimos por pantalla la cadena opciones para elegir si invertir fila o columnas además de cargar una matriz
	li $v0,4
	syscall
	
	la $a0,opcion                 #imprimimos por pantalla la cadena opciones para elegir si invertir fila o columnas además de cargar una matriz
	li $v0,4
	syscall
	
	li $v0,5                       #almacena el valor de Bucle_0 en $s1
	syscall
	move $s1, $v0	
	b Bucle_0

fin_Bucle_0:
	beq $s1, 0,fin_Bucle           #si es 0 entoces salta a FIN DE PROGRAMA ya que ha mirado si es >0 o <2
	li $s2,0
	bne $s1, 1,fin_caso1           #si los valores no son iguales salta a FINCASO1

caso1:
	bge $s2, 1, comprobacion2      #comprueba si la cifra introducida es mayor que 1 para empezar a invertir fila
	b fin_2                        #si la cifra no es mayor que 1 saltamos a go

comprobacion2:
	ble $s2, $t4, fin_do           #una vez comprobado que la cifra es > que 1 comprobamos que sea < que nrows para que vuelva a preguntar

#AQUI EMPIEZA LA OPCION DE INVERTIR FILAS(opcion 1)

fin_2:
	la $a0,inv_nrows              #imprimimos inv_nrows
	li $v0,4
	syscall

	move $a0, $t4                 #imprimimos por pantalla el numero maximo de filas que hay en la matriz
	li $v0, 1
	syscall

	la $a0,close_1         
	li $v0,4
	syscall
	
	la $a0,fila     
	li $v0,4
	syscall

	li $v0,5                    #almacena la fila invertir en $s2
	syscall
	move $s2, $v0

	b caso1

fin_do:
	addi $s2, $s2, -1            #restamos para que no imprima la fila posterior

	mul $t5, $s2, $t3 
	mul $t5, $t5, $t2            #En $t5 esta el indice del primer elemento de la fila q queremos invertir

	move $t7,$t3
	addi $t7, -1
	mul $t7, $t7, $t2
	add $t7, $t7, $t5            #En $t7 esta el indice del ultimo elemento de la fila q queremos invertir

	addu $t7,$t7,$s0
	addu $t5,$t5,$s0

	div $t9, $t3, 2              #dividir t3 columnas entre 2 y almaceno en t9 para saber el limite del bucle

	li $t1, 0

Bucle_nrows:
	beq $t1, $t9, fin_caso1     #si no cumple condicion salta a etiqueta finCASO1
	lw $t6, 0($t5)
	lw $t8, 0($t7)
	sw $t6, 0($t7)
	sw $t8, 0($t5) 
	
	addi $t5, 4                  #avanzamos $t5 a la siguiente posicion de la fila
	addi $t7, -4                 #retrocedemos $t7 a la posicion anterior de la fila
	addi $t1, 1

	b Bucle_nrows

fin_caso1: 
	bne $s1, 2,fin_caso2         #si s1 distinto de 2 salta a etiqueta finCASO2

caso2:
	bge $s2, 1, comprobacion3    #comprueba si la cifra es mayor que 1

	b fin_3                      #si la cifra no es mayor que 1 directamente saltamos al contenido del do

comprobacion3:
	ble $s2, $t3, fin_do1        #una vez comprobado que la cifra es mayor que 1 comprobamos que sea menor que ncols

#AQUI EMPIEZA LA OPCION DE INVERTIR COLUMNAS(opcion 2)

fin_3:
	la $a0,inv_ncols          #imprimimos por pantalla la cadena inv_ncols
	li $v0,4
	syscall

	move $a0, $t3             #imprimimos por pantalla el numero maximo de columnas que hay en la matriz
	li $v0, 1
	syscall

	la $a0,close_1            #imprimimos por pantalla la cadena close_1
	li $v0,4
	syscall
	
	la $a0,columna      
	li $v0,4
	syscall

	li $v0,5                 #almacena la columna invertir en $s2
	syscall
	move $s2, $v0
	
	b caso2

fin_do1:
	addi $s2, $s2, -1          #para que los indices comienzen a cero sinO CAMBIA la columna posterior

	move $t5, $s2
	mul $t5, $t5, $t2
	addi $t7, $t4, -1
	
	mul $t7, $t7, $t3
	mul $t7, $t7, $t2
	add $t7, $t5, $t7
	
	addu $t7,$t7,$s0
	addu $t5,$t5,$s0
	
	div $t9, $t4, 2
	li $t1, 0

	mul $s3, $t3, $t2               #(ncols * size)=limite del bucle
	mul $s4, $s3, -1

Bucle_ncols:
	beq $t1, $t9, fin_caso2        #el límite del bucle es (ncols * size)=12 BYTES si no cumple salta a etiqueta finCASO2

	lw $t6, 0($t5)                  #intercambiar la icial por la final
	lw $t8, 0($t7)

	sw $t6, 0($t7)
	sw $t8, 0($t5)

	add $t5, $t5, $s3        
	add $t7, $t7, $s4
	addi $t1, 1

	b Bucle_ncols

fin_caso2:
	bne $s1, 3,fin_caso3        #si la opcion escogida por el usuario es 3 carga una nueva matrix dinamica
	
#MAREIX DINAMICA AL ELEGIR OPCION 3
caso3:
	la $a0,msgintro_1            #pedimos las filas de la matrix
	li $v0,4
	syscall
	
    la $a0,fila           
	li $v0,4
	syscall
	
	li $v0,5                     #almacena el numero de filas en $t4
	syscall
	move $t4, $v0

	la $a0,msgintro_2            #pedimos las columnas de la matrix
	li $v0,4
	syscall
	
	la $a0,columna          
	li $v0,4
	syscall

	li $v0,5                    #almacena el numero de columnas en $t3
	syscall
	move $t3, $v0

	mul $t5, $t3, $t4           #multiplico filas y columnas para saber el número de elementos de la matriz

	sw $t3, ncols               #guardo columnas en t3
	sw $t4, nrows               #guardo filas en t4

	li $t1, 0
	la $s0, matrix_1            #dirrecion base de matrix dinamica en s0, q anteriormente estaba la matrix estatica

	la $a0,msgintro_3           #imprimimos por pantalla la cadena msgintro_3
	li $v0,4
	syscall

	move $s2, $s0               #guardo posicion del elemento en s2 para que no coja los desplazamientos de la ultima posicion(si no salen ceros o emoticonos al cargar nueva matrix)

Bucle_2:
	bge $t1, $t5, fin_intro
	li $v0, 5
	syscall

	sw $v0, 0($s2)
	addi $s2, 4
	addi $t1,1
	b Bucle_2

fin_intro:
	la $a0,msgintro_0_2          #imprimimos por pantalla matrix dinamica:
	li $v0,4
	syscall
	
fin_caso3:
	b Inicio                     #vuelve arriba para repetir el mismo proceso de la estática con la dinámica una vez cambiados los valores de fila y columnas

fin_Bucle:
    la $a0,fin                   #imprimimos por pantalla fin
    li $v0,4
	syscall

	li $v0,10                    #acaba el código    
	syscall