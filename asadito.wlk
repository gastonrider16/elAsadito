class Comensal {
	var property posicion
	var property criterioComensal
	var property criterioComida
	var property elementosCercanos = []
	var property comidas = []
	var property poneObjeciones
	method agregarElemento(elemento){
		elementosCercanos.add(elemento)
	}
	method eliminarElemento(elemento){
		elementosCercanos.remove(elemento)
	}
	method vaciarElementos(){
		elementosCercanos.clear()
	}
	method agregarVariosElementos(comensal){
		elementosCercanos.addAll(comensal.elementosCercanos())
	}
	method pasarleElemento(elemento, comensalReceptor){
		if(!comensalReceptor.elementosCercanos().contains(elemento))
			self.error("No tiene el elemento pedido")
		comensalReceptor.criterioComensal().pasarleElemento(elemento, self, comensalReceptor)
	}
	method agregarComida(comida){
		comidas.add(comida)
	}
	method comer(comida){
		self.criterioComida().comer(comida,self)
	}
	method estaPipon() = comidas.any({comida=>comida.esPesada()})
	
	method comioCarne() = comidas.any({comida=>comida.esCarne()})

	method estaPasandoBienElAsado() = 
		!comidas.isEmpty() && [osky, moni, facu, vero].all({comensal => comensal.estaPasandoloBomba()}) 
}

object sordo {
	method pasarleElemento(elemento, emisor, receptor){
		emisor.agregarElemento(receptor.elementosCercanos().first())
		receptor.eliminarElemento(emisor.elementosCercanos().first())
	}
}

object quieroComerTranquilo {
	method pasarleElemento(elemento, emisor, receptor){
		emisor.agregarVariosElementos(receptor)
		receptor.vaciarElementos()
	}
}

object quieroQueComaEnMiMesa {
	method pasarleElemento(elemento, emisor, receptor){
		emisor.posicion(receptor.posicion())
	}
}

object positivo {
	method pasarleElemento(elemento, emisor, receptor){
		emisor.agregarElemento(elemento)
		receptor.eliminarElemento(elemento)
	}
}

class Comida {
	var nombre
	var property calorias
	var property esCarne
	method esPesada() = calorias > 500 
}

object vegetariano {
	method comer(comida, persona){
		if(!comida.esCarne())
			persona.agregarComida(comida)
	}
}

object dietetico {
	method comer(comida, persona){
		if(comida.calorias()<500)
			persona.agregarComida(comida)
	}
}

object alternado {	
}

object mixto {
	method comer(comida, persona){
		if(!comida.esCarne() && comida.calorias()<500)
			persona.agregarComida(comida)
	}
}

object osky inherits Comensal {
	method estaPasandoloBomba() = !self.poneObjeciones()
}

object moni inherits Comensal {
	method estaPasandoloBomba() = self.posicion() == "1@1"
}

object facu inherits Comensal {
	method estaPasandoloBomba() = self.comioCarne()
}

object vero inherits Comensal {
	method estaPasandoloBomba() = self.elementosCercanos().size() < 3
}

//PUNTO 5
/* Use composicion para el criterio de un comensal porque
 * en cualquier momento un comensal por ejemplo puede 
 * pasar de ser sordo a positivo o alrevez. De haber 
 * usado herencia un comensal no podria cambiar su
 * criterio en tiempo de ejecución. La desventaja es que
 * el diagrama estatico sera menos bonito
 * 
 * Use composion para el criterio de una comida porque
 * un comensal por ejemplo puede ser vegetario pero 
 * luego puede cambiarlo a alternado o alreves.
 * 
 * En los objetos usados para el criterio de un comensal
 * hay una interface porque el mensaje 
 * pasarleElemento(elemento, emisor, receptor)
 * es polimorfico a la vista de la interface
 * 
 * En los objetos usados para el criterio de una comida
 * hay una interface porque el mensaje 
 * comer(comida, persona)
 * es polimorfico a la vista de la interface
 * 
 * Para los objetos osky, moni, facu, vero use herencia
 * donde la superclase es Comensal porque osky, moni,
 * facu y vero son comensales y no van a cambiar 
 * en tiempo de ejecucion lo que me permite apreciar 
 * mejor el diagrama estatico

 */
