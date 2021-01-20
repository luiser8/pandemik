	--Correo *Parametrizacion General **
CREATE TABLE [dbo].[PPG_Correo]
     ( 
        CorreoId				UNIQUEIDENTIFIER			NOT NULL , 
		Asunto					VARCHAR(255)				NOT NULL ,
		De						VARCHAR(255)				NOT NULL ,
		Para					VARCHAR(255)				NOT NULL ,
		CC						VARCHAR(255)				NULL ,
		Respuesta				VARCHAR(255)				NULL ,
		Contenido				VARCHAR(255)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPG_Correo PRIMARY KEY CLUSTERED (CorreoId ASC) ON [PRIMARY]
     )		
GO
--Persona *Parametrizacion General **
CREATE TABLE [dbo].[PPG_Persona]
     ( 
        PersonaId				UNIQUEIDENTIFIER			NOT NULL  , 
		Identificador			VARCHAR(255)				NOT NULL  ,
		Nombres					VARCHAR(255)				NOT NULL  ,
		Apellidos				VARCHAR(255)				NOT NULL  ,
		Usuario					VARCHAR(255)				NULL  ,
		Contrasena				VARCHAR(255)				NOT NULL  ,
		Email					VARCHAR(255)				NOT NULL  ,
		Telefono				VARCHAR(255)				NULL  ,
		Direccion				VARCHAR(255)				NULL  ,
		Sexo					TINYINT						NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPG_Persona PRIMARY KEY CLUSTERED (PersonaId ASC) ON [PRIMARY]
				--ON UPDATE CASCADE
     )		
GO
--Estado *Parametrizacion Operacional General de estados de pedidos y comanda
CREATE TABLE [dbo].[POG_Estado]
     ( 
        EstadoId				UNIQUEIDENTIFIER			NOT NULL  , 
		Nombre					VARCHAR(255)				NOT NULL  ,
		Abreviatura				VARCHAR(255)				NOT NULL ,
		Descripcion				VARCHAR(255)				NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POG_Estado PRIMARY KEY CLUSTERED (EstadoId ASC) ON [PRIMARY]
				--ON UPDATE CASCADE
     )		
GO
--Estado *Parametrizacion Operacional General de estados de pedidos y comanda
CREATE TABLE [dbo].[POG_TipoEstado]
     ( 
        TipoEstadoId			UNIQUEIDENTIFIER			NOT NULL  , 
		EstadoId				UNIQUEIDENTIFIER			NOT NULL  ,
		Tipo					SMALLINT					NOT NULL  , -- 1 Comandas, 2 pedidos, 3 detales
		Orden					SMALLINT					NOT NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POG_TipoEstado PRIMARY KEY CLUSTERED (TipoEstadoId ASC) ON [PRIMARY],
			FOREIGN KEY (EstadoId) REFERENCES [dbo].[POG_Estado](EstadoId)
				--ON UPDATE CASCADE
     )		
GO
--Rol *Parametrizacion de Catalogo PPC ** Dueño, Vendedor, Administrador de cadena
CREATE TABLE [dbo].[PPC_Rol]
     ( 
        RolId					UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Jerarquia				SMALLINT					NULL  , -- 1 Due#o, 2 Administrador de cadena, 3 vendedor
		Descripcion				VARCHAR(255)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPC_Rol PRIMARY KEY CLUSTERED (RolId ASC) ON [PRIMARY]
     )		
GO
--Cadena *Parametrizacion de Catalogo PPC **
CREATE TABLE [dbo].[PPC_Cadena]
     ( 
        CadenaId				UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Email					VARCHAR(255)				NULL ,
		SitioWeb				VARCHAR(255)				NULL ,
		Direccion				VARCHAR(255)				NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPC_Cadena PRIMARY KEY CLUSTERED (CadenaId ASC) ON [PRIMARY]
				--ON UPDATE CASCADE
     )		
GO
--Local *Parametrizacion del negocio PPN **
CREATE TABLE [dbo].[PPN_Local]
     ( 
        LocalId					UNIQUEIDENTIFIER			NOT NULL , 
		CadenaId				UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Latitude				VARCHAR(MAX)				NOT NULL ,
		Longitude				VARCHAR(MAX)				NOT NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_Local PRIMARY KEY CLUSTERED (LocalId ASC) ON [PRIMARY],
			FOREIGN KEY (CadenaId) REFERENCES [dbo].[PPC_Cadena](CadenaId)
				--ON UPDATE CASCADE
     )		
