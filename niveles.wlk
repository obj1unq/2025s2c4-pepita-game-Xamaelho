import wollok.game.*
import pepita.*
import extras.*
import comidas.*
import direcciones.*

object nivel1 {
	method inicializar() {
		game.addVisual(nido)
		game.addVisual(silvestre)
		game.addVisual(manzana) // Como poner varias manzanas ubicadas en lugares distintos
        game.onTick(2500, "madurez manzana", { manzana.madurar() })
        game.addVisual(alpiste)
		game.addVisual(pepita)	// Ultima para que este encima
		
		keyboard.up().onPressDo( { pepita.mover(arriba) } )
		keyboard.down().onPressDo( { pepita.mover(abajo) } )
		keyboard.left().onPressDo( { pepita.mover(izquierda) } )
		keyboard.right().onPressDo( { pepita.mover(derecha) } )
		keyboard.c().onPressDo( { pepita.comerEnPosicionActual()} )

	}
    method resetear() {
        game.clear()
		self.inicializar()
		pepita.reiniciar()
		silvestre.reiniciar()
		manzana.reiniciar()
    }
}