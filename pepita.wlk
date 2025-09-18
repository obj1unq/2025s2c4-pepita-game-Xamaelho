import extras.*
import comidas.*
import niveles.*
import wollok.game.*

object paleta {
  const property rojo = "FF0000FF"
}

object pepita {
	var property position = game.at(0,1)
	var energia = 100
	const predador = silvestre
	const hogar = nido
	const joules = 9

	method image(){
        return "pepita-" + self.estado() + ".png"
    }

	method estado(){
		//(self.esAtrapada() or not self.conEnergia()){ "gris" }
		return if (self.esAtrapada() || !self.puedeMover()){ "gris" }
		    	else if (self.enHogar()){ "grande"  }
				else { "base" }
	}

	method loQueHayAca() = game.uniqueCollider(self)

	method puedeMover() = (energia >= self.energiaNecesaria(1) && 
						   not self.esAtrapada() )

	method esAtrapada() = self.estaSobre(predador)

	method enHogar() = self.estaSobre(hogar)

	method estaSobre(alguien) = position == alguien.position()
		
	method text() = "Energia: \n" + energia

	method text(mensaje) = mensaje

	method textColor() = paleta.rojo()

	method energiaNecesaria(kms) = joules * kms

	method reiniciar() {
		position = game.at(0,1)
		energia = 100
	}

	method comerEnPosicionActual() {
		energia = energia + self.loQueHayAca().energiaQueOtorga()
		game.removeVisual(self.loQueHayAca())
	}

	method volar(kms) {
		energia -= self.energiaNecesaria(kms)
	}

	method mover(direccion){
		if(self.puedeMover() ){
			if (self.estaEnRango(direccion)){
				self.volar(1)
				position = direccion.siguiente(position)
			}
			if (energia <= self.energiaNecesaria(1)) {
				game.say(self, "Estoy cansada!")
				self.perder()
			}
		} else {
			self.perder()
		}
	}

	method estaEnRango(direccion) {
		const nuevaPosicion = direccion.siguiente(position)
		return (nuevaPosicion.x() >= 0 && 
				nuevaPosicion.y() >= 0 && 
				nuevaPosicion.x() < game.width() && 
				nuevaPosicion.y() < game.height())
	}

	method perder(){
		game.say(self, "Perdiste! Presiona R para reiniciar o T para terminar")
		keyboard.r().onPressDo( {self.reset()} )
		keyboard.t().onPressDo( {self.terminar()} )
	}

	method reset() {
		nivel1.resetear()
	}

	method terminar() {
		game.schedule( 2000, { game.stop() })
	}
	
	method energia() {
		return energia
	}

}