GO
--Zona *Parametrizacion de Catalogo PPN **
CREATE TABLE [dbo].[PPN_Zona]
     ( 
        ZonaId					UNIQUEIDENTIFIER			NOT NULL , 
		LocalId					UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_Zona PRIMARY KEY CLUSTERED (ZonaId ASC) ON [PRIMARY],
			FOREIGN KEY (LocalId) REFERENCES [dbo].[PPN_Local](LocalId)
     )		
GO
--Poligonos *Parametrizacion de Catalogo PPN **
CREATE TABLE [dbo].[PPN_Poligono]
     ( 
        PoligonoId				UNIQUEIDENTIFIER			NOT NULL , 
		ZonaId					UNIQUEIDENTIFIER			NOT NULL , 
		LocalId					UNIQUEIDENTIFIER			NOT NULL , 
		Latitude				VARCHAR(255)				NOT NULL ,
		Longitude				VARCHAR(255)				NULL ,
		Poligono				geography					NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_Poligono PRIMARY KEY CLUSTERED (PoligonoId ASC) ON [PRIMARY],
			FOREIGN KEY (ZonaId) REFERENCES [dbo].[PPN_Zona](ZonaId),
			FOREIGN KEY (LocalId) REFERENCES [dbo].[PPN_Local](LocalId)
     )		
GO
--Usuario *Parametrizacion del negocio PPN
CREATE TABLE [dbo].[PPN_Usuario]
     ( 
        UsuarioId				UNIQUEIDENTIFIER			NOT NULL  , 
		PersonaId				UNIQUEIDENTIFIER			NOT NULL  , 
		RolId					UNIQUEIDENTIFIER			NOT NULL  , 
		LocalId					UNIQUEIDENTIFIER			NOT NULL  , 
		Bloqueado				TINYINT						NOT NULL	DEFAULT 0, --1 desbloqueado, 0 bloqueado
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_Usuario PRIMARY KEY CLUSTERED (UsuarioId ASC) ON [PRIMARY],
			FOREIGN KEY (RolId) REFERENCES [dbo].[PPC_Rol](RolId),
			FOREIGN KEY (LocalId) REFERENCES [dbo].[PPN_Local](LocalId),
			FOREIGN KEY (PersonaId) REFERENCES [dbo].[PPG_Persona](PersonaId)
				--ON UPDATE CASCADE
     )		
GO
--Tipo de Categorias *Parametrizacion del negocio PPN **
CREATE TABLE [dbo].[PPN_TipoCategoria]
     ( 
        TipoCategoriaId			UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Sinonimo				VARCHAR(255)				NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_TipoCategoria PRIMARY KEY CLUSTERED (TipoCategoriaId ASC) ON [PRIMARY],
				--ON UPDATE CASCADE
     )		
GO
--Tipo de Productos *Parametrizacion del negocio PPN **
CREATE TABLE [dbo].[PPN_TipoProducto]
     ( 
        TipoProductoId			UNIQUEIDENTIFIER			NOT NULL , 
		TipoCategoriaId			UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Sinonimo				VARCHAR(255)				NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_TipoProducto PRIMARY KEY CLUSTERED (TipoProductoId ASC) ON [PRIMARY],
			FOREIGN KEY (TipoCategoriaId) REFERENCES [dbo].[PPN_TipoCategoria](TipoCategoriaId)
				--ON UPDATE CASCADE
     )		
GO
--Categoria *Parametrizacion del negocio PPN **
CREATE TABLE [dbo].[PPN_Categoria]
     ( 
        CategoriaId				UNIQUEIDENTIFIER			NOT NULL , 
		TipoCategoriaId			UNIQUEIDENTIFIER			NOT NULL , 
		LocalId					UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Imagen					VARCHAR(255)				NULL ,
		Sinonimo				VARCHAR(255)				NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		UsuarioCreacion			UNIQUEIDENTIFIER			NOT NULL ,
		UsuarioActualizacion	UNIQUEIDENTIFIER			NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_Categoria PRIMARY KEY CLUSTERED (CategoriaId ASC) ON [PRIMARY],
			FOREIGN KEY (LocalId) REFERENCES [dbo].[PPN_Local](LocalId),
			FOREIGN KEY (UsuarioCreacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId),
			FOREIGN KEY (UsuarioActualizacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId),
			FOREIGN KEY (TipoCategoriaId) REFERENCES [dbo].[PPN_TipoCategoria](TipoCategoriaId)
				--ON UPDATE CASCADE
     )		
