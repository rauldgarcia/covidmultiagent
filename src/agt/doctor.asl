// Agent doctor in project tarea5

/* Initial beliefs and rules */
tipodemuestra(defuncion,biopsiapulmonar).
tipodemuestra(intubado,lavadobronquioalveolar).

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

//si recibe un caso sospechoso le indica que se ponga cubrebocas
+caso(X,sospechoso)[source(self)] <- 
    .print("Lo vamos a tener que aislar.");
    .send(X,tell,aislado);
    .print("Pongase cubrebocas.");
    .send(X,achieve,colocarcubrebocas);
    .send(X,askOne,status(Y)).

//le dice al epidemiologo que le realice la prueba al paciente
// y le indica el estatus en el que esta el paciente
+status(Y)[source(X)] <-
    .send(epidemiologo,achieve,realiceprueba(X,Y));
    .print("El epidemiologo le hara la prueba de Covid.").
    
//regla para colocar cubrebocas
+!colocarcubrebocas(boca,nariz)[source(_)] <-
    .send(self,tell,colocarcubrebocas(boca,nariz)).

//se le informa al paciente el resultado de su prueba
//y se borra de las creencias que el caso era sospechoso
+caso(X,Resultado)[source(_)] <-
    .send(X,untell,caso(sospechoso));
    .send(X,tell,caso(Resultado));
    .print(X , " su prueba dio " , Resultado, ".");
    .send(self,untell,caso(X,sospechoso)).