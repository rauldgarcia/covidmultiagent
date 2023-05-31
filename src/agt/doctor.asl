// Agent doctor in project tarea5

/* Initial beliefs and rules */


/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("Hola.").

//si la enfermedad respiratoria esta en la lista pregunta si tuvo contacto con alguien
//si la enfermedad no esta en la lista le indica que es caso no sospechoso
//y agrega a sus creencias que el paciente Y es caso no sospechoso
+enfermedadrespiratoria(X)[source(Y)] <-
    Listaenfermedadrespiratoria = [aguda,leve,grave];
    if (.member(X,Listaenfermedadrespiratoria))
    {
        .send(Y,askOne,contacto(Z));
        .print("¿Ha estado en contacto con alguien enfermo o bajo investigación?");
    }
    else
    {
        .send(Y,tell,caso(nosospechoso));
        .send(self,tell,caso(Y,nosospechoso));
        .print("Usted no es caso sospechoso");
    }.

//si el contacto es peligroso pregunta hace cuantos dias fue
//si el contacto no es peligroso pregunta si viajo a un pais con contagio local
+contacto(X)[source(Y)] <-
    Listacontacto = [bajoinvestigacion,casoconfirmado];
    if (.member(X,Listacontacto))
    {
        .send(Y,askOne,dias(Z));
        .print("¿Hace cuantos días?");
    } 
    else 
    { 
        .send(Y,askOne,viaje(W));
        .print("¿Ha viajado a algún pais?");
    }.

//si viajo a un pais con contagio local pregunta hace cuantos dias fue
//si no viajo a un pais con contagio local indica que no es caso sospechoso
//y agrega a sus creencias que el paciente Y es caso no sospechoso
+viaje(X)[source(Y)] <-
    Listapaises = [china,hongkong,coreadelsur,japon,italia,iran,singapur];
    if (.member(X,Listapaises))
    {
        .send(Y,askOne,dias(Z));
        .print("¿Hace cuantos días?");
    }
    else 
    {
        .send(Y,tell,caso(nosospechoso));
        .send(self,tell,caso(Y,nosospechoso));
        .print("Usted no es caso sospechoso");
    }.

//si el contacto o el viaje fueron menor a 15 dias es caso sospechoso
//si no es caso no sospechoso
//y agrega a sus creencias si es o no caso sospechoso
+dias(X)[source(Y)] <-
    if (X < 15)
    {
        .send(Y,tell,caso(sospechoso));
        .send(self,tell,caso(Y,sospechoso));
        .print("Usted es caso sospechoso");
    }
    else
    {
        .send(Y,tell,caso(nosospechoso));
        .send(self,tell,caso(Y,nosospechoso));
        .print("Usted no es caso sospechoso");
    }.