GO
--UnidadMedida *Parametrizacion de Catalogo PPC
CREATE TABLE [dbo].[PPC_UnidadMedida]
     ( 
        UnidadMedidaId			UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Abreviatura				VARCHAR(255)				NOT NULL ,
		Descripcion				VARCHAR(225)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPC_UnidadMedida PRIMARY KEY CLUSTERED (UnidadMedidaId ASC) ON [PRIMARY]
     )		
GO
--CostoServicio *Parametrizacion de Catalogo PPC *
CREATE TABLE [dbo].[PPC_CostoServicio]
     ( 
        CostoServicioId			UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Monto					DECIMAL(9, 6)				NOT NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPC_CostoServicio PRIMARY KEY CLUSTERED (CostoServicioId ASC) ON [PRIMARY]
     )		
GO
--ListaPrecio *Parametrizacion de Catalogo PPC
CREATE TABLE [dbo].[PPC_ListaPrecio]
     ( 
        ListaPrecioId			UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		Defecto					TINYINT						NOT NULL	DEFAULT 1,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPC_ListaPrecio PRIMARY KEY CLUSTERED (ListaPrecioId ASC) ON [PRIMARY]
     )		
GO
--Item o Producto *Parametrizacion de Catalogo PPN ** 'Duda si debe llamarse Item o Producto' **Estados Pendiente -> Planificado -> Producido
CREATE TABLE [dbo].[PPN_Producto]
     ( 
        ProductoId				UNIQUEIDENTIFIER			NOT NULL , 
		TipoProductoId			UNIQUEIDENTIFIER			NOT NULL , 
		LocalId					UNIQUEIDENTIFIER			NOT NULL , 
		CategoriaId				UNIQUEIDENTIFIER			NOT NULL , 
		UnidadMedidaId			UNIQUEIDENTIFIER			NOT NULL , 
		Codigo					INT							NOT NULL  ,
		Nombre					VARCHAR(255)				NOT NULL ,
		Unificado				TINYINT						NOT NULL , -- 1 de local, 2 cadena
		Imagen					VARCHAR(255)				NULL ,
		Sinonimo				VARCHAR(255)				NULL ,
		Marca					VARCHAR(255)				NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		UsuarioCreacion			UNIQUEIDENTIFIER			NOT NULL ,
		UsuarioActualizacion	UNIQUEIDENTIFIER			NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_Producto PRIMARY KEY CLUSTERED (ProductoId ASC) ON [PRIMARY],
			FOREIGN KEY (TipoProductoId) REFERENCES [dbo].[PPN_TipoProducto](TipoProductoId),
			FOREIGN KEY (LocalId) REFERENCES [dbo].[PPN_Local](LocalId),
			FOREIGN KEY (CategoriaId) REFERENCES [dbo].[PPN_Categoria](CategoriaId),
			FOREIGN KEY (UsuarioCreacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId),
			FOREIGN KEY (UsuarioActualizacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId),
			FOREIGN KEY (UnidadMedidaId) REFERENCES [dbo].[PPC_UnidadMedida](UnidadMedidaId),

     )		
GO
--Fotografias *Parametrizacion de Catalogo PPN **
CREATE TABLE [dbo].[PPN_Fotografia]
     ( 
		FotografiaId			UNIQUEIDENTIFIER			NOT NULL , 
		ProductoId				UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NULL ,
		UsuarioCreacion			UNIQUEIDENTIFIER			NOT NULL ,
		UsuarioActualizacion	UNIQUEIDENTIFIER			NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_Fotografia PRIMARY KEY CLUSTERED (FotografiaId ASC) ON [PRIMARY],
			FOREIGN KEY (ProductoId) REFERENCES [dbo].[PPN_Producto](ProductoId),
			FOREIGN KEY (UsuarioCreacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId),
			FOREIGN KEY (UsuarioActualizacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId)
     )		
