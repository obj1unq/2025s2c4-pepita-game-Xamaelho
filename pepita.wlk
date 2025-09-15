import extras.*
import comidas.*
import wollok.game.*

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
	
	method estaEnRango() = self.position().x() < game.width() && self.position().y() < game.height()

	method esAtrapada() = self.estaSobre(predador)

	method enHogar() = self.estaSobre(hogar)

	method estaSobre(alguien) = position == alguien.position()
		
	method text() = "Energia: \n" + energia

	method textColor() = "FF0000"

	method energiaNecesaria(kms) = joules * kms

	method comer(comida) {
		energia = energia + comida.energiaQueOtorga()
	}

	method volar(kms) {
		energia -= self.energiaNecesaria(kms)
	}

	method mover(direccion){
		if(self.puedeMover() ){
			if (self.dentroDelTablero(direccion)){
				self.volar(1)
				position = direccion.siguiente(position)
			}
		} else {
			self.perder()
		}
	}

	method dentroDelTablero(direccion) {
		const nuevaPosicion = direccion.siguiente(position)
		return (nuevaPosicion.x() >= 0 && 
				nuevaPosicion.y() >= 0 && 
				nuevaPosicion.x() < game.width() && 
				nuevaPosicion.y() < game.height())
	}

	method perder(){
		game.say(self, "Perdí!")
		game.schedule( 2000, { game.stop() })
	}
	
	method energia() {
		return energia
	}

}

