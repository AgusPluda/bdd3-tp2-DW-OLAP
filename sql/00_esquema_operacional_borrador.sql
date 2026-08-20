CREATE TABLE Clientes (
  cliente_id INT PRIMARY KEY,
  cliente_nombre VARCHAR(100) NOT NULL,
  direccion VARCHAR(200) NOT NULL,
  localidad_id INT NOT NULL,
  FOREIGN KEY (localidad_id) REFERENCES Localidades(localidad_id)
);

CREATE TABLE Localidades (
  localidad_id INT PRIMARY KEY,
  nombre_localidad VARCHAR(100) NOT NULL,
  provincia_id INT NOT NULL,
  FOREIGN KEY (provincia_id) REFERENCES Provincias(provincia_id)
);

CREATE TABLE Provincias (
  provincia_id INT PRIMARY KEY,
  nombre_provincia VARCHAR(100) NOT NULL,
  pais_id INT NOT NULL,
  FOREIGN KEY (pais_id) REFERENCES Paises(pais_id)
);

CREATE TABLE Paises (
  pais_id INT PRIMARY KEY,
  nombre_pais VARCHAR(100) NOT NULL,
  region_id INT NOT NULL,
  FOREIGN KEY (region_id) REFERENCES Regiones(region_id)
);

CREATE TABLE Regiones (
  region_id INT PRIMARY KEY,
  region VARCHAR(100) NOT NULL
);

CREATE TABLE Puertos (
  puerto_id INT PRIMARY KEY,
  nombre_puerto VARCHAR(100) NOT NULL,
  localidad_id INT NOT NULL,
  FOREIGN KEY (localidad_id) REFERENCES Localidades(localidad_id),

);

CREATE TABLE Tipos_Contenedor (
  tipo_contenedor_id INT PRIMARY KEY,
  tipo_contenedor VARCHAR(100),
  TEUs_equivalente INT NOT NULL
);

CREATE TABLE Contenedores (
  contenedor_id INT PRIMARY KEY,
  numero_contenedor VARCHAR(50) NOT NULL,
  tipo_contenedor_id INT NOT NULL,
  FOREIGN KEY (tipo_contenedor_id) REFERENCES Tipos_Contenedor(tipo_contenedor_id)
);

CREATE TABLE Tipos_Contrato (
  tipo_contrato_id INT PRIMARY KEY,
  tipo_contrato VARCHAR(100) NOT NULL
);

CREATE TABLE Tipos_Envio (
  tipo_envio_id INT PRIMARY KEY,
  tipo_envio VARCHAR(100) NOT NULL
);

CREATE TABLE Estados_Contrato (
  estado_contrato_id INT PRIMARY KEY,
  nombre_estado_contrato VARCHAR(100) NOT NULL
);

CREATE TABLE Contratos (
  contrato_id INT PRIMARY KEY,
  nro_contrato VARCHAR(50) UNIQUE NOT NULL,
  tipo_contrato_id INT NOT NULL,
  fecha_generacion DATE,
  tipo_envio_id INT NOT NULL,
  cliente_remitente_id INT NOT NULL,
  direccion_remitente VARCHAR(200),
  localidad_remitente INT,
  puerto_de_carga_id INT NOT NULL,
  puerto_de_descarga_id INT NOT NULL,
  estado_contrato_id INT NOT NULL,
  cliente_destinatario_id INT NOT NULL,
  direccion_destinatario VARCHAR(200),
  localidad_destinatario INT,
  par_puertos_programado INT NOT NULL,
  estado_contrato_id INT NOT NULL,
  FOREIGN KEY (tipo_contrato_id) REFERENCES Tipos_Contrato(tipo_contrato_id),
  FOREIGN KEY (tipo_envio_id) REFERENCES Tipos_Envio(tipo_envio_id),
  FOREIGN KEY (cliente_remitente_id) REFERENCES Clientes(cliente_id),
  FOREIGN KEY (cliente_destinatario_id) REFERENCES Clientes(cliente_id),
  FOREIGN KEY (localidad_remitente) REFERENCES Localidades(localidad_id),
  FOREIGN KEY (localidad_destinatario) REFERENCES Localidades(localidad_id),
  FOREIGN KEY (estado_contrato_id) REFERENCES Estados_Contrato(estado_contrato_id),
  FOREIGN KEY (puerto_de_carga_id) REFERENCES Puertos(puerto_id),
  FOREIGN KEY (puerto_de_descarga_id) REFERENCES Puertos(puerto_id),
  FOREIGN KEY (mercaderia_id) REFERENCES Mercaderias(mercaderia_id),
  FOREIGN KEY (par_puertos_programado) REFERENCES Programaciones_Par_Puertos(par_puertos_programados_id)
);