GO
--Precio *Parametrizacion de Catalogo PPN **
CREATE TABLE [dbo].[PPN_Precio]
     ( 
		PrecioId				UNIQUEIDENTIFIER			NOT NULL , 
		ProductoId				UNIQUEIDENTIFIER			NOT NULL , 
		ListaPrecioId			UNIQUEIDENTIFIER			NOT NULL , 
		Monto					DECIMAL(9, 6)				NOT NULL ,
		Iva						DECIMAL(9, 2)				NOT NULL ,
		Ice						DECIMAL(9, 2)				NOT NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		UsuarioCreacion			UNIQUEIDENTIFIER			NOT NULL ,
		UsuarioActualizacion	UNIQUEIDENTIFIER			NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_Precio PRIMARY KEY CLUSTERED (PrecioId ASC) ON [PRIMARY],
			FOREIGN KEY (ProductoId) REFERENCES [dbo].[PPN_Producto](ProductoId),
			FOREIGN KEY (ListaPrecioId) REFERENCES [dbo].[PPC_ListaPrecio](ListaPrecioId),
			FOREIGN KEY (UsuarioCreacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId),
			FOREIGN KEY (UsuarioActualizacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId)
     )		
GO
--Calendario *Parametrizacion de Catalogo PPN **
CREATE TABLE [dbo].[PPN_Calendario]
     ( 
        CalendarioId			UNIQUEIDENTIFIER			NOT NULL , 
		LocalId					UNIQUEIDENTIFIER			NOT NULL , 
		FechaHoraLimProdProv	DATETIME					NOT NULL ,
		FechaHoraDespacho		DATETIME					NOT NULL ,
		FechaHoraCierrePedido	DATETIME					NOT NULL ,
		FechaHoraEntrega		DATETIME					NOT NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		UsuarioCreacion			UNIQUEIDENTIFIER			NOT NULL ,
		UsuarioActualizacion	UNIQUEIDENTIFIER			NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_Calendario PRIMARY KEY CLUSTERED (CalendarioId ASC) ON [PRIMARY],
			FOREIGN KEY (LocalId) REFERENCES [dbo].[PPN_Local](LocalId),
			FOREIGN KEY (UsuarioCreacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId),
			FOREIGN KEY (UsuarioActualizacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId)
     )		
GO
--Productos del calendario estandar *Parametrizacion de Catalogo PPN **
CREATE TABLE [dbo].[PPN_ProductoCalEst]
     ( 
        ProductoCalEstId		UNIQUEIDENTIFIER			NOT NULL , 
		CalendarioId			UNIQUEIDENTIFIER			NOT NULL , 
		ProductoId				UNIQUEIDENTIFIER			NOT NULL , 
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_ProductoCalEst PRIMARY KEY CLUSTERED (ProductoCalEstId ASC) ON [PRIMARY],
			FOREIGN KEY (CalendarioId) REFERENCES [dbo].[PPN_Calendario](CalendarioId),
			FOREIGN KEY (ProductoId) REFERENCES [dbo].[PPN_Producto](ProductoId),
     )		
GO
--Zonas del calendario estandar *Parametrizacion de Catalogo PPN **
CREATE TABLE [dbo].[PPN_ZonaCalEst]
     ( 
        ZonaCalEstId			UNIQUEIDENTIFIER			NOT NULL , 
		CalendarioId			UNIQUEIDENTIFIER			NOT NULL , 
		ZonaId					UNIQUEIDENTIFIER			NOT NULL , 
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_ZonaCalEst PRIMARY KEY CLUSTERED (ZonaCalEstId ASC) ON [PRIMARY],
			FOREIGN KEY (CalendarioId) REFERENCES [dbo].[PPN_Calendario](CalendarioId),
			FOREIGN KEY (ZonaId) REFERENCES [dbo].[PPN_Zona](ZonaId),
     )		
GO
--Oferta *Parametrizacion de Catalogo PPN **
CREATE TABLE [dbo].[PPN_Oferta]
     ( 
        OfertaId				UNIQUEIDENTIFIER			NOT NULL , 
		ProductoId				UNIQUEIDENTIFIER			NOT NULL , 
		ZonaId					UNIQUEIDENTIFIER			NOT NULL , 
		CalendarioId			UNIQUEIDENTIFIER			NOT NULL , 
		CantidadMinima			INT							NOT NULL ,
		CantidadMaxima			INT							NOT NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		Retiro					TINYINT						NULL DEFAULT 0 , -- 0 Planificada, 1 En tienda
		UsuarioCreacion			UNIQUEIDENTIFIER			NOT NULL ,
		UsuarioActualizacion	UNIQUEIDENTIFIER			NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_PPN_Oferta PRIMARY KEY CLUSTERED (OfertaId ASC) ON [PRIMARY],
			FOREIGN KEY (ProductoId) REFERENCES [dbo].[PPN_Producto](ProductoId),
			FOREIGN KEY (ZonaId) REFERENCES [dbo].[PPN_Zona](ZonaId),
			FOREIGN KEY (CalendarioId) REFERENCES [dbo].[PPN_Calendario](CalendarioId),
			FOREIGN KEY (UsuarioCreacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId),
			FOREIGN KEY (UsuarioActualizacion) REFERENCES [dbo].[PPN_Usuario](UsuarioId)
     )		
