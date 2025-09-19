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

	method energia() = energia

	method estado(){
		return if (self.esAtrapada() || !self.puedeMover()){ "gris" }
		    	else if (self.enHogar()){ "grande"  }
				else { "base" }
	}

	method puedeMover() = (energia >= self.energiaNecesaria(1) && 
						   not self.esAtrapada() )


	method estaEnRango(direccion) {
		const nuevaPosicion = direccion.siguiente(position)
		return (nuevaPosicion.x() >= 0 && 
				nuevaPosicion.y() >= 0 && 
				nuevaPosicion.x() < game.width() && 
				nuevaPosicion.y() < game.height())
	}

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

	method comerEnPosicionActual(alimento) {
		energia = energia + alimento.energiaQueOtorga()
		game.removeVisual(alimento)
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
			if (energia < self.energiaNecesaria(1)) {
				game.say(self, "Estoy cansada!")
				nivel.perder(self)
			}
		} else {
			nivel.perder(self)
		}
	}
	
	method descender() {
		if (position.y() > 0 && self.puedeMover() ) {
			position = game.at(position.x(),position.y()-1)
		}
	}

}

