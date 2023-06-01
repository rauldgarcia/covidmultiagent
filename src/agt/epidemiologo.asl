// Agent epidemiologo in project 

/* Initial beliefs and rules */
// tipos de muestra dependiendo el estatus del paciente
tipodemuestra(normal,exudadonasofaringeoyfaringeo).
tipodemuestra(defuncion,biopsiapulmonar).
tipodemuestra(intubado,lavadobronquioalveolar).

/* Initial goals */

//!start.

/* Plans */

//+!start : true <- .print("hello world.").

//cuando el doctor le dice que le realice la prueba al paciente X
//con el estatus Y, revisa en sus creencias
//que tipo de prueba le corresponde
+!realiceprueba(X,Y)[source(doctor)] <-
    ?tipodemuestra(Y,Z);
    .print("La prueba de " , X ," sera " , Z , ".");
    .send(self,tell,prueba(X,Y,Z));
    .send(self,achieve,prueba(X,Y,Z)).

//suponemos que la prueba da positiva
//elimina de sus creencias que tipo de prueba hara
//y guarda que tipo de prueba fue y el resultado
//y le informa al doctor que la prueba fue positiva 
+!prueba(X,Y,Z)[source(_)] <-
    .send(self,untell,prueba(X,Y,Z));
    .send(self,tell,prueba(X,Y,Z,positiva));
    .send(doctor,tell,caso(X,positivo)).