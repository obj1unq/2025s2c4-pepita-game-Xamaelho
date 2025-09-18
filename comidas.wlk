import pepita.*
import niveles.*
import extras.*
import wollok.game.*

object manzana {
	const base = 5
	var madurez = 1
	const property position = game.at(5, 3)

    method image() = "manzana.png"
	
	method energiaQueOtorga() {
		return base * madurez	
	}
	
	method madurar() {
		madurez = madurez + 1
	}

	method reiniciar() {
		madurez = 1
	}

}

object alpiste {
	const property position = game.at(2, 1)

    method image() = "alpiste.png"

	method energiaQueOtorga() = 15
}