GO
--FormaDespacho *Operacion Produccion POP ** (En local, Planificado)
CREATE TABLE [dbo].[POP_FormaDespacho]
     ( 
        FormaDespachoId			UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL  ,
		Descipcion				VARCHAR(255)				NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POP_FormaDespacho PRIMARY KEY CLUSTERED (FormaDespachoId ASC) ON [PRIMARY]
				--ON UPDATE CASCADE
     )		
GO
--Despachador *Operacion Produccion POP ** Estados (en transito -> en Entrega -> Entregado)
CREATE TABLE [dbo].[POP_Despachador]
     ( 
        DespachadorId			UNIQUEIDENTIFIER			NOT NULL  , 
		PersonaId				UNIQUEIDENTIFIER			NOT NULL  , 
		EstadoId				UNIQUEIDENTIFIER			NOT NULL  , 
		Bloqueado				TINYINT						NOT NULL	DEFAULT 0,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POP_Despachador PRIMARY KEY CLUSTERED (DespachadorId ASC) ON [PRIMARY],
			FOREIGN KEY (PersonaId) REFERENCES [dbo].[PPG_Persona](PersonaId),
			FOREIGN KEY (EstadoId) REFERENCES [dbo].[POG_Estado](EstadoId)
				--ON UPDATE CASCADE
     )		
GO
--Usuario *Operacion Produccion POP
CREATE TABLE [dbo].[POP_Usuario]
     ( 
        UsuarioId				UNIQUEIDENTIFIER			NOT NULL  , 
		PersonaId				UNIQUEIDENTIFIER			NOT NULL  , 
        DespachadorId			UNIQUEIDENTIFIER			NOT NULL  , 
		Bloqueado				TINYINT						NOT NULL	DEFAULT 0,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POP_Usuario PRIMARY KEY CLUSTERED (UsuarioId ASC) ON [PRIMARY],
			FOREIGN KEY (DespachadorId) REFERENCES [dbo].[POP_Despachador](DespachadorId),
			FOREIGN KEY (PersonaId) REFERENCES [dbo].[PPG_Persona](PersonaId)
				--ON UPDATE CASCADE
     )		
GO
--Comanda *Operacion Produccion POP **Estados (Pagado -> Despachado -> Entregado)
CREATE TABLE [dbo].[POP_Comanda]
     ( 
        ComandaId				UNIQUEIDENTIFIER			NOT NULL  , 
		ProductoId				UNIQUEIDENTIFIER			NOT NULL , 
		LocalId					UNIQUEIDENTIFIER			NOT NULL , 
		CalendarioId			UNIQUEIDENTIFIER			NOT NULL , 
		EstadoId				UNIQUEIDENTIFIER			NOT NULL  , 
		NroComanda				INT							NOT NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POP_Comanda PRIMARY KEY CLUSTERED (ComandaId ASC) ON [PRIMARY],
			FOREIGN KEY (ProductoId) REFERENCES [dbo].[PPN_Producto](ProductoId),
			FOREIGN KEY (LocalId) REFERENCES [dbo].[PPN_Local](LocalId),
			FOREIGN KEY (CalendarioId) REFERENCES [dbo].[PPN_Calendario](CalendarioId),
			FOREIGN KEY (EstadoId) REFERENCES [dbo].[POG_Estado](EstadoId)
				--ON UPDATE CASCADE
     )		
