maxdim = 250    #guarda el tamaño de la cadena en 
.data
cadena: 	.asciiz "Practica 5 de Principios de Computadores. Quedate en casa!!"
cadena2:	.asciiz "roma tibi subito m otibus ibit amor"
cadtiene:	.asciiz " tiene "
cadcarac:	.asciiz " caracteres.\n"
cadespal:	.asciiz "Es palíndroma.\n\n"
cadnoespal:	.asciiz "No es palíndroma.\n\n"
Finpro:	    .asciiz "\n\n//////Fin Programa////////"
Iniinpro:	.asciiz "//////Bienvenido al programa////////\n\n"
cadena3:      .asciiz "\nIntroduzca una cadena: "
cadleida:     .space maxdim
cadinv_:      .space maxdim
cadres:       .asciiz "\nLa cadena invertida es: "
	.text

strlen:  # numero de caracteres que tiene una cadena sin considerar el '\0'   ->(Hago un do while con un contador vaya sumando cuando al leer un caracter de la cadena
		 # la cadena tiene que estar terminada en '\0'                        si es distinto de 0 suma 1 a un contador) (• bne(“branch if not equal”)
		 # $a0 tiene la direccion de la cadena                                lb y sb sw y lw
		 # $v0 devuelve el numero de caracteres
         #guardo la direccion en $t3
move $t3,$a0 
li $v0,0
do:      
    lb $t0,0($t3)
	addi $t3,$t3,1  #aumento en 1 para que vaya avanzando en la cadena
	beqz $t0,fin
    addi $v0,$v0,1  #aumento contador si es idstinto de cero
	j do
fin:  
jr $ra #retorna el valor de $v0

reverse_r:  # funcion que da la vuelta a una cadena                   ->Meto los caracteres en la pila y los saco             
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
            # $v0 1 Si es palíndroma 0 si no lo es
			
bgt $t4,0,Fin_1
    li $s4,1                             #lo uso para restar o sumar
    li $v0,1                             #asumo q es palindroma
    move $t1,$a1	                     #guardo los argumentos en temporales 
	move $t6,$a0 
	move $t3,$a0
	addi $t4,$t4,1                       #solo entro una vez al bucle
Fin_1:
    bgt $t1,0,meter     #miro si es mayor que cero
    jr $ra               #si no es mayor q cero entonces retornamos
meter:
    lb $t5,0($t6)                 #cargamos un carcater en $t5
	addi $sp, $sp, -8             #el puntero sp avanza
	sw $ra, 4($sp)                #guardo la dirreccion abajo
    sb $t5, 0($sp)                #guardo en el top el caracter
	   
	add $t6,$t6,$s4               #avanzamos la dirrecion 
	sub $t1,$t1,$s4               #disminuimos tamaño

    jal reverse_r
	
	lb $t4,0($t3)                 #primer caracter   
	lb $t5,0($sp)                 #cargamos ultimo caracter de la pila

    beq $t5, $t4,cumplecon        #mira si son iguales
	move $v0,$zero                #si no son iguales carga en $v0 el cer para decir q no es palindroma  
	
cumplecon:
	sb $t5,0($t3)                 #metemos el caracter en la primera posicion 
	lw $ra,4($sp)                 #cargamos valor de ra y lo guardo en ra para hacer retorno bien
	addi $sp, $sp,8               #libero espacio de la pila
	addi $t3,$t3,1
    jr $ra

reverse:    # funcion que da la vuelta a una cadena sin tener que usar strlen antes para saber la longitud                               
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 guarda la cadena dada la vuelta
	li $s4,1
do3:
    lb $t2, ($a0)                         #Leo un caracter de la cadena origen
    beqz $t2, desapila                    #Si es el fin de cadena, he acabado de leer
    sub $sp, $sp,$s4                      #Apilo el caracter en la pila
    sb $t2, ($sp)
    add $t1, $t1,$s4                      #Cuento que he apilado un caracter mas
    add $a0, $a0,$s4                      #Actualizo
    b do3
desapila:
    #Ya he apilado toda la cadena, la desapilo y la voy guardando en la cadena destino 
    lb $t2, ($sp)                         #Desapilo una letra de la pila
    add $sp, $sp, $s4
    sb $t2, ($a1)                         #La guardo en la cadena de destino
    add $a1, $a1,$s4                      #Actualizo la cadena de destino
    sub $t1, $t1,$s4                      #Ya he leido una letra
    bnez $t1, desapila                    #Mientras me queden letras apiladas, sigo desapilando
    sb $zero, ($a1)                       #Al final, almaceno el caracter fin de cadena
    jr $ra 

reverse_i:  # funcion que da la vuelta a una cadena                                    
			# $a0 cadena a la que hay que dar la vuelta
			# $a1 numero de caracternes que tiene la cadena
			# $v0 1 Si es palíndroma 0 si no lo e
	li $v0,1                      #asumo q es palindroma
	move $t0,$a0
	add $t1,$t0,$a1
	sub $t0,$t0,1
do1:
	addi $t0,$t0,1
	sub $t1,$t1,1
	lb $t2,0($t0)                #intercambio las posiciones inicial y final
	lb $t5,0($t1)
	sb $t5,0($t0)
	sb $t2,0($t1)
	beq $t2,$t5,cumplecon1       #si no son iguales no es palindroma
	li $v0,0                     #por tanto cargo un 0
	
