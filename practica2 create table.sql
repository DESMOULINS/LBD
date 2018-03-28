use puntoventa
-- Tabla de contactos
create table contactos
(
	id_cont int IDENTITY(2,10) PRIMARY KEY,
	-- esto relacionara uno a varios con la tabla personas
	id_relcontper int,
	tel_per varchar(20) NOT NULL,
	dir_per text,
	correo_per text 
)

-- TABLA DE PERSONAS
create table personas
(
	id_per int PRIMARY KEY,
	nom_per varchar(20) NOT NULL,
	apelpat_per varchar(10) NOT NULL,
	apelmat_per varchar(10),
	nomcom_per as (nom_per+apelpat_per+apelmat_per),
	fechanac_per date,
	edad_per AS DATEDIFF(YEAR,fechanac_per,GETDATE())
)

-- TABLA DE USUARIO
	create table empleados
	(
		id_em int IDENTITY(3,10) PRIMARY KEY,
		usuario_em varchar(12) NOT NULL,
		password_em varchar(12) NOT NULL,
		salario_em int NOT NULL
	)

-- TABLA DE PROVEEDORES
	create table proveedores
	(
		id_prov int IDENTITY(4,10) PRIMARY KEY,
		nom_prov varchar(20) NOT NULL,
		rfc_prov varchar(12) NOT NULL
	)

-- Tabla de clientes
	create table clientes
	(
		id_cli int IDENTITY(5,10) PRIMARY KEY,
		rfc_cli varchar(12)
	)

-- //// Declaramos los indices

CREATE INDEX idx_rfc
ON clientes (rfc_cli); 
CREATE INDEX idx_us
ON empleados (usuario_em); 
CREATE INDEX idx_nomprov
ON proveedores (nom_prov); 