GO
--OrderDespacho *Operacion Produccion POP ** Estados (en transito -> en Entrega -> Entregado)
CREATE TABLE [dbo].[POP_OrdenDespacho]
     ( 
        OrdenDespachoId			UNIQUEIDENTIFIER			NOT NULL  , 
		DespachadorId			UNIQUEIDENTIFIER			NOT NULL  , 
		CalendarioId			UNIQUEIDENTIFIER			NOT NULL , 
		ZonaId					UNIQUEIDENTIFIER			NOT NULL , 
		UsuarioId				UNIQUEIDENTIFIER			NOT NULL  , 
		NroOrdenDespacho		INT							NOT NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POP_OrdenDespacho PRIMARY KEY CLUSTERED (OrdenDespachoId ASC) ON [PRIMARY],
			FOREIGN KEY (DespachadorId) REFERENCES [dbo].[POP_Despachador](DespachadorId),
			FOREIGN KEY (CalendarioId) REFERENCES [dbo].[PPN_Calendario](CalendarioId),
			FOREIGN KEY (ZonaId) REFERENCES [dbo].[PPN_Zona](ZonaId),
			FOREIGN KEY (UsuarioId) REFERENCES [dbo].[POP_Usuario](UsuarioId)
				--ON UPDATE CASCADE
     )		
GO
--TipoCliente *Operacion Cliente POC ** Empresa, Familiar, Particular
CREATE TABLE [dbo].[POC_TipoCliente]
     ( 
        TipoClienteId			UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL ,
		Descripcion				VARCHAR(255)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POC_TipoCliente PRIMARY KEY CLUSTERED (TipoClienteId ASC) ON [PRIMARY]
     )		
GO
--Cliente *Operacion Cliente POC
CREATE TABLE [dbo].[POC_Cliente]
     ( 
        ClienteId				UNIQUEIDENTIFIER			NOT NULL , 
		TipoClienteId			UNIQUEIDENTIFIER			NOT NULL , 
		Temporal				TINYINT						NOT NULL	DEFAULT 0,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POC_Cliente PRIMARY KEY CLUSTERED (ClienteId ASC) ON [PRIMARY],
			FOREIGN KEY (TipoClienteId) REFERENCES [dbo].[POC_TipoCliente](TipoClienteId)
     )		
GO
--Datos facturacion *Operacion Cliente POC *
CREATE TABLE [dbo].[POC_DatosFacturacion]
     ( 
        DatosFacturacionId		UNIQUEIDENTIFIER			NOT NULL , 
		ClienteId				UNIQUEIDENTIFIER			NOT NULL, 
		CedulaRUC				VARCHAR(255)				NOT NULL  ,
		Nombres					VARCHAR(255)				NOT NULL  ,
		Apellidos				VARCHAR(255)				NOT NULL  ,
		Direccion				VARCHAR(255)				NOT NULL  ,
		Telefono				VARCHAR(255)				NOT NULL  ,
		Correo					VARCHAR(255)				NOT NULL  ,
		Defecto					TINYINT						NULL	DEFAULT 1,
		Consumidor				TINYINT						NOT NULL	DEFAULT 1,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POC_DatosFacturacion PRIMARY KEY CLUSTERED (DatosFacturacionId ASC) ON [PRIMARY],
			FOREIGN KEY (ClienteId) REFERENCES [dbo].[POC_Cliente](ClienteId)
     )		
GO

--Direccion Entrega *Operacion Cliente POC
CREATE TABLE [dbo].[POC_DireccionEntrega]
     ( 
        DireccionEntregaId		UNIQUEIDENTIFIER			NOT NULL , 
		ClienteId				UNIQUEIDENTIFIER			NOT NULL , 
		Latitude				VARCHAR(155)				NULL  ,
		Longitude				VARCHAR(155)				NULL  ,
		Ubicacion				geography					NULL ,
		Direccion				VARCHAR(255)				NULL  ,
		Referencia				VARCHAR(255)				NULL  ,
		Defecto					TINYINT						NULL	DEFAULT 1,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POC_DireccionEntrega PRIMARY KEY CLUSTERED (DireccionEntregaId ASC) ON [PRIMARY],
			FOREIGN KEY (ClienteId) REFERENCES [dbo].[POC_Cliente](ClienteId)
     )		
GO
--Zona de Direccion *Operacion Cliente POC
CREATE TABLE [dbo].[POC_ZonaDireccion]
     ( 
        ZonaDireccionId			UNIQUEIDENTIFIER			NOT NULL , 
		DireccionEntregaId		UNIQUEIDENTIFIER			NOT NULL , 
		ClienteId				UNIQUEIDENTIFIER			NULL , 
		ZonaId					UNIQUEIDENTIFIER			NOT NULL , 
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POC_ZonaDireccion PRIMARY KEY CLUSTERED (ZonaDireccionId ASC) ON [PRIMARY],
			FOREIGN KEY (DireccionEntregaId) REFERENCES [dbo].[POC_DireccionEntrega](DireccionEntregaId),
			FOREIGN KEY (ClienteId) REFERENCES [dbo].[POC_Cliente](ClienteId),
			FOREIGN KEY (ZonaId) REFERENCES [dbo].[PPN_Zona](ZonaId)
     )		
