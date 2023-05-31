// Agent paciente in project tarea5

/* Initial beliefs and rules */
enfermedadrespiratoria(aguda).
contacto(no).
viaje(china).
dias(10).

/* Initial goals */

//!start.

/* Plans */


+enfermedadrespiratoria(X) : true <- 
    .send(doctor,tell,enfermedadrespiratoria(X));
    .print("Doctor tengo enfermedad respiratoria " , X , ".").
