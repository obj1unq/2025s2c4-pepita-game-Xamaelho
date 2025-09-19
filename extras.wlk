import niveles.*
import wollok.game.*
import pepita.*

object nido{
    const property position = game.at(8, 8)

    method image() = "nido.png"

    method teCruzasteCon(personaje) {
        game.say(personaje, "GANE!")
        nivel.ganar()
    }

}

object silvestre{
    const presa = pepita

    method image() = "silvestre.png"

    method position() = game.at(self.x(), 0)

    method reiniciar() {
        self.x()
    }

    method x() = 3.max(presa.position().x()) //presa.position().x().max(3)
    //if(presa.position().x() >= 3) { presa.position().x()} else { 3 }

    method teCruzasteCon(personaje) {
        game.say(personaje, "PERDI!")
        nivel.perder(self)
    }
}