GO
--Recordatorio *Operacion Cliente POC
CREATE TABLE [dbo].[POC_Recordatorio]
     ( 
        RecordatorioId			UNIQUEIDENTIFIER			NOT NULL  , 
		ClienteId				UNIQUEIDENTIFIER			NOT NULL , 
		ProductoId				UNIQUEIDENTIFIER			NOT NULL , 
		OfertaId				UNIQUEIDENTIFIER			NOT NULL , 
		UnaVez					VARCHAR(255)				NOT NULL  ,
		Recurrente				VARCHAR(255)				NOT NULL  ,
		Temporada				VARCHAR(255)				NOT NULL  ,
		Descripcion				VARCHAR(255)				NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POC_Recordatorio PRIMARY KEY CLUSTERED (RecordatorioId ASC) ON [PRIMARY],
			FOREIGN KEY (ClienteId) REFERENCES [dbo].[POC_Cliente](ClienteId),
			FOREIGN KEY (ProductoId) REFERENCES [dbo].[PPN_Producto](ProductoId),
			FOREIGN KEY (OfertaId) REFERENCES [dbo].[PPN_Oferta](OfertaId)
				--ON UPDATE CASCADE
     )		
GO
--Recordatorio temporadas *Operacion Cliente POC
CREATE TABLE [dbo].[POC_Temporadas]
     ( 
        TemporadasId			UNIQUEIDENTIFIER			NOT NULL  , 
		RecordatorioId			UNIQUEIDENTIFIER			NOT NULL  , 
		Temporada				VARCHAR(255)				NOT NULL  ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POC_Temporadas PRIMARY KEY CLUSTERED (TemporadasId ASC) ON [PRIMARY],
			FOREIGN KEY (RecordatorioId) REFERENCES [dbo].[POC_Recordatorio](RecordatorioId)
				--ON UPDATE CASCADE
     )		
GO
--Usuario *Operacion Cliente POC
CREATE TABLE [dbo].[POC_Usuario]
     ( 
        UsuarioId				UNIQUEIDENTIFIER			NOT NULL  , 
		PersonaId				UNIQUEIDENTIFIER			NULL  , 
		ClienteId				UNIQUEIDENTIFIER			NOT NULL , 
		Bloqueado				TINYINT						NOT NULL	DEFAULT 0,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POC_Usuario PRIMARY KEY CLUSTERED (UsuarioId ASC) ON [PRIMARY],
			FOREIGN KEY (ClienteId) REFERENCES [dbo].[POC_Cliente](ClienteId),
			FOREIGN KEY (PersonaId) REFERENCES [dbo].[PPG_Persona](PersonaId)
				--ON UPDATE CASCADE
     )		
GO
--FormaPago *Operacion Cliente POC *
CREATE TABLE [dbo].[POC_FormaPago]
     ( 
        FormaPagoId				UNIQUEIDENTIFIER			NOT NULL , 
		Nombre					VARCHAR(255)				NOT NULL  ,
		Descipcion				VARCHAR(255)				NULL  ,
		UsuarioCreacion			UNIQUEIDENTIFIER			NOT NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POC_FormaPago PRIMARY KEY CLUSTERED (FormaPagoId ASC) ON [PRIMARY],
			FOREIGN KEY (UsuarioCreacion) REFERENCES [dbo].[POC_Usuario](UsuarioId)
				--ON UPDATE CASCADE
     )		
