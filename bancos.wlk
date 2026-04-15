//   EJERCICIO 1 - LA CASA DE PEPE Y JULIÁN
object casa {
  var montoGastadoPorMes = 0
  var cuentaAsignada = cuentaCorriente
  //var casaEnOrden = true
  var cantReparaciones = 0
  var viveres = 0


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
//     ej. 3       // al gastar se refleja en la cuenta asignada de la casa y al reparar se aumenta el gasto total de la casa
method comprarViveres(porcentajeAComprar, calidad) {
  if (){
    viveres = porcentajeAComprar * calidad
  } else {
    viveres = 0
  }
  
}

method realizarReparaciones(montoDeRep) {
  cantReparaciones = 0
}

method viveresSuficientes() {
  return (viveres * 40) / 100       // porcentaje: (cantidad a calcular * valor del porcentaje) / 100
}

method hayReparacionesPendientes() {
  return cantReparaciones > 0
}

method casaEnOrden() {
  return self.hayReparacionesPendientes() && (self.viveresSuficientes() > 0)
}
}

object cuentaCorriente {
  var saldo = 0
  

  method saldo() {
    return saldo
  }
  
  method extraer(monto) {
    saldo = saldo - monto
  }
  
  method depositar(saldoAIngresar) {
    saldo = saldoAIngresar
  }
}

object cuentaConGastos {
  var saldo = 0
  var costoPorOperacion = 0


  method saldo() {
    return saldo
  }

  method depositar(monto) {
    self.elMontoEsSuficiente(monto)  
    saldo = saldo + (monto - costoPorOperacion)
  }

  method costoPorOperacion(valor) {
    costoPorOperacion = valor
  }

  method elMontoEsSuficiente(monto) {
    if (monto <= costoPorOperacion){         //el igual ya que no podes depositar 0 pesos, es ilógico
      self.error("Monto no permitido, el monto debe ser mayor que:" + costoPorOperacion)
    }
  }

  method extraer(monto) {
    saldo = saldo - monto
  }
} 


//   EJERCICIO 2 - CUENTAS  COMBINADAS
object cuentaCombinada {
  var cuentaPrimaria = cuentaCorriente
  var cuentaSecundaria = cuentaConGastos



  method extraer(monto) {
     self.validarExtraccion(monto)    //validador para comprobar si la extracción se puede hacer o no
     self.extraerElMonto(monto)
  }

  method depositar(monto) {
    cuentaPrimaria.depositar(monto)
  }

  method saldo() {
    return 0.max(cuentaPrimaria.saldo()) + 0.max(cuentaSecundaria.saldo())         // mal, considera saldos negativos
    //return (cuentaPrimaria.saldo().max(cuentaSecundaria.saldo()))   // retornearía el saldo positivo de ambas cuentas, si no retorna 0
  }

  method validarExtraccion(monto) {
    return if (not self.puedeExtraer(monto)){
      self.error("No es posible realizar una extracción de:" + monto)
    }
  }

  method puedeExtraer(valor) {
    //return valor <= self.saldo()   // resolver esta parte
    return valor <= (cuentaPrimaria.saldo() + cuentaSecundaria.saldo())
  }

  method extraerElMonto(monto) {
    if (monto <= cuentaPrimaria.saldo()){    // se sacaría todo lo posible de la 1° cuenta, si no de la 2°
      cuentaPrimaria.extraer(monto)
    } else {      
      cuentaSecundaria.extraer(monto - cuentaPrimaria.saldo())
      cuentaPrimaria.extraer(monto) 
      //cuentaPrimaria.extraer(cuentaPrimaria.saldo())
    }
  }

  method cuentaPrimaria(cuenta) {
    cuentaPrimaria = cuenta
  }

  method cuentaSecundaria(cuenta) {
    cuentaSecundaria = cuenta
  }
}

// EJERCICIO 3   -   REPARACIONES Y CONSUMO


// EJERCICIO 4   -   ESTRATEGIAS DE MANTENIMIENTO

