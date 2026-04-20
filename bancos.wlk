//   EJERCICIO 1 - LA CASA DE PEPE Y JULIÁN n
object casa {
  var montoGastadoPorMes = 0
  var cuentaAsignada = cuentaCorriente
  var cantReparaciones = 0                // nuevo atributo del ej3
  var viveres = 0                         // nuevo atributo del ej3
  var estrategia = estrategiaMinimoEIndispensable      // nuevo atributo del ej4


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
//     ej. 3    -    al gastar se refleja en la cuenta asignada de la casa y al reparar se aumenta el gasto total de la casa
 method comprarViveres(porcentajeAComprar, calidad) {
   if (viveres + porcentajeAComprar > 100) {     // No se debería poder comprar un porcentaje que haga superar el 100% de víveres en la casa.
     self.error("No se puede superar el 100% de víveres")
  }

   self.registrarPago(porcentajeAComprar * calidad)
   viveres = viveres + porcentajeAComprar
 } 

 method realizarReparaciones() {
   self.registrarPago(cantReparaciones)
   cantReparaciones = 0
 }

 method viveresSuficientes() {
   return viveres >= 40       // la casa tiene víveres suficiente si tiene al menos el 40% de víveres
 }

 method hayReparacionesPendientes() {
   return cantReparaciones > 0
 }

 method casaEnOrden() {
   return self.hayReparacionesPendientes() && self.viveresSuficientes()
 }

 method registrarRotura(monto) {
   cantReparaciones = cantReparaciones + monto
 }

 // cosas de la parte 4
 method estrategia(tipo) {
   estrategia = tipo
 }

 method agregarViveres(cantidad) {
   viveres = viveres + cantidad
 }

 method viveres() {
   return viveres
 }

 method cambiarDeMes() {
   montoGastadoPorMes = 0
   estrategia.aplicar(self)
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
    saldo = saldo + saldoAIngresar
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
      cuentaPrimaria.extraer(cuentaPrimaria.saldo())
    }
  }

  method cuentaPrimaria(cuenta) {
    cuentaPrimaria = cuenta
  }

  method cuentaSecundaria(cuenta) {
    cuentaSecundaria = cuenta
  }
}

/* EJERCICIO 3   -   REPARACIONES Y CONSUMO
Se agregaron las siguientes funciones en el objeto casa:
- comprarViveres(porcentajeAComprar, calidad)
- realizarReparaciones(montoDeRep)
- viveresSuficientes()
- hayReparacionesPendientes()
- casaEnOrden()
- registrarRotura(monto)
*/

// EJERCICIO 4   -   ESTRATEGIAS DE MANTENIMIENTO
object estrategiaMinimoEIndispensable {
  var calidad = 0

  
  method aplicar(casa) {
    if (not casa.viveresSuficientes()){
      casa.comprarViveres(40 - casa.viveres(), calidad)
    }
  }

   method calidad() {
    return calidad
 }

  method calidad(valor) {
   calidad = valor
 }
}

object estrategiaFull {
  const calidad = 5


  method aplicar(casa) {              // si está en orden la casa
    if (casa.casaEnOrden()) {

      if (100 - casa.viveres() > 0) {          // si la casa NO tiene el 100% de viveres
        casa.comprarViveres(100 - casa.viveres(), calidad)
      }

    } else {                         // si NO está en orden
      if (not casa.viveresSuficientes()) {     // si la casa NO tiene suficientes viveres
        casa.comprarViveres(40 - casa.viveres(), calidad)
      }

      if (casa.hayReparacionesPendientes()) {     // si hay reparaciones que hacer las repara
        casa.realizarReparaciones()
      }
    }
  }
}
