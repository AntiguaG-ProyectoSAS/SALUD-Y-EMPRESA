--------Creacion de la base de datos
create database SYE;

-----Creacion de tablas,PK y FK
use SYE
GO

----Tabla Perfil(roles de usuario)
create table PERFIL(
    ID_PERFIL int NOT NULL identity (1,1) PRIMARY KEY,
    PERFIL varchar(50)
);

---Tabla Usuarios(Empleados)
create table USUARIO(
    ID_USUARIO int NOT NULL identity(1,1) PRIMARY KEY,
    NOMBRE varchar(60) NOT NULL,
    APELLIDO varchar(60)NOT NULL,
    DPI varchar(20) NOT NULL,
    CORREO varchar(100) unique NOT NULL,
    TELEFONO varchar(20),
    CONTRASEÑA varchar(200) NOT NULL,
    LIMITE_CREDITO decimal(15,2) NOT NULL,
    CREDITO_DISP decimal (15,2) NOT NULL,
    ID_PERFIL int NOT NULL,
    FECH_REGISTRO datetime default GETDATE(),
    FOREIGN KEY (ID_PERFIL) REFERENCES PERFIL(ID_PERFIL) 
);

-----Tabla Tokens
create table TIPO_TOKEN(
    ID int NOT NULL identity(1,1) PRIMARY KEY,
    TIPO_TOKEN varchar(10) NOT NULL UNIQUE
);

----- insert de la tabla TIPO_TOKEN
insert into TIPO_TOKEN (TIPO_TOKEN) VALUES ('EMAIL'), ('SMS');

-----Tabla Tokens
create table TOKENS(
    ID_TOKEN int NOT NULL identity(1,1) PRIMARY KEY,
    DATA_TOKEN varchar(200) unique NOT NULL,
    ID_TIPO_TOKEN int NOT NULL,
    TIME_EXP datetime default GETDATE(),
    ID_EMPLEADO int NOT NULL,
    FOREIGN KEY (ID_TIPO_TOKEN) REFERENCES TIPO_TOKEN(ID),
    FOREIGN KEY (ID_EMPLEADO) REFERENCES USUARIO(ID_USUARIO)
);


----Tabla administrativa(Auditoria)
create table AUDITORIA(
    ID_ADMIN int NOT NULL identity(1,1) PRIMARY KEY,
    ID_EMPLEADO int NOT NULL,
    COMENTARIO text,
    REGISTRO datetime default GETDATE(),
    FOREIGN KEY (ID_EMPLEADO) REFERENCES  USUARIO(ID_USUARIO)
);

-------Tabla Tipo de producto
create table TIPO_PRODUCTO (
    ID_TIPO int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    TIPO_PRODUCTO varchar(255) NOT NULL,
    DESCRIPCION text
);

------- Tabla Tipo de laboratorio
create table LABORATORIO(
    ID_LAB int NOT NULL IDENTITY(1,1) PRIMARY KEY,
    NOMBRE varchar(100)
);

------- Tabla de Productos
create table PRODUCTOS (
    ID_PRODUCTO int NOT NULL IDENTITY (1,1) PRIMARY KEY,
    NOMBRE_PRODUCTO varchar (255) NOT NULL,
    DESCRIPCION text,
    STOCK int NOT NULL,
    PRECIO decimal(15,2) NOT NULL,  
    ID_TIPO_PRODUCTO int NOT NULL,
    ID_LABORATORIO int NOT NULL,
    FOREIGN KEY (ID_TIPO_PRODUCTO) REFERENCES TIPO_PRODUCTO(ID_TIPO),
    FOREIGN KEY (ID_LABORATORIO) REFERENCES LABORATORIO(ID_LAB)
);

-------- Tabla de Compras
create table COMPRAS(
    ID_COMPRAS int NOT NULL IDENTITY (1,1) PRIMARY KEY,
    ID_EMPLEADO int NOT NULL,
    ID_PRODUCTO int NOT NULL,
    CANTIDAD int NOT NULL,
    TOTAL decimal(15,2) NOT NULL,
    FECH_EMISION datetime default GETDATE(),
    FOREIGN KEY(ID_EMPLEADO) REFERENCES USUARIO(ID_USUARIO),
    FOREIGN KEY(ID_PRODUCTO) REFERENCES PRODUCTOS(ID_PRODUCTO)
);