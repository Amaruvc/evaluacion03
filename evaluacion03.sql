CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `run` varchar(12) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `estado` (
  `idestado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idestado`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE `producto` (
  `idproducto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `precio` int(11) NOT NULL,
  PRIMARY KEY (`idproducto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `pedido` (
  `idpedido` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `idestado` int(11) NOT NULL,
  PRIMARY KEY (`idpedido`),
  KEY `fk_pedido_estado_idx` (`idestado`),
  CONSTRAINT `fk_pedido_estado` FOREIGN KEY (`idestado`) REFERENCES `estado` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `pedido_producto` (
  `idpedido` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` int(11) NOT NULL,
  PRIMARY KEY (`idpedido`,`idproducto`),
  KEY `fk_producto_pedido_idx` (`idproducto`),
  CONSTRAINT `fk_pedido_producto` FOREIGN KEY (`idpedido`) REFERENCES `pedido` (`idpedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_pedido` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


insert into estado (nombre)
values ('Pendiente'),('Confirmado'), ('Rechazado');

insert into usuario
values (1, '123456789', 'eva03');

create or replace view v_pedido as
select p.*, e.nombre as nombre_estado from pedido p inner join estado e on p.idestado = e.idestado order by idpedido;

create or replace view v_pedido_productos as
select pp.idpedido, pp.cantidad, pp.precio_unitario, p.* from pedido_producto pp inner join producto p on pp.idproducto = p.idproducto;	