CREATE TABLE Contenedor_Contrato (
  contenedor_contrato_id INT PRIMARY KEY,
  contenedor_id INT NOT NULL,
  contrato_id INT NOT NULL,
  mercaderia_id INT, 
  peso INT,
  fecha_asignacion DATE NOT NULL,
  fecha_cancelacion DATE NULL,
  FOREIGN KEY (contenedor_id) REFERENCES Contenedores(contenedor_id),
  FOREIGN KEY (contrato_id) REFERENCES Contratos(contrato_id)
  FOREIGN KEY (mercaderia_id) REFERENCES Mercaderias(mercaderia_id)
);

CREATE TABLE Mercaderias (
  mercaderia_id INT PRIMARY KEY,
  mercaderia VARCHAR(100) UNIQUE NOT NULL,
  categoria_mercaderia VARCHAR(100) NOT NULL,
  es_carga_peligrosa BOOLEAN NOT NULL
);

CREATE TABLE Tipos_Movimiento (
  tipo_movimiento_id INT PRIMARY KEY,
  tipo_movimiento VARCHAR(50) NOT NULL
);

CREATE TABLE Movimientos_Contenedores (
  movimiento_contenedor_id INT PRIMARY KEY,
  contenedor_id INT NOT NULL,
  fecha_movimiento DATE NOT NULL,
  tipo_movimiento_id INT NOT NULL,
  puerto_id INT NOT NULL,
  FOREIGN KEY (contenedor_id) REFERENCES Contenedores(contenedor_id),
  FOREIGN KEY (tipo_movimiento_id) REFERENCES Tipos_Movimiento(tipo_movimiento_id),
  FOREIGN KEY (puerto_id) REFERENCES Puertos(puerto_id)
);

CREATE TABLE Buques (
  buque_id INT PRIMARY KEY,
  nombre_buque VARCHAR(100) NOT NULL,
  matricula_buque VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Servicios (
  servicio_id INT PRIMARY KEY,
  nombre_servicio VARCHAR(100) NOT NULL
);

CREATE TABLE Viajes (
  viaje_id INT PRIMARY KEY,
  buque_id INT NOT NULL,
  numero_de_viaje INT NOT NULL,
  servicio_id INT NOT NULL,
  FOREIGN KEY (buque_id) REFERENCES Buques(buque_id),
  FOREIGN KEY (servicio_id) REFERENCES Servicios(servicio_id)
);

CREATE TABLE Puertos_de_Llamada_Viajes (
  puerto_de_llamada_id INT PRIMARY KEY,
  viaje_id INT NOT NULL,
  puerto_id INT NOT NULL,
  fecha_arribo_estimada DATE NOT NULL,
  fecha_arribo_real DATE,
  fecha_partida_estimada DATE NOT NULL,
  fecha_partida_real DATE,
  fecha_cancelacion DATE,
  FOREIGN KEY (viaje_id) REFERENCES Viajes(viaje_id)
  FOREIGN KEY (puerto_id) REFERENCES Puertos(puerto_id)
);

CREATE TABLE Programaciones_Par_Puertos (
  par_puertos_programado_id INT PRIMARY KEY,
  puerto_de_llamada_id INT NOT NULL,
  puerto_de_destino_id INT NOT NULL,
  FOREIGN KEY (puerto_de_llamada_id) REFERENCES Puertos_de_Llamada(puerto_de_llamada_id),
  FOREIGN KEY (puerto_de_destino_id) REFERENCES Puertos(puerto_id)
);

