#intencionalmente el mejor jugador va al final de la lista de jugadores
#porque la funcion which.max() de R hace trampa
#si hay un empate ( dos máximos) se queda con el que esta primero en el vector


set.seed( 324161 )

#calcula cuantos encestes logra un jugador con indice de enceste prob que hace qyt tiros libres
ftirar  <- function( prob, qty ){
  vsize <- length(prob)
  return( rowSums( matrix( runif( qty*vsize ), vsize, qty)  <
                   matrix( rep(prob,qty), vsize, qty)  ) )
}

#defino los jugadores
mejor      <- 0.7
peloton    <- ( 501:599 ) / 1000
jugadores  <- c( peloton, mejor ) #intencionalmente el mejor esta al final


t0  <- Sys.time()

for( tiros_libres in c(10, 20, 50, 100, 200, 300, 400, 415, 500, 600, 700, 1000 ) ){

  primero_ganador  <- 0

  for( i in 1:10000 ) {  #diez mil experimentos

    vaciertos  <- ftirar( jugadores, tiros_libres )
    mejor  <- which.max( vaciertos )

    if( mejor == 100 )  primero_ganador  <- primero_ganador + 1
  }

  cat( tiros_libres, "\t", primero_ganador/10000, "\n" )
}

t1  <- Sys.time()

print( t1 - t0 )
