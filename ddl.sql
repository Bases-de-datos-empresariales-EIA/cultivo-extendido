-- DROP SCHEMA cultivo_extendido;

CREATE SCHEMA cultivo_extendido AUTHORIZATION postgres;
-- cultivo_extendido.cliente definition

-- Drop table

-- DROP TABLE cultivo_extendido.cliente;

CREATE TABLE cultivo_extendido.cliente (
	id text NOT NULL,
	nombre text NOT NULL,
	CONSTRAINT cliente_pkey PRIMARY KEY (id)
);


-- cultivo_extendido.factura definition

-- Drop table

-- DROP TABLE cultivo_extendido.factura;

CREATE TABLE cultivo_extendido.factura (
	id text NOT NULL,
	fecha timestamp(3) NOT NULL,
	total float8 DEFAULT 0 NOT NULL,
	CONSTRAINT factura_pkey PRIMARY KEY (id)
);


-- cultivo_extendido.finca definition

-- Drop table

-- DROP TABLE cultivo_extendido.finca;

CREATE TABLE cultivo_extendido.finca (
	id text NOT NULL,
	nombre text NOT NULL,
	CONSTRAINT finca_pkey PRIMARY KEY (id)
);


-- cultivo_extendido.m_cultivo definition

-- Drop table

-- DROP TABLE cultivo_extendido.m_cultivo;

CREATE TABLE cultivo_extendido.m_cultivo (
	id text NOT NULL,
	nombre text NOT NULL,
	CONSTRAINT m_cultivo_pkey PRIMARY KEY (id)
);


-- cultivo_extendido.usuario definition

-- Drop table

-- DROP TABLE cultivo_extendido.usuario;

CREATE TABLE cultivo_extendido.usuario (
	id text NOT NULL,
	nombre text NOT NULL,
	correo text NOT NULL,
	CONSTRAINT usuario_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX usuario_correo_key ON cultivo_extendido.usuario USING btree (correo);


-- cultivo_extendido.despacho definition

-- Drop table

-- DROP TABLE cultivo_extendido.despacho;

CREATE TABLE cultivo_extendido.despacho (
	id text NOT NULL,
	fecha timestamp(3) NOT NULL,
	id_cliente text NOT NULL,
	id_factura text NULL,
	CONSTRAINT despacho_pkey PRIMARY KEY (id),
	CONSTRAINT despacho_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES cultivo_extendido.cliente(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT despacho_id_factura_fkey FOREIGN KEY (id_factura) REFERENCES cultivo_extendido.factura(id) ON DELETE SET NULL ON UPDATE CASCADE
);


-- cultivo_extendido.lote definition

-- Drop table

-- DROP TABLE cultivo_extendido.lote;

CREATE TABLE cultivo_extendido.lote (
	id text NOT NULL,
	nombre text NOT NULL,
	id_finca text NOT NULL,
	id_cultivo text NOT NULL,
	CONSTRAINT lote_pkey PRIMARY KEY (id),
	CONSTRAINT lote_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES cultivo_extendido.m_cultivo(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT lote_id_finca_fkey FOREIGN KEY (id_finca) REFERENCES cultivo_extendido.finca(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- cultivo_extendido.precio definition

-- Drop table

-- DROP TABLE cultivo_extendido.precio;

CREATE TABLE cultivo_extendido.precio (
	id text NOT NULL,
	id_cultivo text NOT NULL,
	valor float8 NOT NULL,
	fecha timestamp(3) NOT NULL,
	CONSTRAINT precio_pkey PRIMARY KEY (id),
	CONSTRAINT precio_id_cultivo_fkey FOREIGN KEY (id_cultivo) REFERENCES cultivo_extendido.m_cultivo(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


-- cultivo_extendido.recogida definition

-- Drop table

-- DROP TABLE cultivo_extendido.recogida;

CREATE TABLE cultivo_extendido.recogida (
	id text NOT NULL,
	fecha timestamp(3) NOT NULL,
	id_lote text NOT NULL,
	cantidad float8 NOT NULL,
	id_usuario text NOT NULL,
	id_despacho text NULL,
	CONSTRAINT recogida_pkey PRIMARY KEY (id),
	CONSTRAINT recogida_id_despacho_fkey FOREIGN KEY (id_despacho) REFERENCES cultivo_extendido.despacho(id) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT recogida_id_lote_fkey FOREIGN KEY (id_lote) REFERENCES cultivo_extendido.lote(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT recogida_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES cultivo_extendido.usuario(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
