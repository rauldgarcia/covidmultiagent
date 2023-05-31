// Agent doctor in project tarea5

/* Initial beliefs and rules */
/*enfermedadrespiratoria(aguda).
enfermedadrespiratoria(leve).
enfermedadrespiratoria(grave).*/

/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("Hola.").

+enfermedadrespiratoria(X)[source(Y)] <-
    Listaenfermedadrespiratoria = [aguda,leve,grave] ;
    .member(X,Listaenfermedadrespiratoria) ;
    .send(Y,askOne,contacto(Z)) ;
    .print("¿Ha estado en contacto con alguien enfermo o bajo investigación?").

+contacto(X)[source(Y)] <-
    Listacontacto = [bajoinvestigacion,casoconfirmado];
    .member(X,Listacontacto);
    .send(Y,askOne,viaje(Z));
    .print("¿Ha viajado recientemente?").

+contacto(X)[source(Y)] <-
    Listacontacto = [bajoinvestigacion,casoconfirmado];
    .notmember(X,Listacontacto);
    .send(Y,askOne,viaje(Z));
    .print("¿Ha viajado recientemente?")