GO
--Pedido *Operacion Cliente POC ** Estados (Pendiente -> Planificado -> Producido)
CREATE TABLE [dbo].[POC_Pedido]
     ( 
        PedidoId				UNIQUEIDENTIFIER			NOT NULL , 
		ClienteId				UNIQUEIDENTIFIER			NOT NULL , 
		ZonaId					UNIQUEIDENTIFIER			NOT NULL , 
		NroPedido				INT							NOT NULL ,
		ValorSinIva				DECIMAL(9, 6)				NOT NULL ,
		ValorTotalSinIva		DECIMAL(9, 6)				NOT NULL ,
		ValorConIva				DECIMAL(9, 6)				NOT NULL ,
		CostoServicioId			UNIQUEIDENTIFIER			NOT NULL , 
		CostoEnvio				DECIMAL(9, 6)				NULL ,
		Iva						DECIMAL(9, 6)				NULL ,
		ValorICE				DECIMAL(9, 6)				NOT NULL ,
		ValorTotal				DECIMAL(9, 6)				NOT NULL ,
		FormaPagoId				UNIQUEIDENTIFIER			NOT NULL , 
		FormaDespachoId			UNIQUEIDENTIFIER			NOT NULL , 
		EstadoId				UNIQUEIDENTIFIER			NOT NULL  , 
		Confirmado				TINYINT						NOT NULL	DEFAULT 1, -- Por cliente, 1 activo y 0 confirmado
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 1,
			CONSTRAINT PK_POC_Pedido PRIMARY KEY CLUSTERED (PedidoId ASC) ON [PRIMARY],
			FOREIGN KEY (ClienteId) REFERENCES [dbo].[POC_Cliente](ClienteId),
			FOREIGN KEY (ZonaId) REFERENCES [dbo].[PPN_Zona](ZonaId),
			FOREIGN KEY (CostoServicioId) REFERENCES [dbo].[PPC_CostoServicio](CostoServicioId),
			FOREIGN KEY (FormaPagoId) REFERENCES [dbo].[POC_FormaPago](FormaPagoId),
			FOREIGN KEY (FormaDespachoId) REFERENCES [dbo].[POP_FormaDespacho](FormaDespachoId),
			FOREIGN KEY (EstadoId) REFERENCES [dbo].[POG_Estado](EstadoId)
				--ON UPDATE CASCADE
     )		
GO
--DetallePedido *Operacion Cliente POC
CREATE TABLE [dbo].[POC_DetallePedido]
     ( 
        DetallePedidoId			UNIQUEIDENTIFIER			NOT NULL  , 
		OfertaId				UNIQUEIDENTIFIER			NULL , 
		ComandaId				UNIQUEIDENTIFIER			NULL , 
        PedidoId				UNIQUEIDENTIFIER			NOT NULL  , 
		OrdenDespachoId			UNIQUEIDENTIFIER			NULL  , 
		ProductoId				UNIQUEIDENTIFIER			NOT NULL ,  
		Cantidad				DECIMAL(9, 2)				NOT NULL ,
		UnidadMedidaId			UNIQUEIDENTIFIER			NOT NULL , 
		PrecioUnitario			DECIMAL(9, 6)				NOT NULL ,
		ValorSinIva				DECIMAL(9, 6)				NOT NULL ,
		ValorSinIce				DECIMAL(9, 6)				NOT NULL ,
		ValorConIva				DECIMAL(9, 6)				NOT NULL ,
		ValorConIce				DECIMAL(9, 6)				NOT NULL ,
		ValorTotalSinIva		DECIMAL(9, 6)				NOT NULL ,
		ValorTotalSinIce		DECIMAL(9, 6)				NOT NULL ,
		ValorTotalIva			DECIMAL(9, 6)				NOT NULL ,
		ValorTotalIce			DECIMAL(9, 6)				NOT NULL ,
		EstadoId				UNIQUEIDENTIFIER			NOT NULL  , 
		FechaHoraEntrega		DATETIME					NOT NULL ,
		FechaCreacion			DATETIME					NOT NULL  	DEFAULT (GETDATE()) ,
		Estado					TINYINT						NOT NULL	DEFAULT 0,
			CONSTRAINT PK_POC_DetallePedido PRIMARY KEY CLUSTERED (DetallePedidoId ASC) ON [PRIMARY],
			FOREIGN KEY (OfertaId) REFERENCES [dbo].[PPN_Oferta](OfertaId),
			FOREIGN KEY (ComandaId) REFERENCES [dbo].[POP_Comanda](ComandaId),
			FOREIGN KEY (PedidoId) REFERENCES [dbo].[POC_Pedido](PedidoId),
			FOREIGN KEY (OrdenDespachoId) REFERENCES [dbo].[POP_OrdenDespacho](OrdenDespachoId),
			FOREIGN KEY (ProductoId) REFERENCES [dbo].[PPN_Producto](ProductoId),
			FOREIGN KEY (UnidadMedidaId) REFERENCES [dbo].[PPC_UnidadMedida](UnidadMedidaId),
			FOREIGN KEY (EstadoId) REFERENCES [dbo].[POG_Estado](EstadoId)
				--ON UPDATE CASCADE
     )		
GO
