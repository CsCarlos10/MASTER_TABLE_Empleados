/*==============================================================*/
/* Table: AJUSTES		                                        */
/*==============================================================*/
create table AJUSTES (
   AJUCODIGO            int4              not null,
   EMPCODIGO            CHAR(7)              not null,
   AJUDESCRIPCION       CHAR(60)             not null,
   AJUFECHA             DATE                 not null,
   AJUCANTIDADTOTAL     NUMERIC(9,2)         null,
   constraint PK_AJUSTES primary key (AJUCODIGO)
);

/*==============================================================*/
/* Table: BONIFICACIONES                                        */
/*==============================================================*/
create table BONIFICACIONES (
   BONCODIGO            CHAR(5)              not null,
   BONDESCRIPCION       CHAR(30)             not null,
   BONVALOR             DECIMAL(7,2)         not null,
   constraint PK_BONIFICACIONES primary key (BONCODIGO)
);

/*==============================================================*/
/* Table: BXN                                                   */
/*==============================================================*/
create table BXN (
   BONCODIGO            CHAR(5)              not null,
   NOMCODIGO            CHAR(7)              not null,
   BXNVALOR             DECIMAL(7,2)         not null,
   BXNSTATUS            CHAR(3)              not null,
   constraint PK_BXN primary key (BONCODIGO, NOMCODIGO)
);

/*==============================================================*/
/* Table: CLIENTES                                              */
/*==============================================================*/
create table CLIENTES (
   CLICODIGO            CHAR(7)              not null,
   CLINOMBRE            CHAR(60)             not null,
   CLIIDENTIFICACION    CHAR(13)             not null,
   CLIDIRECCION         CHAR(60)             not null,
   CLITELEFONO          CHAR(10)             not null,
   CLICELULAR           CHAR(10)             not null,
   CLIEMAIL             CHAR(60)             null,
   CLITIPO              CHAR(3)              not null,
   CLISTATUS            CHAR(3)              not null,
   constraint PK_CLIENTES primary key (CLICODIGO)
);

/*==============================================================*/
/* Table: COMPRAS                                               */
/*==============================================================*/
create table COMPRAS (
   OCNUMERO             CHAR(9)              not null,
   PRVCODIGO            CHAR(7)              not null,
   OCFECHA              DATE                 not null,
   OCSUBTOTAL           NUMERIC(9,2)         not null,
   OCDESCUENTO          NUMERIC(9,2)         null,
   OCVALOR_IVA          NUMERIC(9,2)         null,
   OCVALOR_ICE          NUMERIC(9,2)         null,
   OCFORMAPAGO          CHAR(5)              not null,
   OCFACTURA_ASOCIADA   CHAR(30)             not null,
   OCSTATUS             CHAR(3)              null,
   constraint PK_COMPRAS primary key (OCNUMERO)
);


/*==============================================================*/
/* Table: DESCUENTOS                                            */
/*==============================================================*/
create table DESCUENTOS (
   DESCODIGO            CHAR(5)              not null,
   DESDESCRIPCION       CHAR(30)             not null,
   DESVALOR             DECIMAL(7,2)         not null,
   constraint PK_DESCUENTOS primary key (DESCODIGO)
);

/*==============================================================*/
/* Table: DXN                                                   */
/*==============================================================*/
create table DXN (
   NOMCODIGO            CHAR(7)              not null,
   DESCODIGO            CHAR(5)              not null,
   DXNVALOR             DECIMAL(7,2)         not null,
   DXNSTATUS            CHAR(3)              not null,
   constraint PK_DXN primary key (NOMCODIGO, DESCODIGO)
);

