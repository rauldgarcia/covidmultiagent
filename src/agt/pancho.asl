// Agent paciente in project tarea5

/* Initial beliefs and rules */
enfermedadrespiratoria(aguda).
contacto(no).
viaje(china).
dias(10).
status(normal).



/* Initial goals */

//!start.

/* Plans */

//le informa al doctor que tiene tiene enfermedad respiratoria
+enfermedadrespiratoria(X) : true <- 
    .send(doctor,tell,enfermedadrespiratoria(X));
    .print("Doctor tengo enfermedad respiratoria " , X , ".").

//si se le pide que se ponga cubrebocas pregunta como
//una vez que sabe como lo ejecuta
+!colocarcubrebocas[source(X)] :true <-
    .send(X,askHow, {+!colocarcubrebocas(_,_)[source(_)]});
    .print("¿Como se coloca el cubrebocas?");
    .wait(1);
    .print("Se coloca: ");
    .list_plans({+!colocarcubrebocas(_,_)[source(_)]});
    .print;
    .send(self,achieve,colocarcubrebocas(_,_)[source(_)]).

