import wollok.game.*
import pepita.*
import extras.*
import comidas.*
import direcciones.*

object nivel {
	var property nivelActual = nivel1

	method nivelActual(nuevoNivel) {
		nivelActual = nuevoNivel
	}

	method inicializar() {
		game.addVisual(nido)
		game.addVisual(silvestre)
		game.addVisual(manzana)
        game.addVisual(alpiste)
		game.addVisual(pepita)	// Ultima para que este encima
		
		keyboard.up().onPressDo( { pepita.mover(arriba) } )
		keyboard.down().onPressDo( { pepita.mover(abajo) } )
		keyboard.left().onPressDo( { pepita.mover(izquierda) } )
		keyboard.right().onPressDo( { pepita.mover(derecha) } )
		keyboard.t().onPressDo( {self.terminar()} )

		game.onCollideDo(pepita, {algo => algo.teCruzasteCon(pepita)})
		game.onTick(1800, "madurez manzana", { manzana.madurar() })

	}

	method ganar() {
		game.say(nido, "Ganaste! Presiona R para reiniciar, P para proximo nivel")
		keyboard.r().onPressDo( {nivelActual.setear()} )
		keyboard.p().onPressDo( {nivelActual.next()})
	}

	method perder(personaje) {
		game.say(personaje, "Perdiste! Presiona R para reiniciar")
		keyboard.r().onPressDo( {nivelActual.setear()} )
	}

	method terminar() {
		game.schedule( 1000, { game.stop() })
	}
}

object nivel1 {

    method setear() {
        game.clear()
		silvestre.reiniciar()
		manzana.reiniciar()
		pepita.reiniciar()
		nivel.inicializar()
		game.onTick(1800, "madurez manzana", { manzana.madurar() })
    }

	method next() {
		nivel.nivelActual(nivel2)
		nivel2.setear()
	}
}

object nivel2 {
	method setear() {
		game.clear()
		silvestre.reiniciar()
		manzana.reiniciar()
		pepita.reiniciar()
		nivel.inicializar()
		game.onTick(1000, "madurez manzana", { manzana.madurar()})
		game.onTick(800, "gravedad", { pepita.descender() })
	}

}