/*==============================================================*/
/* Table: EMPLEADOS                                             */
/*==============================================================*/
CREATE TABLE EMPLEADOS (
   EMPCODIGO            CHAR(7)              NOT NULL,
   EMPAPELLIDO1         VARCHAR(30)          NOT NULL,
   EMPAPELLIDO2         VARCHAR(30),
   EMPNOMBRE1           VARCHAR(30)          NOT NULL,
   EMPNOMBRE2           VARCHAR(30),
   EMPFECHANACIMIENTO   DATE                 NOT NULL,
   EMPSEXO              CHAR(1)              NOT NULL,
   EMPEMAIL             VARCHAR(60)          NOT NULL,
   EMPDIRECCION         VARCHAR(60)          NOT NULL,
   EMPTIPOSANGRE        CHAR(3)              NOT NULL,
   EMPSUELDO            NUMERIC(7,2)         NOT NULL,
   EMPBANCO             VARCHAR(30)          NOT NULL,
   EMPCUENTA            VARCHAR(20)          NOT NULL,
   EMPSTATUS            CHAR(3)              NOT NULL,
   EMPFOTO              BYTEA,
   CONSTRAINT PK_EMPLEADOS PRIMARY KEY (EMPCODIGO),
   CONSTRAINT CK_EMPPRIMER_APELLIDO CHECK (UPPER (EMPAPELLIDO1) ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$'),
   CONSTRAINT CK_EMPSEGUNDO_APELLIDO CHECK (UPPER (EMPAPELLIDO2) IS NULL OR EMPAPELLIDO2 ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$'),
   CONSTRAINT CK_EMPPRIMER_NOMBRE CHECK (UPPER (EMPNOMBRE1) ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$'),
   CONSTRAINT CK_EMPSEGUNDO_NOMBRE CHECK ( UPPER (EMPNOMBRE2) IS NULL OR EMPNOMBRE2 ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$'),
   CONSTRAINT CK_EMPFECHA_NACIMIENTO CHECK (EMPFECHANACIMIENTO <= '2006-06-14'::DATE),
   CONSTRAINT CK_EMPSEXO_MH CHECK (UPPER (EMPSEXO) IN ('M', 'H', 'Otros')),
   CONSTRAINT CK_EMPEMAIL_ARROBA CHECK (EMPEMAIL ~ '^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+$'),
   CONSTRAINT CK_EMPTIPOSANGRE_TIPOS CHECK (EMPTIPOSANGRE IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-', 'RH-', 'RH+', 'Otros')),
   CONSTRAINT CK_EMPSUELDO_POSITIVO CHECK (EMPSUELDO >= 0),
   CONSTRAINT CK_EMPBANCO_VALIDO CHECK (UPPER(EMPBANCO) IN ('BANCO DEL PACÍFICO', 'BANCO PICHINCHA', 'BANCO GUAYAQUIL', 'BANCO DE LOJA', 'BANCO DEL AUSTRO', 'BANCO INTERNACIONAL', 'BANCO BOLIVARIANO', 'BANCO PRODUBANCO', 'BANCO DE MACHALA', 'BANCO SOLIDARIO', 'BANCO DE FOMENTO', 'BANCO PROCREDIT', 'BANCO AMAZONAS', 'BANCO DE GUAYAQUIL', 'BANCO DEL LITORAL', 'BANCO PROCREDIT', 'Otros')),
   CONSTRAINT CK_EMPCUENTA_CARACTERES CHECK (EMPCUENTA ~ '^[^\W_]+$' OR EMPCUENTA ~ '^[\w ]+$'),
   CONSTRAINT CK_EMPSTATUS_VALIDO CHECK (UPPER (EMPSTATUS) IN ('INA', 'ACT'))
);


/*==============================================================*/
/* Table: FACTURAS                                              */
/*==============================================================*/
create table FACTURAS (
   FACNUMERO            CHAR(9)              not null,
   CLICODIGO            CHAR(7)              not null,
   FACFECHA             DATE                 not null,
   FACSUBTOTAL          NUMERIC(9,2)         not null,
   FACDESCUENTO         NUMERIC(9,2)         null,
   FACIVA               NUMERIC(9,2)         null,
   FACICE               NUMERIC(9,2)         null,
   FACFORMAPAGO         CHAR(5)              not null,
   FACSTATUS            CHAR(3)              not null,
   constraint PK_FACTURAS primary key (FACNUMERO)
);

/*==============================================================*/
/* Table: INGRESOS                                              */
/*==============================================================*/
create table INGRESOS (
   INGCODIGO            int4              not null,
   EMPCODIGO            CHAR(7)              not null,
   INGDESCRIPCION       CHAR(30)             not null,
   INGFECHA             DATE                 not null,
   INGCANTIDADTOTAL     NUMERIC(9,2)         null,
   INGREFERENCIA        CHAR(60)             null,
   constraint PK_INGRESOS primary key (INGCODIGO)
);

/*==============================================================*/
/* Table: NOMINAS                                               */
/*==============================================================*/
create table NOMINAS (
   NOMCODIGO            CHAR(7)              not null,
   EMPCODIGO            CHAR(7)              not null,
   NOMANIO              CHAR(4)              not null,
   NOMMES               CHAR(2)              not null,
   NOMFECHAINICIAL      DATE                 not null,
   NOMFECHAFINAL        DATE                 not null,
   NOMSTATUS            CHAR(3)              not null,
   constraint PK_NOMINAS primary key (NOMCODIGO)
);

/*==============================================================*/
/* Table: PRODUCTOS                                             */
/*==============================================================*/
create table PRODUCTOS (
   PROCODIGO            CHAR(9)              not null,
   PRODESCRIPCION       CHAR(50)             not null,
   PROUNIDADMEDIDA      CHAR(3)              not null,
   PROSALDOINICIAL      DECIMAL(9,2)         not null,
   PROINGRESOS          DECIMAL(9,2)         not null,
   PROEGRESOS           NUMERIC(9,2)         not null,
   PROAJUSTES           NUMERIC(9,2)         not null,
   PROSALDOFINAL        NUMERIC(9,2)         not null,
   PROCOSTOUM           NUMERIC(7,2)         not null,
   PROPRECIOUM          NUMERIC(7,2)         not null,
   PROSTATUS            CHAR(3)              not null,
   constraint PK_PRODUCTOS primary key (PROCODIGO)
);

/*==============================================================*/
/* Table: PROVEEDORES                                           */
/*==============================================================*/
create table PROVEEDORES (
   PRVCODIGO            CHAR(7)              not null,
   PRVNOMBRE            CHAR(30)             not null,
   PRVIDENTIFICACION    CHAR(10)             not null,
   PRVDIRECCION         CHAR(60)             not null,
   PRVTELEFONO          CHAR(10)             null,
   PRVCELULAR           CHAR(10)             null,
   PRVEMAIL             CHAR(60)             null,
   PRVTIPO              CHAR(3)              not null,
   PRVSTATUS            CHAR(3)              not null,
   constraint PK_PROVEEDORES primary key (PRVCODIGO)
);


/*==============================================================*/
/* Table: PXA                                                   */
/*==============================================================*/
create table PXA (
   AJUCODIGO            INT4                 not null,
   PROCODIGO            CHAR(9)              not null,
   PXACANTIDAD          NUMERIC(9,2)         not null,
   constraint PK_PXA primary key (AJUCODIGO, PROCODIGO)
);


/*==============================================================*/
/* Table: PXF                                                   */
/*==============================================================*/
create table PXF (
   FACNUMERO            CHAR(9)              not null,
   PROCODIGO            CHAR(9)              not null,
   PXFCANTIDAD          NUMERIC(9,2)         not null,
   PXFVALOR             NUMERIC(7,2)         not null,
   PXFSUBTOTAL          NUMERIC(9,2)         not null,
   PXFSTATUS            CHAR(3)              not null,
   constraint PK_PXF primary key (FACNUMERO, PROCODIGO)
);
select * from empleados;

/*==============================================================*/
/* Table: PXI                                                   */
/*==============================================================*/
create table PXI (
   INGCODIGO            INT4                 not null,
   PROCODIGO            CHAR(9)              not null,
   PXICANTIDAD          NUMERIC(9,2)         not null,
   constraint PK_PXI primary key (INGCODIGO, PROCODIGO)
);


/*==============================================================*/
/* Table: PXO                                                   */
/*==============================================================*/
create table PXO (
   OCNUMERO             CHAR(9)              not null,
   PROCODIGO            CHAR(9)              not null,
   PXCCANTIDAD          NUMERIC(9,2)         not null,
   PXCVALOR             NUMERIC(7,2)         not null,
   PXCSUBTOTAL          NUMERIC(9,2)         not null,
   PXCSTATUS            CHAR(3)              not null,
   constraint PK_PXO primary key (OCNUMERO, PROCODIGO)
);

/*==============================================================*/
/* Table: PXS                                                   */
/*==============================================================*/
create table PXS (
   SALCODIGO            INT4                 not null,
   PROCODIGO            CHAR(9)              not null,
   PXSCANTIDAD          NUMERIC(9,2)         not null,
   constraint PK_PXS primary key (SALCODIGO, PROCODIGO)
);

/*==============================================================*/
/* Table: SALIDAS                                               */
/*==============================================================*/
create table SALIDAS (
   SALCODIGO           int4             not null,
   EMPCODIGO            CHAR(7)              not null,
   SALDESCRIPCION       CHAR(30)             not null,
   SALFECHA             DATE                 not null,
   SALCANTIDADTOTAL     NUMERIC(9,2)         null,
   SALREFERENCIA        CHAR(60)             null,
   constraint PK_SALIDAS primary key (SALCODIGO)
);

/*==============================================================*/
/* CONSTRAINTS foreing KEYS                                     */
/*==============================================================*/

alter table AJUSTES
   add constraint FK_AJUSTES_AUTORIZA_EMPLEADO foreign key (EMPCODIGO)
      references EMPLEADOS (EMPCODIGO)
      on delete restrict on update restrict;

alter table BXN
   add constraint FK_BXN_BXN_NOMINAS foreign key (NOMCODIGO)
      references NOMINAS (NOMCODIGO)
      on delete restrict on update restrict;

alter table BXN
   add constraint FK_BXN_BXN2_BONIFICA foreign key (BONCODIGO)
      references BONIFICACIONES (BONCODIGO)
      on delete restrict on update restrict;

alter table COMPRAS
   add constraint FK_COMPRAS_PROVEE_PROVEEDO foreign key (PRVCODIGO)
      references PROVEEDORES (PRVCODIGO)
      on delete restrict on update restrict;

alter table DXN
   add constraint FK_DXN_DXN_DESCUENT foreign key (DESCODIGO)
      references DESCUENTOS (DESCODIGO)
      on delete restrict on update restrict;

alter table DXN
   add constraint FK_DXN_DXN2_NOMINAS foreign key (NOMCODIGO)
      references NOMINAS (NOMCODIGO)
      on delete restrict on update restrict;

alter table FACTURAS
   add constraint FK_FACTURAS_ADQUIERE_CLIENTES foreign key (CLICODIGO)
      references CLIENTES (CLICODIGO)
      on delete restrict on update restrict;

alter table INGRESOS
   add constraint FK_INGRESOS_RESPONDEX_EMPLEADO foreign key (EMPCODIGO)
      references EMPLEADOS (EMPCODIGO)
      on delete restrict on update restrict;

alter table NOMINAS
   add constraint FK_NOMINAS_MANTIENE_EMPLEADO foreign key (EMPCODIGO)
      references EMPLEADOS (EMPCODIGO)
      on delete restrict on update restrict;

alter table PXA
   add constraint FK_PXA_PXA_PRODUCTO foreign key (PROCODIGO)
      references PRODUCTOS (PROCODIGO)
      on delete restrict on update restrict;

alter table PXA
   add constraint FK_PXA_PXA2_AJUSTES foreign key (AJUCODIGO)
      references AJUSTES (AJUCODIGO)
      on delete restrict on update restrict;

alter table PXF
   add constraint FK_PXF_PXF_PRODUCTO foreign key (PROCODIGO)
      references PRODUCTOS (PROCODIGO)
      on delete restrict on update restrict;

alter table PXF
   add constraint FK_PXF_PXF2_FACTURAS foreign key (FACNUMERO)
      references FACTURAS (FACNUMERO)
      on delete restrict on update restrict;

alter table PXI
   add constraint FK_PXI_PXI_PRODUCTO foreign key (PROCODIGO)
      references PRODUCTOS (PROCODIGO)
      on delete restrict on update restrict;

alter table PXI
   add constraint FK_PXI_PXI2_INGRESOS foreign key (INGCODIGO)
      references INGRESOS (INGCODIGO)
      on delete restrict on update restrict;

alter table PXO
   add constraint FK_PXO_PXO_PRODUCTO foreign key (PROCODIGO)
      references PRODUCTOS (PROCODIGO)
      on delete restrict on update restrict;

alter table PXO
   add constraint FK_PXO_PXO2_COMPRAS foreign key (OCNUMERO)
      references COMPRAS (OCNUMERO)
      on delete restrict on update restrict;

alter table PXS
   add constraint FK_PXS_PXS_PRODUCTO foreign key (PROCODIGO)
      references PRODUCTOS (PROCODIGO)
      on delete restrict on update restrict;

alter table PXS
   add constraint FK_PXS_PXS2_SALIDAS foreign key (SALCODIGO)
      references SALIDAS (SALCODIGO)
      on delete restrict on update restrict;

alter table SALIDAS
   add constraint FK_SALIDAS_DISPONE_EMPLEADO foreign key (EMPCODIGO)
      references EMPLEADOS (EMPCODIGO)
      on delete restrict on update restrict;

/*==============================================================*/
/* CREATE UNIQUE Index                                          */
/*==============================================================*/
create unique index AJUSTES_PK on AJUSTES (AJUCODIGO);
create unique index SALIDAS_PK on SALIDAS (SALCODIGO);
create unique index PXS_PK on PXS (SALCODIGO, PROCODIGO);
create unique index PXO_PK on PXO (OCNUMERO, PROCODIGO);
create unique index PXI_PK on PXI (INGCODIGO,PROCODIGO);
create unique index PXF_PK on PXF (FACNUMERO,PROCODIGO);
create unique index BONIFICACIONES_PK on BONIFICACIONES (BONCODIGO);
create unique index PXA_PK on PXA (AJUCODIGO,PROCODIGO);
create unique index PROVEEDORES_PK on PROVEEDORES (PRVCODIGO);
create unique index PRODUCTOS_PK on PRODUCTOS (PROCODIGO);
create unique index NOMINAS_PK on NOMINAS (NOMCODIGO);
create unique index INGRESOS_PK on INGRESOS (INGCODIGO);
create unique index FACTURAS_PK on FACTURAS (FACNUMERO);
create unique index EMPLEADOS_PK on EMPLEADOS (EMPCODIGO);
create unique index BXN_PK on BXN (BONCODIGO,NOMCODIGO);
create unique index CLIENTES_PK on CLIENTES (CLICODIGO);
create unique index COMPRAS_PK on COMPRAS (OCNUMERO);
create unique index DESCUENTOS_PK on DESCUENTOS (DESCODIGO);
create unique index DXN_PK on DXN (NOMCODIGO,DESCODIGO);


/*==============================================================*/
/* CREATE Index                                                 */
/*==============================================================*/
create  index AUTORIZA_FK on AJUSTES (EMPCODIGO);
create  index DISPONE_FK on SALIDAS (EMPCODIGO);
create  index PXS2_FK on PXS (SALCODIGO);
create  index PXS_FK on PXS (PROCODIGO);
create  index PXO2_FK on PXO (OCNUMERO);
create  index PXO_FK on PXO (PROCODIGO);
create  index PXI2_FK on PXI (INGCODIGO);
create  index PXI_FK on PXI (PROCODIGO);
create  index PXF2_FK on PXF (FACNUMERO);
create  index PXF_FK on PXF (PROCODIGO);
create  index PXA2_FK on PXA (AJUCODIGO);
create  index PXA_FK on PXA (PROCODIGO);
create  index MANTIENE_FK on NOMINAS (EMPCODIGO);
create  index RESPONDEX_FK on INGRESOS (EMPCODIGO);
create  index ADQUIERE_FK on FACTURAS (CLICODIGO);
create  index BXN2_FK on BXN (BONCODIGO);
create  index BXN_FK on BXN (NOMCODIGO);
create  index PROVEE_FK on COMPRAS (PRVCODIGO);
create  index DXN2_FK on DXN (NOMCODIGO);
create  index DXN_FK on DXN (DESCODIGO);

insert into PRODUCTOS values ('P-0001', 'CEREAL TRIGO ENTERO',        'QQ ', 0, 0, 0, 0, 0, 1, 2, 'ACT');
insert into PRODUCTOS values ('P-0002', 'MORA FRUTO COMPLETO',        'CAJ', 0, 0, 0, 0, 0, 1, 2, 'ACT');
insert into PRODUCTOS values ('P-0003', 'CARNE DE CERDO CON HUESO',   'KG ', 0, 0, 0, 0, 0, 1, 2, 'ACT');
insert into PRODUCTOS values ('P-0004', 'SARDINAS EN CONSERVA',       'PAQ', 0, 0, 0, 0, 0, 1, 2, 'ACT');
insert into PRODUCTOS values ('P-0005', 'LECHE LÍQUIDA PASTEURIZADA', 'LIT', 0, 0, 0, 0, 0, 1, 2, 'ACT');
insert into PRODUCTOS values ('P-0006', 'ATÚN EN CONSERVA ',          'UNI', 0, 0, 0, 0, 0, 1, 2, 'ACT');
INSERT INTO productos VALUES ('P-0007', 'LECHE ENTERA', 'LT', 7, 4, 7, 70, 700, 1.00, 110, 'ACT');
INSERT INTO productos VALUES ('P-0008', 'JUGO DE NARANJA', 'LT', 8, 4, 8, 80, 800, 2.50, 120, 'ACT');
INSERT INTO productos VALUES ('P-0009', 'PAN INTEGRAL', 'UN', 9, 5, 9, 90, 900, 0.80, 130, 'ACT');
INSERT INTO productos VALUES ('P-0010', 'MERMELADA DE FRESA', 'GR', 10, 5, 10, 100, 1000, 4.00, 140, 'ACT');

insert into PROVEEDORES  values ('PRV-010', 'CORPORACION FAVORITA C.A.', '1702996501', 'Sangolquí Av. 6 de Diciembre y Julio Moreno Quito - Ecuador', '02-2996500', '0992996500', 'ventas@favorita.com.ec'      , 'JUR', 'ACT');
insert into PROVEEDORES  values ('PRV-020', 'CORPORACION EL ROSADO SA.', '0702996502', 'Centro Av. 9 De Octubre 729 y Boyacá Guayaquil - Ecuador'   , '02-2980980', '0992996500', 'ventas@elrosado.com.ec'      , 'JUR', 'ACT');
insert into PROVEEDORES  values ('PRV-030', 'INDUSTRIAL PESQUERA SANTA', '1402996503', 'Vía Daule Km 5 1/2 y Calle Sèptima Guayaquil - Ecuador'     , '04-2322000', '0992996500', 'ventas@santa_priscila.com.ec', 'JUR', 'ACT');
insert into PROVEEDORES  values ('PRV-040', 'ECUACORRIENTE S. A.'     , '0602996504', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales'   , '04-6005238', '0992996500', 'ventas@ecuacorriente.ec'     , 'JUR', 'ACT');
insert into PROVEEDORES  values ('PRV-050', 'DINADEC S.A.'            , '1902996505', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales'   , '04-5004040', '0992996500', 'ventas@danec.ec'             , 'JUR', 'ACT');
insert into PROVEEDORES  values ('PRV-060', 'DISTRIBUIDORA FARMACEUTI', '2102996506', 'Cdla. Santa Leonor, Mz. 6, solar 17 Guayaquil - Ecuador'    , '04-5004040', '0992996500', 'ventas@difare.com.ec'        , 'JUR', 'ACT');
INSERT INTO proveedores VALUES ('PRV-070', 'JUGOS NATURALES ECUA', '0612666501', 'San Antonio av. Equinoccial y pucara', '04-1105249', '0992996500', 'ventas@jugosnaturales.ec', 'JUR', 'ACT');
INSERT INTO proveedores VALUES ('PRV-080', 'INDUSTRIAS LÁCTEAS ANDINA', '0602996505', 'Av. de los Granados, Quito - Ecuador', '02-3005000', '0993005000', 'ventas@andina.ec', 'JUR', 'ACT');
INSERT INTO proveedores VALUES ('PRV-090', 'PRODUCTOS ALIMENTICIOS ', '0602996506', 'Av. Simón Bolívar, Quito', '02-4006000', '0994006000', 'ventas@superior.ec', 'JUR', 'ACT');
INSERT INTO proveedores VALUES ('PRV-100', 'GRUPO GLORIA', '0602996507', 'Calle 10 de Agosto y Los Shyris, Quito - Ecuador', '02-5007000', '0995007000', 'ventas@grupogloria.ec', 'JUR', 'ACT');

insert into CLIENTES values ('CLI-001', 'CORPORACION FAVORITA C.A.', '1702996501', 'Sangolquí Av. 6 de Diciembre y Julio Moreno Quito - Ecuador', '02-2996500', '0992996500', 'ventas@favorita.com.ec'      , 'JUR', 'ACT');
insert into CLIENTES values ('CLI-002', 'CÓNDOR JAVIER'            , '0702996502', 'Centro Av. 9 De Octubre 729 y Boyacá Guayaquil - Ecuador'   , '02-2980980', '0992996500', 'ventas@elrosado.com.ec'      , 'NAT', 'ACT');
insert into CLIENTES values ('CLI-003', 'INDUSTRIAL PESQUERA SANTA', '1402996503', 'Vía Daule Km 5 1/2 y Calle Sèptima Guayaquil - Ecuador'     , '04-2322000', '0992996500', 'ventas@santa_priscila.com.ec', 'JUR', 'ACT');
insert into CLIENTES values ('CLI-004', 'PAMELA CORTEZ'           , '0602996504', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales'   , '04-6005238', '0992996500', 'ventas@ecuacorriente.ec'     , 'NAT', 'ACT');
insert into CLIENTES values ('CLI-005', 'DINADEC S.A.'            , '1902996505', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales'   , '04-5004040', '0992996500', 'ventas@danec.ec'             , 'JUR', 'ACT');
insert into CLIENTES values ('CLI-006', 'VERONICA ANTONELA FRITZ' , '2102996506', 'Cdla. Santa Leonor, Mz. 6, solar 17 Guayaquil - Ecuador'    , '04-5004040', '0992996500', 'ventas@difare.com.ec'        , 'NAT', 'ACT');
INSERT INTO clientes VALUES ('CLI-007', 'EL ROSADO', '1799996501', 'Sangolquí Av. 6 de Diciembre y Julio Moreno Quito - Ecuador', '06-3996598', '0952998500', 'ventas@rosado.com.ec', 'JUR', 'ACT');
INSERT INTO clientes VALUES ('CLI-008', 'MEGAMAXI', '1701234567', 'Av. De Los Shyris y Av. El Inca, Quito - Ecuador', '02-1234567', '0991234567', 'contacto@megamaxi.com.ec', 'JUR', 'ACT');
INSERT INTO clientes VALUES ('CLI-009', 'SUPERMERCADOS SANTA MARIA', '1707654321', 'Av. Amazonas y NNUU, Quito - Ecuador', '02-7654321', '0997654321', 'ventas@santamaria.com.ec', 'JUR', 'ACT');
INSERT INTO clientes VALUES ('CLI-010', 'TIENDAS INDUSTRIALES ASOCIADAS', '1701122334', 'Av. América y Naciones Unidas, Quito - Ecuador', '02-1122334', '0991122334', 'ventas@tia.com.ec', 'JUR', 'ACT');

INSERT INTO EMPLEADOS VALUES ('EMP-111', 'CONDOR', 'CRUZ', 'JAVIER', 'WILFRIDO', '1965-09-04', 'H', 'jwcondor@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT', NULL);
INSERT INTO EMPLEADOS VALUES ('EMP-222', 'ARCOS', 'VILLAGOMEZ', 'SUYANA', 'FABIOLA', '1975-06-14', 'M', 'sarcos@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT', NULL);
INSERT INTO EMPLEADOS VALUES ('EMP-333', 'CASTRO', 'DE LA CRUZ', 'FABIAN', 'IGNACIO', '1985-03-24', 'H', 'fcastro@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT', NULL);
INSERT INTO EMPLEADOS VALUES ('EMP-444', 'MASAPANTA', 'LIZ', 'SUSANA', 'MARGARITA', '1995-12-14', 'M', 'smasapanta@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT', NULL);
INSERT INTO EMPLEADOS VALUES ('EMP-555', 'CANDO', 'CANDO', 'WILSON', 'ALFREDO', '2000-09-04', 'H', 'wcando@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT', NULL);
INSERT INTO EMPLEADOS VALUES ('EMP-666', 'CHICAIZA', 'VALLADARES', 'ROSA', 'ELVIA', '2000-06-14', 'M', 'rechicaiza@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT', NULL);
INSERT INTO EMPLEADOS VALUES ('EMP-777', 'SAAVEDRA', 'NACATO', 'CARLOS', 'SAAVEDRA', '1944-03-02', 'H', 'saavedra@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT', NULL);
INSERT INTO EMPLEADOS VALUES ('EMP-888', 'VERA', 'LOPEZ', 'MARTA', 'ALEJANDRA', '1978-03-21', 'M', 'mavera@puce.edu.ec', 'Quito, La Carolina, Av. Amazonas', 'A+', 1300, 'BANCO PICHINCHA', 'CTA 0620704664', 'ACT', NULL);
INSERT INTO EMPLEADOS VALUES ('EMP-999', 'SANCHEZ', 'PEREZ', 'CARLOS', 'EDUARDO', '1982-11-30', 'H', 'cesanchez@puce.edu.ec', 'Quito, El Inca, Av. 6 de Diciembre', 'O-', 1450, 'BANCO GUAYAQUIL', 'CTA 0630704665', 'ACT', NULL);
INSERT INTO EMPLEADOS VALUES ('EMP-000', 'GARCIA', 'TORRES', 'MARIA', 'JOSE', '1990-06-15', 'M', 'mjgarcia@puce.edu.ec', 'Quito, Centro Histórico, Calle Bolívar', 'B+', 1200, 'BANCO PRODUBANCO', 'CTA 0640704666', 'ACT', NULL);

insert into NOMINAS  values ('NOM0001', 'EMP-111', '   4', ' 2', '1-1-1', '1017-9-6', '  0');
insert into NOMINAS  values ('NOM0002', 'EMP-555', '    ', ' 3', '927-10-8', '1376-11-7', '  1');
insert into NOMINAS  values ('NOM0003', 'EMP-111', '   0', ' 4', '1556-7-23', '1-1-1', '  2');
insert into NOMINAS  values ('NOM0004', 'EMP-333', '   1', '  ', '448-7-4', '1571-7-11', '  3');
insert into NOMINAS  values ('NOM0005', 'EMP-555', '   2', ' 0', '1945-8-8', '341-4-12', '  4');
insert into NOMINAS  values ('NOM0006', 'EMP-222', '   3', ' 1', '1105-7-15', '613-10-29', '   ');

insert into BONIFICACIONES  values ('B1010', 'Fondo de Reserva Mensualizado', 145);
insert into BONIFICACIONES  values ('B1020', 'Bono 20 anios de servicio', 200);
insert into BONIFICACIONES  values ('B1030', 'Bono 25 anios de servicio', 250);
insert into BONIFICACIONES  values ('B1040', 'Bono 30 anios de servicio', 300);
insert into BONIFICACIONES  values ('B1050', 'Bono publicación scopus', 500);
insert into BONIFICACIONES  values ('B1060', 'Bono horas extra', 100);

insert into DESCUENTOS  values ('D2010', 'Aporte Personal IESS', 333);
insert into DESCUENTOS  values ('D2020', 'Aporte Personal FIDEICOMISO', 555);
insert into DESCUENTOS  values ('D2030', 'Aporte Personal Seguro Cancer', 444);
insert into DESCUENTOS  values ('D2040', 'Aporte Personal Seguro Medico', 111);
insert into DESCUENTOS  values ('D2050', 'Aporte Personal Seguro de Vida', 10);
insert into DESCUENTOS  values ('D2060', 'Aporte APPUCE', 28);

insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1010', 'NOM0001', 1, '  4');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1020', 'NOM0002', 5, '   ');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1030', 'NOM0003', 2, '  0');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1040', 'NOM0004', 3, '  1');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1050', 'NOM0005', 4, '  2');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1060', 'NOM0006', 0, '  3');

insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0001', 'D2010', 2, '   ');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0002', 'D2020', 4, '  0');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0003', 'D2030', 3, '  1');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0004', 'D2040', 1, '  2');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0005', 'D2050', 0, '  3');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0006', 'D2060', 5, '  4');

insert into INGRESOS values (5, 'EMP-111', '398CROUREDDM115PH16M43TRJ2 75B', '443-11-28', 0, '31W4IIA74J4LBI91QPLUG YCIJGAWBEPFNYY5TRPUH8BTUAELI1315RX93 4');
insert into INGRESOS values (1, 'EMP-222', '0DWW3OW5DAP7T3KM 1XQI1MOECRCU ', '1-1-1', 1, 'AY33I3UUN1OWWROWT44GERG5WA6YVRIMUG59BY5KT6O7QKWM2YPT40MW0X2 ');
insert into INGRESOS values (0, 'EMP-333', 'H9ME19XKLDMS6WFSKF73Y39W0PIP7R', '759-10-13', 2, '71M69ONKVN8L7YDQIKNQ0V2E LLCRPL4CQI66RGN9L6VBHKO00SHA64M G I');
insert into INGRESOS values (4, 'EMP-222', '8K 51430R3OQ7GHAQDHURKQHI KXAW', '273-10-28', 5, 'SYLW2RC11IF57P2BF2CG0YGIIOGYFDT6BAP99 V9H1CQN8838LXUU8KLDU1 ');
insert into INGRESOS values (3, 'EMP-222', 'QKY59G9J44QONMLEHNWEX8YIRUV22I', '1504-9-26', 3, 'Y03J5RN029EGTYUP3LE5ERDR0JDJNBUM  4WAO26AH5UET8Q XD7T2 7O5I ');
insert into INGRESOS values (2, 'EMP-222', 'MWL4O8DAOABWE DX4KUV76FVD7X9VT', '1171-9-6', 4, 'OQ07W3MS14IMX9FORD3X1HRH7O6IGES RQF2YUJYW0D84HYQBUQ726WO8HF3');

insert into COMPRAS values ('OC202301', 'PRV-010', '685-2-9', 2, 5, 5, 1, 'VYG4G', 'LGV724R 2E2RSIU  1PI1GM7PIPGVG', '  2');
insert into COMPRAS values ('OC0002', 'PRV-030', '337-12-24', 3, 4, 3, 5, 'Y65KI', 'E11J4M5B9M6FJLWM0LBCS4NW20 0JU', '  4');
insert into COMPRAS values ('OC-003', 'PRV-030', '1603-7-22', 0, 0, 2, 0, 'RDUJA', 'A7Y7WJSN1S15RNBUO0990W57UQWBLP', '  0');
insert into COMPRAS values ('OC202304', 'PRV-060', '689-3-3', 3, 6, 4, 1, 'WME5P', 'NAB586Q 3F4ATYG  1PQTJH6PQGMGN', '  3');
insert into COMPRAS values ('OC202305', 'PRV-100', '690-4-4', 4, 7, 3, 1, 'HGN3R', 'OLM828P 4B3QSAU  1LZKFL7LZFKFO', '  4');
insert into COMPRAS values ('OC202306', 'PRV-010', '691-5-5', 5, 8, 2, 1, 'PGH2T', 'GKD647O 5G4CVBT  1ZVGHM1ZVHGMZ', '  5');
insert into COMPRAS values ('OC202307', 'PRV-070', '692-6-6', 6, 9, 1, 1, 'AKL9S', 'HMD426N 6W5DRCU  1MGKIN1MGINKM', '  6');
insert into COMPRAS values ('OC202308', 'PRV-010', '692-6-6', 6, 9, 3, 1, 'GHW3R', 'FJD648P 6H4EYUR  1YXHUN1YXHUNY', '  6');
insert into COMPRAS values ('OC202309', 'PRV-020', '693-7-7', 7, 10, 4, 1, 'LSK5F', 'HND649Q 7U4GTRW  1ZWJOH1ZWJOHZ', '  7');
insert into COMPRAS values ('OC202310', 'PRV-030', '694-8-8', 8, 11, 5, 1, 'KJS6E', 'IOD650R 8I4HTES  1AXJPW1AXJPWX', '  8');
insert into COMPRAS values ('OC202311', 'PRV-040', '695-9-9', 9, 12, 6, 1, 'JDN7R', 'JPE651S 9J4IUFV  1BYKOI1BYKOIA', '  9');
insert into COMPRAS values ('OC202312', 'PRV-050', '696-1-5', 10, 13, 7, 1, 'EHR8D', 'KQF652T 0K4JVGX  1CXJBN1CXJBNC', ' 10');
insert into COMPRAS values ('OC202313', 'PRV-060', '697-1-1', 11, 14, 8, 1, 'WNE9E', 'LPG653U 1L4KWHY  1DXMOK1DXMOKD', ' 11');
insert into COMPRAS values ('OC202314', 'PRV-070', '698-1-2', 12, 15, 9, 1, 'XFI0F', 'MQH654V 2M4LXIZ  1EYNPL1EYNPLE', ' 12');
insert into COMPRAS values ('OC202315', 'PRV-080', '699-1-3', 13, 16, 10, 1, 'YGJ1G', 'NRI655W 3N4MYJA  1FZOQM1FZOQMF', ' 13');
insert into COMPRAS values ('OC202316', 'PRV-090', '700-1-4', 14, 17, 11, 1, 'ZHK2H', 'OSJ656X 4O4NZKB  1GAPRN1GAPRNG', ' 14');
insert into COMPRAS values ('OC202317', 'PRV-100', '701-1-5', 15, 18, 12, 1, 'AIL3I', 'PTK657Y 5P4OALC  1HBQSO1HBQSOM', ' 15');
insert into COMPRAS values ('OC202318', 'PRV-010', '702-1-6', 1, 19, 13, 1, 'BJM4J', 'QUL658Z 6Q4PBMD  1ICRPV1ICRPVH', ' 16');
insert into COMPRAS values ('OC202319', 'PRV-010', '703-1-7', 2, 20, 14, 1, 'CKN5K', 'RVM659A 7R4QCNF  1JDQSW1JDQSWI', ' 17');
insert into COMPRAS values ('OC202320', 'PRV-030', '704-1-8', 3, 21, 15, 1, 'DLO6L', 'SWN660B 8S4RDOG  1KERXT1KERXTJ', ' 18');
insert into COMPRAS values ('OC202321', 'PRV-040', '705-1-9', 4, 22, 16, 1, 'EMP7M', 'TXO661C 9T4SEPH  1LFYSU1LFYSUL', ' 19');
insert into COMPRAS values ('OC202322', 'PRV-050', '706-1-6', 5, 23, 17, 1, 'FNQ8N', 'UYP662D 0U4TFQI  1MGZTV1MGZTVI', ' 20');
insert into COMPRAS values ('OC202323', 'PRV-060', '707-1-1', 6, 24, 18, 1, 'GOR9O', 'VZQ663E 1V4UGRJ  1NHAWU1NHAWUJ', ' 21');
insert into COMPRAS values ('OC202324', 'PRV-070', '708-1-2', 7, 25, 19, 1, 'HPS0P', 'WAR664F 2W4VHSK  1OIBXV1OIBXVK', ' 22');
insert into COMPRAS values ('OC202325', 'PRV-080', '709-1-3', 8, 26, 20, 1, 'IQT1Q', 'XBS665G 3X4WHSL  1PJCYW1PJCYWL', ' 23');
insert into COMPRAS values ('OC202326', 'PRV-090', '710-1-4', 9, 27, 21, 1, 'JRU2R', 'YCT666H 4Y4XITM  1QKDZX1QKDZXK', ' 24');
insert into COMPRAS values ('OC202327', 'PRV-100', '711-1-5', 10, 28, 22, 1, 'KSV3S', 'ZDU667I 5Z4YJUN  1RLEAY1RLEAYL', ' 25');
insert into COMPRAS values ('OC202328', 'PRV-020', '712-1-6', 11, 29, 23, 1, 'LTW4T', 'AEV668J 6A4ZKVO  1SMFBZ1SMFBZM', ' 26');
insert into COMPRAS values ('OC202329', 'PRV-020', '713-1-7', 12, 30, 24, 1, 'MUX5U', 'BFW669K 7B5ALWP  1TNGBA1TNGBAN', ' 27');
insert into COMPRAS values ('OC202330', 'PRV-030', '714-1-8', 13, 31, 25, 1, 'NVY6V', 'CGX670L 8C5BMXQ  1UOHCB1UOHCBO', ' 28');
insert into COMPRAS values ('OC202331', 'PRV-040', '715-1-9', 14, 32, 26, 1, 'OWZ7W', 'DHY671M 9D5CNYR  1VPIDC1VPIDC1', ' 29');
insert into COMPRAS values ('OC202332', 'PRV-050', '716-1-5', 15, 33, 27, 1, 'PX08X', 'EIZ672N 0E5DOZS  1WQJED1WQJED2', ' 30');
insert into COMPRAS values ('OC202333', 'PRV-060', '717-1-1', 16, 34, 28, 1, 'QY19Y', 'FJA673O 1F5EPAT  1XRKFE1XRKFE3', ' 31');
insert into COMPRAS values ('OC202334', 'PRV-070', '718-1-2', 17, 35, 29, 1, 'RZ2AZ', 'GKB674P 2G5FQBZ  1YSLGF1YSLGF4', ' 32');
insert into COMPRAS values ('OC202335', 'PRV-080', '719-1-3', 18, 36, 30, 1, 'SA3B0', 'HLC675Q 3H5GRCA  1ZTMHG1ZTMHG5', ' 33');
insert into COMPRAS values ('OC202336', 'PRV-090', '720-1-4', 19, 37, 31, 1, 'TB4C1', 'IMD676R 4I5HSDB  1AUNHI1AUNHI6', ' 34');
insert into COMPRAS values ('OC202337', 'PRV-030', '721-1-5', 20, 38, 32, 1, 'UC5D2', 'JNE677S 5J5ITEC  1BVUIJ1BVUIJ7', ' 35');
insert into COMPRAS values ('OC202338', 'PRV-010', '722-1-6', 21, 39, 33, 1, 'VD6E3', 'KOF678T 6K5JUFD  1CWVJK1CWVJK8', ' 36');
insert into COMPRAS values ('OC202339', 'PRV-020', '723-1-7', 22, 40, 34, 1, 'WE7F4', 'LPG679U 7L5KVGE  1DXWKQ1DXWKQ9', ' 37');
insert into COMPRAS values ('OC202340', 'PRV-030', '724-1-8', 23, 41, 35, 1, 'XF8G5', 'MQH680V 8M5LWHF  1EYXLR1EYXLR0', ' 38');
insert into COMPRAS values ('OC202341', 'PRV-040', '725-1-9', 24, 42, 36, 1, 'YG9H6', 'NRI681W 9N5MXIG  1FZYMS1FZYMS1', ' 39');
insert into COMPRAS values ('OC202342', 'PRV-050', '726-1-9', 25, 43, 37, 1, 'ZHAI7', 'OSJ682X 0O5NYJH  1GAZNT1GAZNT2', ' 40');
insert into COMPRAS values ('OC202343', 'PRV-060', '727-1-1', 26, 44, 38, 1, 'AIBJ8', 'PTK683Y 1P5OZKI  1HBAOU1HBAOU3', ' 41');
insert into COMPRAS values ('OC202344', 'PRV-070', '728-1-2', 27, 45, 39, 1, 'BJCK9', 'QUL684Z 2Q5PALK  1ICBPV1ICBPV4', ' 42');
insert into COMPRAS values ('OC202345', 'PRV-080', '729-1-3', 28, 46, 40, 1, 'CKDL0', 'RVM6850 3R5QBMN  1JDACW1JDACW5', ' 43');
insert into COMPRAS values ('OC202346', 'PRV-090', '730-1-4', 29, 47, 41, 1, 'DL1EM', 'SWN6861 4S5RCNO  1KEBDX1KEBDX6', ' 44');
insert into COMPRAS values ('OC202347', 'PRV-040', '731-1-5', 30, 48, 42, 1, 'EM2FN', 'TXO6872 5T5SDOP  1LFCEY1LFCEY7', ' 45');
insert into COMPRAS values ('OC202348', 'PRV-010', '732-1-6', 31, 49, 43, 1, 'FN3GO', 'UYP6883 6U5TEPQ  1MGDFZ1MGDFZ8', ' 46');
insert into COMPRAS values ('OC202349', 'PRV-020', '733-1-7', 32, 50, 44, 1, 'GO4HP', 'VZQ6894 7V5UFQR  1NHEGA1NHEGA9', ' 47');
insert into COMPRAS values ('OC202350', 'PRV-030', '734-1-8', 33, 51, 45, 1, 'HP5IQ', 'W0R6905 8W5VGRS  1OIFHB1OIFHB0', ' 48');
insert into COMPRAS values ('OC202351', 'PRV-040', '735-1-9', 34, 52, 46, 1, 'IQ6JR', 'X1S6916 9X5WHST  1PJGIC1PJGIC1', ' 49');
insert into COMPRAS values ('OC202352', 'PRV-100', '736-1-6', 35, 53, 47, 1, 'JR7KS', 'Y2T6927 0Y5XIUT  1QKHKJ1QKHKJ2', ' 50');
insert into COMPRAS values ('OC202353', 'PRV-060', '737-1-1', 36, 54, 48, 1, 'KS8LT', 'Z3U6938 1Z5YJUV  1RLILK1RLILK3', ' 51');
insert into COMPRAS values ('OC202354', 'PRV-070', '738-1-2', 37, 55, 49, 1, 'LT9MU', '1046949 2A5ZKVW  1SMJML1SMJML4', ' 52');
insert into COMPRAS values ('OC202355', 'PRV-080', '739-1-3', 38, 56, 50, 1, 'MV0NV', '2157050 3B5ALWX  1TNKNM1TNKNM5', ' 53');
insert into COMPRAS values ('OC202356', 'PRV-090', '740-1-4', 39, 57, 51, 1, 'NW1OW', '3267151 4C5BMXY  1UOLNN1UOLNN6', ' 54');
insert into COMPRAS values ('OC202357', 'PRV-100', '741-1-5', 40, 58, 52, 1, 'OX2PX', '4377252 5D5CNYZ  1VPOMO1VPOMO7', ' 55');
insert into COMPRAS values ('OC202358', 'PRV-010', '742-1-6', 41, 59, 53, 1, 'PY3QY', '5487353 6E5DOZA  1WPPLP1WPPLP8', ' 56');
insert into COMPRAS values ('OC202359', 'PRV-020', '743-1-7', 42, 60, 54, 1, 'QZ4RZ', '6597454 7F5EPAB  1XQQMQ1XQQMQ9', ' 57');
insert into COMPRAS values ('OC202360', 'PRV-030', '744-1-8', 43, 61, 55, 1, 'RA5SA', '7607555 8G5FQBC  1YRRNR1YRRNR0', ' 58');
insert into COMPRAS values ('OC202361', 'PRV-040', '745-1-9', 44, 62, 56, 1, 'SB6TB', '8717656 9H5GRCD  1ZSSOS1ZSSOS1', ' 59');
insert into COMPRAS values ('OC202362', 'PRV-050', '746-1-5', 45, 63, 57, 1, 'TC7UC', '9827757 0I5HSDE  1ATTPT1ATTPT2', ' 60');
insert into COMPRAS values ('OC202363', 'PRV-060', '747-1-1', 46, 64, 58, 1, 'UD8VD', '0937858 1J5ITED  1BUUQU1BUUQU3', ' 61');
insert into COMPRAS values ('OC202364', 'PRV-070', '748-1-2', 47, 65, 59, 1, 'VE9WE', '1047959 2K5JUEF  1CVVRV1CVVRV4', ' 62');
insert into COMPRAS values ('OC202365', 'PRV-100', '749-1-3', 48, 66, 60, 1, 'WF0XF', '2158060 3L5KVFG  1DWWFW1DWWFW5', ' 63');
insert into COMPRAS values ('OC202366', 'PRV-100', '750-1-4', 49, 67, 61, 1, 'XG1YG', '3268161 4M5LWGH  1EXXGX1EXXGX6', ' 64');
insert into COMPRAS values ('OC202367', 'PRV-060', '751-1-5', 50, 68, 62, 1, 'ZH2ZH', '4378262 5N5MXHI  1FYYHY1FYYHY7', ' 65');
insert into COMPRAS values ('OC202368', 'PRV-010', '752-1-6', 51, 69, 63, 1, 'AI3AI', '5488363 6O5NYIJ  1GZZIZ1GZZIZ8', ' 66');
insert into COMPRAS values ('OC202369', 'PRV-020', '753-1-7', 52, 70, 64, 1, 'BJ4BJ', '6598464 7P5OZJK  1HAAJH1HAAJH9', ' 67');
insert into COMPRAS values ('OC202370', 'PRV-030', '754-1-8', 53, 71, 65, 1, 'CK5CK', '7608565 8Q5PAKL  1IBBKI1IBBKI0', ' 68');
insert into COMPRAS values ('OC202371', 'PRV-040', '755-1-9', 54, 72, 66, 1, 'DL6DL', '8718666 9R5QBML  1JCCNJ1JCCNJ1', ' 69');
insert into COMPRAS values ('OC202372', 'PRV-050', '756-1-4', 55, 73, 67, 1, 'EM7EM', '9828767 0S5RCNM  1KDOKK1KDOKK2', ' 70');
insert into COMPRAS values ('OC202373', 'PRV-060', '757-1-1', 56, 74, 68, 1, 'FN8FN', '0938868 1T5SDON  1LEPLL1LEPLL3', ' 71');
insert into COMPRAS values ('OC202374', 'PRV-070', '758-1-2', 57, 75, 69, 1, 'GO9GO', '1048969 2U5TEPO  1MFMMM1MFMMM4', ' 72');
insert into COMPRAS values ('OC202375', 'PRV-080', '759-1-3', 58, 76, 70, 1, 'HP0HP', '2159070 3V5UFQP  1NGNNN1NGNNN5', ' 73');
insert into COMPRAS values ('OC202376', 'PRV-090', '760-1-4', 59, 77, 71, 1, 'IQ1IQ', '3269171 4W5VGQR  1OHOOO1OHOOO6', ' 74');
insert into COMPRAS values ('OC202377', 'PRV-070', '761-1-5', 60, 78, 72, 1, 'JR2JR', '4379272 5X5WHRS  1PIPPP1PIPPP7', ' 75');
insert into COMPRAS values ('OC202378', 'PRV-010', '762-1-6', 61, 79, 73, 1, 'KS3KS', '5489373 6Y5XIST  1QJQQQ1QJQQQ8', ' 76');
insert into COMPRAS values ('OC202379', 'PRV-020', '763-1-7', 62, 80, 74, 1, 'LT4LT', '6599474 7Z5YJTU  1RKRRR1RKRRR9', ' 77');
insert into COMPRAS values ('OC202380', 'PRV-030', '764-1-8', 63, 81, 75, 1, 'MU5MU', '7609575 8A5ZKUV  1SLSSS1SLSSS0', ' 78');
insert into COMPRAS values ('OC202381', 'PRV-040', '765-1-9', 64, 82, 76, 1, 'NV6NV', '8719676 9B5ALKW  1TMTTT1TMTTT1', ' 79');
insert into COMPRAS values ('OC202382', 'PRV-050', '766-1-3', 65, 83, 77, 1, 'OW7OW', '9829777 0C5BMLX  1UNUUU1UNUUU2', ' 80');
insert into COMPRAS values ('OC202383', 'PRV-060', '767-1-1', 66, 84, 78, 1, 'PX8PX', '0939878 1D5CMNY  1VOVVV1VOVVV3', ' 81');
insert into COMPRAS values ('OC202384', 'PRV-070', '768-1-2', 67, 85, 79, 1, 'QY9QY', '1049979 2E5DNOZ  1WPWWW1WPWWW4', ' 82');
insert into COMPRAS values ('OC202385', 'PRV-070', '769-1-3', 68, 86, 80, 1, 'RZ0RZ', '2150080 3F5EOP0  1XQXXX1XQXXX5', ' 83');
insert into COMPRAS values ('OC202386', 'PRV-070', '770-1-4', 69, 87, 81, 1, 'S01S0', '3260181 4W5FPQ1  1YROOO1YROOO6', ' 84');
insert into COMPRAS values ('OC202387', 'PRV-080', '771-1-5', 70, 88, 82, 1, 'T12T1', '4370282 5X5GQR2  1ZSPPP1ZSPPP7', ' 85');
insert into COMPRAS values ('OC202388', 'PRV-010', '772-1-6', 71, 89, 83, 1, 'U23U2', '5480383 6Y5HRS3  1AQQQQ1AQQQQ8', ' 86');
insert into COMPRAS values ('OC202389', 'PRV-020', '773-1-7', 72, 90, 84, 1, 'V34V3', '6590484 7Z5IST4  1BRRRR1BRRRR9', ' 87');
insert into COMPRAS values ('OC202390', 'PRV-030', '774-1-8', 73, 91, 85, 1, 'W45W4', '7600585 8A5JTS5  1CSSSS1CSSSS0', ' 88');
insert into COMPRAS values ('OC202391', 'PRV-050', '775-1-9', 74, 92, 86, 1, 'X56X5', '8710686 9B5KUV6  1DTTTT1DTTTT1', ' 89');
insert into COMPRAS values ('OC202392', 'PRV-050', '776-1-6', 75, 93, 87, 1, 'Y67Y6', '9820787 0C5ALW7  1EUUUU1EUUUU2', ' 90');
insert into COMPRAS values ('OC202393', 'PRV-060', '777-1-1', 76, 94, 88, 1, 'Z78Z7', '0930888 1D5BMX8  1FVVVV1FVVVV3', ' 91');
insert into COMPRAS values ('OC202394', 'PRV-070', '778-1-2', 77, 95, 89, 1, 'A89A8', '1040999 2E5CNY9  1GWWWW1GWWWW4', ' 92');
insert into COMPRAS values ('OC202395', 'PRV-080', '779-1-3', 78, 96, 90, 1, 'B90B9', '2151000 3F5DOZ0  1HXXXX1HXXXX5', ' 93');
insert into COMPRAS values ('OC202396', 'PRV-090', '780-1-4', 79, 97, 91, 1, 'C01C0', '3261101 4W5EOP1  1IYOOO1IYOOO6', ' 94');
insert into COMPRAS values ('OC202397', 'PRV-090', '781-1-5', 80, 98, 92, 1, 'D12D1', '4371202 5X5FPQ2  1JPPPP1JPPPP7', ' 95');
insert into COMPRAS values ('OC202398', 'PRV-010', '782-1-6', 81, 99, 93, 1, 'E23E2', '5481303 6Y5GQR3  1KQQQQ1KQQQQ8', ' 96');
insert into COMPRAS values ('OC202399', 'PRV-020', '783-1-7', 82, 100, 94, 1, 'F34F3', '6591404 7Z5HRS4  1LRRRR1LRRRR9', ' 97');
insert into COMPRAS values ('OC202400', 'PRV-010', '784-1-8', 83, 1, 95, 1, 'G45G4', '7601505 8A5IST5  1MSSSS1MSSSS0', ' 98');


insert into FACTURAS values ('FAC-001', 'CLI-001', '215-6-12', 4, 3, 5, 2, 'KUS0N', '  3');
insert into FACTURAS values ('FAC-002', 'CLI-001', '1-1-1', 3, 5, 1, 4, 'S6US3', '   ');
insert into FACTURAS values ('FAC-003', 'CLI-005', '1569-8-23', 2, 4, 3, 3, '07VBH', '  1');

insert into PXF values ('FAC-001', 'P-0001', 2, 3, 4, '  1');
insert into PXF values ('FAC-001', 'P-0002', 0, 4, 5, '  2');
insert into PXF values ('FAC-002', 'P-0003', 1, 5, 2, '  3');
insert into PXF values ('FAC-002', 'P-0004', 3, 1, 0, '  4');
insert into PXF values ('FAC-003', 'P-0005', 4, 0, 3, '   ');
insert into PXF values ('FAC-003', 'P-0006', 5, 2, 1, '  0');

insert into PXO values ('OC202301', 'P-0001', 5, 5, 4, '  2');
insert into PXO values ('OC202301', 'P-0002', 0, 3, 2, '  3');
insert into PXO values ('OC0002', 'P-0003', 4, 4, 5, '  4');
insert into PXO values ('OC0002', 'P-0004', 1, 1, 0, '   ');
insert into PXO values ('OC-003', 'P-0005', 2, 0, 3, '  0');
insert into PXO values ('OC-003', 'P-0006', 3, 2, 1, '  1');

insert into PXI values (5, 'P-0001', 1);
insert into PXI values (1, 'P-0002', 5);
insert into PXI values (0, 'P-0003', 4);
insert into PXI values (4, 'P-0004', 3);
insert into PXI values (3, 'P-0005', 2);
insert into PXI values (2, 'P-0006', 0);

insert into SALIDAS values (2, 'EMP-111', 'PDYXLBATFWT3P1VDAHXPET3E8SCF8X', '1507-12-12', 5, 'AC21NWQ HYLII0VU7 RKWDPTB3JG5PL4PQTXW3DFEU1C5TD42C0C2TQ6M82S');
insert into SALIDAS values (1, 'EMP-333', 'GT19G  JJ3LG1L72BP3KQ4LOT5I945', '1809-6-21', 0, '8HNRJV2W1LX5ANE6LC0HLN HC8OUIE6LECCN9M90IRJT6SBSEW51JGUHX8JG');
insert into SALIDAS values (5, 'EMP-555', '61MEW45WVMHK7PGEOTA I91QM49664', '1-1-1', 1, 'FAN6111THO52B6OHLLUA7SS85J NPSK255MTQNTWNI41C2VXFHGB7MD 6GSS');
insert into SALIDAS values (4, 'EMP-111', 'EWNWLG3KBVLPGO5F 55UOUQRPX8VW3', '413-4-7', 2, '8 LBA3UYFRKCF21WEWXWJ814687VYU95TUU WPI0SOFUOE4QJF8O5QJYFC2H');
insert into SALIDAS values (0, 'EMP-444', 'VE AQ XHJXCLPQMV1K 7G8JMD4P676', '881-4-21', 3, 'V9WO17NODPYLA3439 VBQ7S6LWO2P7HKROR7AT05KHBHWBBB 6VYX LXDH9 ');
insert into SALIDAS values (3, 'EMP-444', '1E7YE9QCLJY3BK607U7HU6FKR6K3SP', '1115-12-29', 4, 'NWRL3MG88F4YVN0RYOXH3NHM0 E9VK7P15MVI206CK5H3UXJTMA3MCT7E9O1');

insert into AJUSTES values (1, 'EMP-111', 'Ajuste por inundación 01', '867-4-25', 3);
insert into AJUSTES values (2, 'EMP-444', 'Ajuste por inundación 02', '1-1-1', 2);
insert into AJUSTES values (3, 'EMP-222', 'Ajuste por inundación 03', '473-2-27', 5);

insert into PXA values (1, 'P-0001', 4);
insert into PXA values (1, 'P-0002', 0);
insert into PXA values (1, 'P-0003', 3);
insert into PXA values (2, 'P-0004', 1);
insert into PXA values (2, 'P-0005', 5);
insert into PXA values (2, 'P-0006', 2);

insert into PXS values (2, 'P-0001', 4);
insert into PXS values (1, 'P-0002', 1);
insert into PXS values (5, 'P-0003', 2);
insert into PXS values (4, 'P-0004', 0);
insert into PXS values (0, 'P-0005', 5);
insert into PXS values (3, 'P-0006', 3);
