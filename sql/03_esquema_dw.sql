
-- DIMENSIONES

CREATE TABLE DIM_Tiempo (
    Id_Tiempo INT PRIMARY KEY,
    Anio INT,
    Mes INT,
    Dia INT
);

CREATE TABLE DIM_Cliente (
    Id_Cliente INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Direccion VARCHAR(100),
    Localidad VARCHAR(100),
    Pais VARCHAR(100),
    Region VARCHAR(100)
);

CREATE TABLE DIM_Puerto (
    Id_Puerto INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Pais VARCHAR(100),
    Region VARCHAR(100)
);

CREATE TABLE DIM_Tipo_Envio (
    Id_TipoEnvio INT PRIMARY KEY,
    Descripcion VARCHAR(100)
);

CREATE TABLE DIM_Tipo_Contrato (
    Id_TipoContrato INT PRIMARY KEY,
    Descripcion VARCHAR(100)
);

CREATE TABLE DIM_Estado_Contrato (
    Id_EstadoContrato INT PRIMARY KEY,
    Nombre VARCHAR(100)
);

CREATE TABLE DIM_Mercaderia (
    Id_Mercaderia INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Categoria VARCHAR(100),
    Carga_Peligrosa BIT
);

CREATE TABLE DIM_Servicio (
    Id_Servicio INT PRIMARY KEY,
    Id_Viaje INT,
    Id_Buque INT,
    Fecha_salida DATE,
    Fecha_Arribo DATE
);

CREATE TABLE DIM_Tipo_Contenedor (
    Id_TipoContenedor INT PRIMARY KEY,
    Tamanio VARCHAR(50),
    Altura VARCHAR(50),
    Refrigeracion BIT
);

CREATE TABLE DIM_Estado_Contenedor (
    Id_EstadoContenedor INT PRIMARY KEY,
    Descripcion VARCHAR(100)
);

-- TABLAS DE HECHOS

CREATE TABLE FT_Contratos (
    Id_Tiempo INT,
    Id_Servicio INT,
    Id_Cliente INT,
    Id_Mercaderia INT,
    Id_Puerto INT,
    Id_EstadoContrato INT,
    Id_TipoEnvio INT,
    Id_TipoContrato INT,
    Cant_kg INT,
    Cant_teus INT,
    Cant_contratos INT,
	PRIMARY KEY (
        Id_Tiempo,
        Id_Servicio,
        Id_Cliente,
        Id_Mercaderia,
        Id_Puerto,
        Id_EstadoContrato,
        Id_TipoEnvio,
        Id_TipoContrato
    ),
    FOREIGN KEY (Id_Tiempo) REFERENCES DIM_Tiempo(Id_Tiempo),
    FOREIGN KEY (Id_Servicio) REFERENCES DIM_Servicio(Id_Servicio),
    FOREIGN KEY (Id_Cliente) REFERENCES DIM_Cliente(Id_Cliente),
    FOREIGN KEY (Id_Mercaderia) REFERENCES DIM_Mercaderia(Id_Mercaderia),
    FOREIGN KEY (Id_Puerto) REFERENCES DIM_Puerto(Id_Puerto),
    FOREIGN KEY (Id_EstadoContrato) REFERENCES DIM_Estado_Contrato(Id_EstadoContrato),
    FOREIGN KEY (Id_TipoEnvio) REFERENCES DIM_Tipo_Envio(Id_TipoEnvio),
    FOREIGN KEY (Id_TipoContrato) REFERENCES DIM_Tipo_Contrato(Id_TipoContrato)
);

CREATE TABLE FT_Inventario_Contenedores (
    Id_Tiempo INT,
    Id_Puerto INT,
    Id_TipoContenedor INT,
    Id_EstadoContenedor INT,
    Cant_Contenedores INT,
    PRIMARY KEY (
        Id_Tiempo,
        Id_Puerto,
        Id_TipoContenedor,
        Id_EstadoContenedor
    ),
    FOREIGN KEY (Id_Tiempo) REFERENCES DIM_Tiempo(Id_Tiempo),
    FOREIGN KEY (Id_Puerto) REFERENCES DIM_Puerto(Id_Puerto),
    FOREIGN KEY (Id_TipoContenedor) REFERENCES DIM_Tipo_Contenedor(Id_TipoContenedor),
    FOREIGN KEY (Id_EstadoContenedor) REFERENCES DIM_Estado_Contenedor(Id_EstadoContenedor)
);
