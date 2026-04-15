//   EJERCICIO 1 - LA CASA DE PEPE Y JULIÁN
object casa {
  var montoGastadoPorMes = 0
  var cuentaAsignada = cuentaCorriente


  method registrarPago(monto) {
    self.sePuedeGastar(monto, cuentaAsignada.saldo())
    montoGastadoPorMes = montoGastadoPorMes + monto
    cuentaAsignada.extraer(monto)
  }

  method sePuedeGastar(monto, saldoDeLaCuenta) {
    if (monto > saldoDeLaCuenta){
      self.error("No Tenés saldo suficiente en tu cuenta actual.")
    }
  }

  method montoGastadoPorMes() {
    return montoGastadoPorMes
  }

  method cuentaAsignada(cuenta) {
    cuentaAsignada = cuenta
  }

  method cuentaAsignada() {
    return cuentaAsignada
  }
}

object cuentaCorriente {
  var saldo = 0
  

  method saldo() {
    return saldo
  }
  
  method extraer(montoAExtraer) {
    saldo = saldo - montoAExtraer
  }
  
  method depositar(saldoAIngresar) {
    saldo = saldoAIngresar
  }
}

object cuentaConGastos {
  var saldo = 0


  method saldo() {
    return saldo
  }

  method depositar(monto, costoPorOperacion) {
    
    self.elMontoEsSuficiente(monto, costoPorOperacion)  
    saldo = saldo + (monto - costoPorOperacion)
  }

  method elMontoEsSuficiente(monto, costoPorOperacion) {
    if (monto <= costoPorOperacion){         //el igual ya que no podes depositar 0 pesos, es ilógico
      self.error("Monto no permitido, el monto debe ser mayor que:" + costoPorOperacion)
    }
  }

  method extraer(monto) {
    saldo = saldo - monto
  }
} 


//   EJERCICIO 2 - CUENTAS  COMBINADAS
object cuentaPrimaria {
  var saldo = 0

  method saldo() {
    return saldo
  }

  method depositar(monto) {
    saldo = saldo + monto
  }

  method extraer(monto) {
    saldo = saldo - monto
  }
}

object cuentaSecundaria {
  var saldo = 0

  method saldo() {
    return saldo
  }

  method extraer(monto) {
    saldo = saldo - monto
  }
}

object cuentaCombinada {
  //var saldo = 0          innecesaria(?)

  method extraer(monto) {
     self.sePuedeExtraer(monto)    //validador para comprobar si la extracción se puede hacer o no
  }

  method depositar(monto, cuentaADepositar) {
    cuentaADepositar.depositar(monto)
  }

  method saldo() {
    return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
  }

  method sePuedeExtraer(monto) {
    return if (monto > cuentaPrimaria.saldo().max(cuentaSecundaria.saldo())){
      self.error("No es posible realizar una extracción de:" + monto)
    }
  }
}
