// Agent fernanda in project 

/* Initial beliefs and rules */
state(grave,casoconfirmado,no,9).
status(intubado).
/* Initial goals */



/* Plans */

+state(X,Y,Z,W) <-
    .send(doctor,tell,state(X,Y,Z,W));
    .print("Doctor tengo sintomas respiratorios " ,X, " estuve en contacto con ", Y, " hace " ,W, " dias.").

//regla para colocar cubrebocas
+!colocarcubrebocas[source(_)] <-
    .send(self,tell,colocarcubrebocas(boca,nariz)).