cumplecon1:
	sub $t7,$t1,$t0
	bgt $t7,1,do1
	jr $ra

main:
# INTRODUCE AQUÍ EL CÓDIGO DE LA FUNCIÓN main QUE REPRODUZCA LA SALIDA COMO EL GUIÓN
# INVOCANDO A LA FUNCIÓN strlen DESPUÉS DE CADA MODIFICACIÓN DE LAS CADENAS
#Aqui viene la version recursiva con la cadena 1

    la $a0,Iniinpro                        #Iniciamos el programa
	li $v0,4
	syscall	

	la $a0,cadena                        #imprimimos por pantalla la cadena
	li $v0,4
	syscall	
	
	la $a0,cadtiene                      #imprimimos por pantalla la cadena tiene
	li $v0,4
	syscall
	
	la $a0,cadena                        #cargo la direccion de la cadena 
	jal strlen                           #llamamos a la funcion que cuenta el numero de caracteres y nos devuelve $v0 con los caracteres
	
	move $a1,$v0                         #ya que esta funcio trabaja con $a1 donde se guardan el numero de caracteres
	move $a0,$v0                         #muevo a $a0 para poder imprimir
	li $v0,1
	syscall                          
	
	la $a0,cadcarac                      #imprimimos por pantalla la cadena caracteres
	li $v0,4
	syscall
	
	#Inicializo los valores para despues llamar a la funcion reverse_r
	la $a0,cadena                        #vuelvo a guardar la dirrecion de $a0
	#$a1 tiene el numero de caracteres
	
	jal reverse_i                        #cadena inversa y palindroma o no
	move $s0,$v0 
	
	move $a0,$t3
    la $a0,cadena                        #imprimimos por pantalla la cadena inversa
	li $v0,4
	syscall	
	
	la $a0,cadtiene                      #imprimimos por pantalla la cadena tiene
	li $v0,4
	syscall

    la $a0,cadena                       #cargo la direccion de la cadena 
	jal strlen
	move $a0,$v0
	li $v0,1
	syscall
	 
	la $a0,cadcarac                     #imprimimos por pantalla la cadena caracteres
	li $v0,4
	syscall
	
	beq $s0,$zero,noloes                #mira si el retorno de la funcion es igual a cero
	
	la $a0,cadespal                     #imprimimos por pantalla es palindroma
	li $v0,4
	syscall	
	
	j salto
	
noloes:
    la $a0,cadnoespal                   #imprimimos por pantalla No es palindroma
	li $v0,4
	syscall	
	
salto:	
#aqui viene la version iterativa con la cadena 2

    la $a0,cadena2                       #imprimimos por pantalla la cadena
	li $v0,4
	syscall
	
	la $a0,cadtiene                      #imprimimos por pantalla la cadena tiene
	li $v0,4
	syscall
	
	la $a0,cadena2                       #cargo la direccion de la cadena 
	jal strlen                           #llamamos a la funcion que cuenta el numero de caracteres y nos devuelve $v0 con los caracteres
    move $a1,$v0                         #ya que la uso despues para la funcion iterativa
	move $a0,$v0                         #muevo a $a0 para poder imprimir
	li $v0,1
	syscall  

    la $a0,cadcarac                      #imprimimos por pantalla la cadena caracteres
	li $v0,4
	syscall	
	
	la $a0,cadena2   
	jal reverse_r                        #cadena inversa y palindroma o no
	move $s1,$v0 
	
	move $a0,$t3
    la $a0,cadena2                       #imprimimos por pantalla la cadena inversa
	li $v0,4
	syscall	
	
	la $a0,cadtiene                      #imprimimos por pantalla la cadena tiene
	li $v0,4
	syscall

    la $a0,cadena2                       #cargo la direccion de la cadena 
	jal strlen
	move $a0,$v0
	li $v0,1
	syscall
	 
	la $a0,cadcarac                      #imprimimos por pantalla la cadena caracteres
	li $v0,4
	syscall
	
	beq $s1,$zero,noloes1                #mira si el retorno de la funcion es igual a cero
	
	la $a0,cadespal                      #imprimimos por pantalla es palindroma
	li $v0,4
	syscall	
	
	j salto1
	
noloes1:
    la $a0,cadnoespal                   #imprimimos por pantalla No es palindroma
	li $v0,4
	syscall	
	
salto1:
	#$a0 tiene la dirrecion y $a1 tiene la longitud
    la $a0, cadena3                              #pide una cadena
	li $v0, 4 
    syscall
 
    la $a0, cadleida                             # con maxdim
    li $a1, maxdim                               #Longitud maxima de la cadena leida
	li $v0, 8                                   
    syscall
 
    la $a0, cadleida                            #cargo la cadena leida
    la $a1, cadinv_                             
    jal reverse
 
    la $a0, cadres                              # imprime por pantalla
	li $v0, 4                                 
    syscall
 
    la $a0, cadinv_                            
	li $v0, 4                                   #imprimir una cadena(la inversa)
    syscall
    
    la $a0,Finpro                               #imprimimos por pantalla la cadena
	li $v0,4
	syscall
 
	li $v0,10                                   #acaba el código    
	syscall