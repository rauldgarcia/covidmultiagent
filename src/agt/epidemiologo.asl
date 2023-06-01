// Agent epidemiologo in project 

/* Initial beliefs and rules */
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
    .send(self,tell,prueba(X,Y,Z)).