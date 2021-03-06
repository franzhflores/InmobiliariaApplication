USE [INMOBILIARIA]
GO
/****** Object:  StoredProcedure [dbo].[InsertApartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertApartamento]

@Id_Edificio VARCHAR(6),
@N_Piso INT,
@N_Puerta INT,
@Bloque VARCHAR(2)
AS
BEGIN
	
			DECLARE @Id VARCHAR(6);			
			DECLARE @AllCad VARCHAR(6)

			SET @AllCad = (SELECT TOP 1 Id FROM Apartamento ORDER BY Id DESC)
			SET @Id = dbo.nf_Incrementar_Id(1,@AllCad)
			
    INSERT INTO Apartamento VALUES(@Id,@Id_Edificio,@N_Piso,@N_Puerta,@Bloque)
	IF NOT EXISTS(SELECT Id FROM Apartamento WHERE @Id = Id)
		SELECT 'Empty';
	SELECT @Id
	
END

GO
/****** Object:  StoredProcedure [dbo].[InsertCasa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertCasa]
	
	@Id_TC VARCHAR(50),
	@M2 VARCHAR(20),
	@Id_UbiDetalle VARCHAR(6)
AS
BEGIN
	DECLARE @Id VARCHAR(6);
	DECLARE @AllCad VARCHAR(6)

	SET @AllCad = (SELECT TOP 1 Id FROM Casa ORDER BY Id DESC)
	SET @Id = dbo.nf_Incrementar_Id(1,@AllCad)
	
	INSERT INTO Casa VALUES(@Id,@Id_TC,@M2,@Id_UbiDetalle)
	IF NOT EXISTS(SELECT Id FROM Casa WHERE @Id = Id)
		SELECT 'Empty';
	SELECT @Id
END


GO
/****** Object:  StoredProcedure [dbo].[InsertDetalleUbicacion]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertDetalleUbicacion]
@Id VARCHAR(6) ,
@Id_ubicacion VARCHAR(6),
@Zona VARCHAR(50)	

AS
BEGIN

	INSERT INTO Ubicacion_Detalle VALUES(@Id,@Id_ubicacion,@Zona)
	SELECT * FROM Ubicacion_Detalle
END

GO
/****** Object:  StoredProcedure [dbo].[InsertEdificio]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertEdificio]

@Id_Ubicacion VARCHAR(6),
@Nombre VARCHAR(50),
@A_Construccion DATETIME,
@N_Plantas INT,
@Inf_Adicional VARCHAR(MAX),
@mainFoto VARCHAR(150),
@direccion VARCHAR(MAX)

AS
BEGIN
	DECLARE @Id VARCHAR(6);
	DECLARE @AllCad VARCHAR(6);

	
	SET @AllCad = (SELECT TOP 1 Id FROM Edificio ORDER BY Id DESC)
	SET @Id = dbo.nf_Incrementar_Id(1,@AllCad)	
	
	INSERT INTO Edificio VALUES(@Id,@Id_Ubicacion,@Nombre,@A_Construccion,@N_Plantas,
						        @Inf_Adicional,@mainFoto,@direccion)						        
	IF NOT EXISTS(SELECT Id FROM Edificio WHERE @Id = Id)
		SELECT 'Empty';
	SELECT @Id    
	
END

GO
/****** Object:  StoredProcedure [dbo].[InsertFotoCasa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertFotoCasa]
	
	@Id_Infrac_Detalle VARCHAR(6),
	@Id_Casa VARCHAR (6),
	@Foto VARCHAR(100),
	@Descripcion VARCHAR(MAX)
AS
BEGIN
	DECLARE @Id VARCHAR(6);
	DECLARE @AllCad VARCHAR(6)

	IF (SELECT COUNT(id) FROM Foto_Casa)!= 0
	BEGIN
		SET @AllCad = (SELECT TOP 1 Id FROM Foto_Casa ORDER BY Id DESC)
		SET @Id = dbo.nf_Incrementar_Id(2,@AllCad)
	END	
	ELSE
	    SET @Id = 'FC_001'	 
			
	INSERT INTO  Foto_Casa VALUES(@Id,@Foto,@Id_Infrac_Detalle,@Id_Casa,@Descripcion)
	IF NOT EXISTS(SELECT Id FROM Foto_Casa WHERE @Id = Id)
		SELECT 'Empty';
	SELECT @Id 
END

GO
/****** Object:  StoredProcedure [dbo].[InsertFotoEdificio]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertFotoEdificio]
	
	@Id_Edificio VARCHAR(6),
	@Foto VARCHAR(100),
	@Descripcion VARCHAR(MAX)
AS
BEGIN
	DECLARE @Id VARCHAR(6);
	DECLARE @AllCad VARCHAR(6)

	IF (SELECT COUNT(id) FROM Foto_Edificio)!= 0
	BEGIN
		SET @AllCad = (SELECT TOP 1 Id FROM Foto_Edificio ORDER BY Id DESC)
		SET @Id = dbo.nf_Incrementar_Id(2,@AllCad)
	END	
	ELSE
	    SET @Id = 'FE_001'	 
			
	INSERT INTO  Foto_Edificio VALUES(@Id,@Id_Edificio,@Foto,@Descripcion)
	IF NOT EXISTS(SELECT Id FROM Foto_Edificio WHERE @Id = Id)
		SELECT 'Empty';
	SELECT @Id 
END

GO
/****** Object:  StoredProcedure [dbo].[InsertFotosApartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertFotosApartamento]
	@Foto VARCHAR(100),
	@Id_Infra_detalle VARCHAR(6),
	@Id_Apartamento VARCHAR(6),
	@Descripcion VARCHAR(MAX)
AS
BEGIN
	DECLARE @Id VARCHAR(6);
	DECLARE @AllCad VARCHAR(6)
	
	IF (SELECT COUNT(id) FROM Fotos_Apartamento)!= 0
	BEGIN
		SET @AllCad = (SELECT TOP 1 Id FROM Fotos_Apartamento ORDER BY Id DESC)
		SET @Id = dbo.nf_Incrementar_Id(2,@AllCad)
	END	
	ELSE
	    SET @Id = 'FA_001'	 
			
	INSERT INTO  Fotos_Apartamento VALUES(@Id,@Foto,@Id_Infra_detalle,@Id_Apartamento,@Descripcion)
	IF NOT EXISTS(SELECT Id FROM Fotos_Apartamento WHERE @Id = Id)
		SELECT 'Empty';
	SELECT @Id 
END


GO
/****** Object:  StoredProcedure [dbo].[InsertInfra_Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertInfra_Apartamento]

@Id_Apart VARCHAR(6),
@Id_Infra_Apart VARCHAR(6),
@Cantidad INT
AS
BEGIN
	
	DECLARE @Id VARCHAR(6);			
	DECLARE @AllCad VARCHAR(6)
	SET @AllCad = (SELECT TOP 1 Id FROM Infraestructura_Apartamento ORDER BY Id DESC)
	SET @Id = dbo.nf_Incrementar_Id(2,@AllCad)
			
    INSERT INTO Infraestructura_Apartamento VALUES(@Id,@Id_Apart,@Id_Infra_Apart,@Cantidad)
	IF NOT EXISTS(SELECT Id FROM Infraestructura_Apartamento WHERE @Id = Id)
		SELECT 'Empty';
	SELECT @Id    
END

GO
/****** Object:  StoredProcedure [dbo].[InsertInfraCasa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertInfraCasa]
	
	@Id_casa VARCHAR(6),
	@Id_Infrac_Detalle VARCHAR(6),
	@Cantidad VARCHAR (10)
AS
BEGIN
	DECLARE @Id VARCHAR(6);
	DECLARE @AllCad VARCHAR(6)

	SET @AllCad = (SELECT TOP 1 Id FROM Infraestructura_Casa ORDER BY Id DESC)
	SET @Id = dbo.nf_Incrementar_Id(1,@AllCad)


	INSERT INTO Infraestructura_Casa VALUES(@Id,@Id_casa,@Id_Infrac_Detalle,@Cantidad)
	SELECT * FROM Infraestructura_Casa
END


GO
/****** Object:  StoredProcedure [dbo].[InsertInfraDetalle]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertInfraDetalle]
	
	@Id_Infrastructura VARCHAR(6),
	@Tamano VARCHAR(4),
	@Descripcion VARCHAR(250)
AS
BEGIN
	DECLARE @Id VARCHAR(6);
	DECLARE @AllCad VARCHAR(6)

	SET @AllCad = (SELECT TOP 1 Id FROM Infraestructura_Detalle ORDER BY Id DESC)
	SET @Id = dbo.nf_Incrementar_Id(2,@AllCad)

	INSERT INTO Infraestructura_Detalle VALUES(@Id,@Id_Infrastructura,@Tamano,@Descripcion)
	IF NOT EXISTS(SELECT Id FROM Infraestructura_Detalle WHERE @Id = Id)
		SELECT 'Empty';
	SELECT @Id 
END


GO
/****** Object:  StoredProcedure [dbo].[InsertInfrastructura]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInfrastructura]
	
	@Nombre VARCHAR(50),
	@Tamano VARCHAR(4),
	@Descripcion VARCHAR(MAX)
	
AS
BEGIN
			--Variables que tomaran un valor devuelto por la funcion incrementar_Id
			DECLARE @Id_Infrastructura VARCHAR(6);
			DECLARE @Id_InfrastructuraDetalle VARCHAR(6);
			DECLARE @AllCad VARCHAR(6)

			SET @AllCad = (SELECT TOP 1 Id FROM Infraestructura ORDER BY Id DESC)
			SET @Id_Infrastructura = dbo.nf_Incrementar_Id(1,@AllCad)
			
			SET @AllCad = (SELECT TOP 1 Id FROM Infraestructura_Detalle ORDER BY Id DESC)
			SET @Id_InfrastructuraDetalle = dbo.nf_Incrementar_Id(2,@AllCad)
			

DECLARE @idInfra VARCHAR(6);
DECLARE @VC_Nombre VARCHAR(50);
DECLARE @band INT
DECLARE c_recorrer_inf CURSOR FOR SELECT Id,Nombre  FROM Infraestructura
OPEN c_recorrer_inf
FETCH NEXT FROM c_recorrer_Inf INTO @IdInfra,@VC_Nombre
SET @band = 0
WHILE @@FETCH_STATUS = 0
   BEGIN
		IF @Nombre = @VC_Nombre
		BEGIN
			SET @Id_Infrastructura = @idInfra
			PRINT @Id_Infrastructura +' -- '+  @VC_Nombre
			SET @band = 1
		END	
		PRINT @VC_Nombre +'ID Infra'+ @IdInfra + @Nombre
	
        FETCH NEXT FROM c_recorrer_inf into @IdInfra,@VC_Nombre
        
   END
CLOSE c_recorrer_inf
DEALLOCATE c_recorrer_inf
IF @band = 1
   BEGIN
		INSERT INTO Infraestructura_Detalle VALUES(@Id_InfrastructuraDetalle,@Id_Infrastructura,@Tamano,@Descripcion)
   END
ELSE
	BEGIN
		INSERT INTO Infraestructura VALUES (@Id_Infrastructura, @Nombre)
		INSERT INTO Infraestructura_Detalle VALUES(@Id_InfrastructuraDetalle,@Id_Infrastructura,@Tamano,@Descripcion)
	END

	SELECT * FROM Infraestructura
END

GO
/****** Object:  StoredProcedure [dbo].[InsertServicio]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertServicio]

	@Nombre VARCHAR(50),
	@Tipo VARCHAR(50),
	@Descripcion VARCHAR(50)
AS
BEGIN
	DECLARE @Id VARCHAR(6);
	DECLARE @AllCad VARCHAR(6)

	SET @AllCad = (SELECT TOP 1 Id FROM Servicios ORDER BY Id DESC)
	SET @Id = dbo.nf_Incrementar_Id(1,@AllCad)
	
	INSERT INTO  Servicios VALUES(@Id,@Nombre,@Tipo,@Descripcion)
	IF NOT EXISTS(SELECT Id FROM Servicios WHERE @Id = Id)
		SELECT 'Empty';
	SELECT @Id 
END


GO
/****** Object:  StoredProcedure [dbo].[InsertServicioApartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertServicioApartamento]
	
	@Id_Apartamento VARCHAR(6),
	@Id_Servicio VARCHAR(6)
AS
BEGIN
	DECLARE @Id VARCHAR(6);
	DECLARE @AllCad VARCHAR(6)

	SET @AllCad = (SELECT TOP 1 Id FROM Servcio_Apartamento ORDER BY Id DESC)
	SET @Id = dbo.nf_Incrementar_Id(2,@AllCad)
	
	INSERT INTO  Servcio_Apartamento VALUES(@Id,@Id_Apartamento,@Id_Servicio)
	--IF NOT EXISTS(SELECT Id FROM Servcio_Apartamento WHERE @Id = Id)
	--	SELECT 'Empty';
	--SELECT @Id 
END


GO
/****** Object:  StoredProcedure [dbo].[InsertServicioCasa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertServicioCasa]
	
	@Id_Casa VARCHAR(6),
	@Id_Servicio VARCHAR(6)
AS
BEGIN
	DECLARE @Id VARCHAR(6);
	DECLARE @AllCad VARCHAR(6)

	SET @AllCad = (SELECT TOP 1 Id FROM Servicio_Casa ORDER BY Id DESC)
	SET @Id = dbo.nf_Incrementar_Id(1,@AllCad)


	INSERT INTO  Servicio_Casa VALUES(@Id,@Id_Casa,@Id_Servicio)
	SELECT * FROM Servicio_Casa
END


GO
/****** Object:  StoredProcedure [dbo].[InsertUbicacion]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUbicacion] 


	@Provincia VARCHAR(50),
	@Zona VARCHAR(50)

AS
BEGIN
			--Variables que tomaran un valor devuelto por la funcion incrementar_Id
			DECLARE @Id_Ubicacion VARCHAR(6);
			DECLARE @Id_UbicacionDetalle VARCHAR(6);
			DECLARE @AllCad VARCHAR(6)

			SET @AllCad = (SELECT TOP 1 Id FROM Ubicacion ORDER BY Id DESC)
			SET @Id_Ubicacion = dbo.nf_Incrementar_Id(1,@AllCad)
			
			SET @AllCad = (SELECT TOP 1 Id FROM Ubicacion_Detalle ORDER BY Id DESC)
			SET @Id_UbicacionDetalle = dbo.nf_Incrementar_Id(2,@AllCad)
			


DECLARE @idUbi VARCHAR(6);
DECLARE @VC_Provincia VARCHAR(50);
DECLARE @band INT
DECLARE c_recorrer_Ubicacion CURSOR FOR SELECT Id,Provincia  FROM Ubicacion
OPEN c_recorrer_Ubicacion
FETCH NEXT FROM c_recorrer_Ubicacion INTO @IdUbi,@VC_Provincia
SET @band = 0
WHILE @@FETCH_STATUS = 0
   BEGIN
		IF @Provincia = @VC_Provincia
		BEGIN
			SET @Id_Ubicacion = @IdUbi
			PRINT @Id_Ubicacion +' Provincia '+  @VC_Provincia
			SET @band = 1
		END	
		PRINT @VC_Provincia +'ID ubicacion'+ @IdUbi + @Provincia
	
        FETCH NEXT FROM c_recorrer_Ubicacion into @IdUbi,@VC_Provincia
        
   END
CLOSE c_recorrer_Ubicacion
DEALLOCATE c_recorrer_Ubicacion
IF @band = 1
   BEGIN
		INSERT INTO Ubicacion_Detalle VALUES(@Id_UbicacionDetalle,@Id_ubicacion,@Zona)
   END
ELSE
	BEGIN
		INSERT INTO Ubicacion VALUES (@Id_Ubicacion, @Provincia)
		INSERT INTO Ubicacion_Detalle VALUES(@Id_UbicacionDetalle,@Id_ubicacion,@Zona)
	END

	SELECT * FROM Ubicacion 
END

GO
/****** Object:  StoredProcedure [dbo].[msp_getAllEdificio]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[msp_getAllEdificio]
	
AS
BEGIN
	
	SELECT * FROM Edificio
END

GO
/****** Object:  StoredProcedure [dbo].[msp_ModificarEdificio]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[msp_ModificarEdificio]
@Id VARCHAR(6),
@Id_Ubicacion VARCHAR(6),
@Nombre VARCHAR(50),
@A_Construccion DATETIME,
@N_Plantas INT,
@Inf_Adicional VARCHAR(MAX),
@mainFoto VARCHAR(150)

AS
BEGIN
	
		
	UPDATE Edificio SET Id_Ubi_Detalle = @Id_Ubicacion, 
					    Nombre = @Nombre,
					    A_Contruccion = @A_Construccion,
					    N_Plantas = @N_Plantas,
					    Inf_Adicional = @Inf_Adicional,
					    mainfoto = @mainFoto
				   WHERE @Id = Id	   
	SELECT 1			     
	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Apartamento] 
	@Id varchar(6),
	@Id_Edificio varchar(6),
	@N_Piso int,
	@N_Puerta int,
	@Bloque varchar(2),
	@TipoOperacion varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Apartamento(Id_Edificio,N_Piso,N_Puerta,Bloque)VALUES(@Id_Edificio,@N_Piso,@N_Puerta,@Bloque);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Apartamento(Id_Edificio,N_Piso,N_Puerta,Bloque)VALUES(@Id_Edificio,@N_Piso,@N_Puerta,@Bloque);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Apartamento(Id_Edificio,N_Piso,N_Puerta,Bloque)VALUES(@Id_Edificio,@N_Piso,@N_Puerta,@Bloque);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Apartamento(Id_Edificio,N_Piso,N_Puerta,Bloque)VALUES(@Id_Edificio,@N_Piso,@N_Puerta,@Bloque);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Casa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Casa] 
	@Id VARCHAR(6),
	@Tipo VARCHAR(50),
	@M2 VARCHAR(20),
	@Id_UbiDetalle VARCHAR(6),
	@TipoOperacion Varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Casa (Tipo,Mts2,Id_Ubi_Detalle)VALUES(@Tipo,@M2,@Id_UbiDetalle);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Casa (Tipo,Mts2,Id_Ubi_Detalle)VALUES(@Tipo,@M2,@Id_UbiDetalle);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Casa (Tipo,Mts2,Id_Ubi_Detalle)VALUES(@Tipo,@M2,@Id_UbiDetalle);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Casa (Tipo,Mts2,Id_Ubi_Detalle)VALUES(@Tipo,@M2,@Id_UbiDetalle);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Edificio]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Edificio] 
	@Id varchar(6),
	@Id_Ubi_Detalle varchar(6),
	@Nombre varchar(50),
	@A_Contruccion datetime,
	@N_Plantas int,
	@Inf_Adicional varchar(100),
	@mainfoto varchar(150),
	@TipoOperacion varchar(50)	
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Edificio(Id_Ubi_Detalle,Nombre,A_Contruccion,N_Plantas,Inf_Adicional,mainfoto)
			VALUES(@Id_Ubi_Detalle,@Nombre,@A_Contruccion,@N_Plantas,@Inf_Adicional,@mainfoto);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Edificio(Id_Ubi_Detalle,Nombre,A_Contruccion,N_Plantas,Inf_Adicional,mainfoto)
			VALUES(@Id_Ubi_Detalle,@Nombre,@A_Contruccion,@N_Plantas,@Inf_Adicional,@mainfoto);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Edificio(Id_Ubi_Detalle,Nombre,A_Contruccion,N_Plantas,Inf_Adicional,mainfoto)
			VALUES(@Id_Ubi_Detalle,@Nombre,@A_Contruccion,@N_Plantas,@Inf_Adicional,@mainfoto);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Edificio(Id_Ubi_Detalle,Nombre,A_Contruccion,N_Plantas,Inf_Adicional,mainfoto)
			VALUES(@Id_Ubi_Detalle,@Nombre,@A_Contruccion,@N_Plantas,@Inf_Adicional,@mainfoto);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Edificio_Detalle]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Edificio_Detalle]
	@Id VARCHAR(6),
	@Id_Edificio varchar(6),
	@Foto varchar(100),
	@TipoOperacion Varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Edificio_Detalle (Id_Edificio,Foto)VALUES(@Id_Edificio,@Foto);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Edificio_Detalle (Id_Edificio,Foto)VALUES(@Id_Edificio,@Foto);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Edificio_Detalle (Id_Edificio,Foto)VALUES(@Id_Edificio,@Foto);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Edificio_Detalle (Id_Edificio,Foto)VALUES(@Id_Edificio,@Foto);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarEdificio]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_EliminarEdificio] 
@Id_Edificio VARCHAR(6)
AS
BEGIN
	DECLARE @band INT;
	DELETE FROM Edificio WHERE Id = @Id_Edificio
	SET @band = 1;					        
	IF EXISTS(SELECT Id FROM Edificio WHERE @Id_Edificio = Id)
		SET @band = 0;
	SELECT @band  
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Infraestructura]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Infraestructura]
	@Id varchar(6),
	@Nombre varchar(50),
	@TipoOperacion Varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Infraestructura (Nombre)VALUES(@Nombre);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Infraestructura (Nombre)VALUES(@Nombre);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Infraestructura (Nombre)VALUES(@Nombre);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Infraestructura (Nombre)VALUES(@Nombre);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Infraestructura_Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Infraestructura_Apartamento] 
	@Id varchar(6),
	@Id_Apartamento varchar(6),
	@Id_Infrac_Detalle varchar(6),
	@TipoOperacion Varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Infraestructura_Apartamento (Id_Apartamento,Id_Infrac_Detalle)
			VALUES(@Id_Apartamento,@Id_Infrac_Detalle);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Infraestructura_Apartamento (Id_Apartamento,Id_Infrac_Detalle)
			VALUES(@Id_Apartamento,@Id_Infrac_Detalle);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Infraestructura_Apartamento (Id_Apartamento,Id_Infrac_Detalle)
			VALUES(@Id_Apartamento,@Id_Infrac_Detalle);
			
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Infraestructura_Apartamento (Id_Apartamento,Id_Infrac_Detalle)
			VALUES(@Id_Apartamento,@Id_Infrac_Detalle);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Infraestructura_Casa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Infraestructura_Casa]
	@Id varchar(6),
	@Id_casa varchar(6),
	@Id_Infrac_Detalle varchar(6),	
	@TipoOperacion Varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Infraestructura_Casa(Id_casa,Id_Infrac_Detalle)VALUES(@Id_casa,@Id_Infrac_Detalle);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Infraestructura_Casa(Id_casa,Id_Infrac_Detalle)VALUES(@Id_casa,@Id_Infrac_Detalle);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Infraestructura_Casa(Id_casa,Id_Infrac_Detalle)VALUES(@Id_casa,@Id_Infrac_Detalle);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Infraestructura_Casa(Id_casa,Id_Infrac_Detalle)VALUES(@Id_casa,@Id_Infrac_Detalle);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Infraestructura_Detalle]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Infraestructura_Detalle] 
	@Id VARCHAR(6),
	@Id_Infra varchar(6),
	@Tamano varchar(4),
	@Descripcion varchar(MAX),
	@TipoOperacion Varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Infraestructura_Detalle (Id_Infra,Tamano,Descripcion)VALUES(@Id_Infra,@Tamano,@Descripcion);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Infraestructura_Detalle (Id_Infra,Tamano,Descripcion)VALUES(@Id_Infra,@Tamano,@Descripcion);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Infraestructura_Detalle (Id_Infra,Tamano,Descripcion)VALUES(@Id_Infra,@Tamano,@Descripcion);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Infraestructura_Detalle (Id_Infra,Tamano,Descripcion)VALUES(@Id_Infra,@Tamano,@Descripcion);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Servcio_Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Servcio_Apartamento] 
	@Id VARCHAR(6),
	@Id_Apartemento varchar(6),
	@Id_Servicio varchar(6),	
	@TipoOperacion Varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Servcio_Apartamento(Id_Apartemento,Id_Servicio)VALUES(@Id_Apartemento,@Id_Servicio);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Servcio_Apartamento(Id_Apartemento,Id_Servicio)VALUES(@Id_Apartemento,@Id_Servicio);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Servcio_Apartamento(Id_Apartemento,Id_Servicio)VALUES(@Id_Apartemento,@Id_Servicio);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Servcio_Apartamento(Id_Apartemento,Id_Servicio)VALUES(@Id_Apartemento,@Id_Servicio);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Servicio_Casa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Servicio_Casa] 
	@Id VARCHAR(6),
	@Id_casa varchar(6),
	@Id_servicio varchar(6),	
	@TipoOperacion Varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Servicio_Casa (Id_casa,Id_servicio)VALUES(@Id_casa,@Id_servicio);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Servicio_Casa (Id_casa,Id_servicio)VALUES(@Id_casa,@Id_servicio);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Servicio_Casa (Id_casa,Id_servicio)VALUES(@Id_casa,@Id_servicio);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Servicio_Casa (Id_casa,Id_servicio)VALUES(@Id_casa,@Id_servicio);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Servicios]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Servicios] 
	@Id varchar(6),
	@Nombre varchar(50),
	@Tipo varchar(50),	
	@TipoOperacion varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Servicios(Nombre,Tipo)VALUES(@Nombre,@Tipo);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Servicios(Nombre,Tipo)VALUES(@Nombre,@Tipo);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Servicios(Nombre,Tipo)VALUES(@Nombre,@Tipo);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Servicios(Nombre,Tipo)VALUES(@Nombre,@Tipo);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Ubicacion]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Ubicacion]
	@Id varchar(6),
	@Provincia varchar(50),	
	@TipoOperacion varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Ubicacion (Provincia)VALUES(@Provincia);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Ubicacion (Provincia)VALUES(@Provincia);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Ubicacion (Provincia)VALUES(@Provincia);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Ubicacion (Provincia)VALUES(@Provincia);
		END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_Ubicacion_Detalle]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Ubicacion_Detalle] 
	@Id varchar(6),
	@Id_Ubicacion varchar(6),
	@Zona varchar(50),
	@Direccion varchar(100),
	@TipoOperacion Varchar(50)
AS
BEGIN
	IF @TipoOperacion = 'Insertar' 
		BEGIN
			INSERT INTO Ubicacion_Detalle (Id_Ubicacion,Zona,Direccion)VALUES(@Id_Ubicacion,@Zona,@Direccion);
		END
	IF @TipoOperacion = 'Modificar' 
		BEGIN
			INSERT INTO Ubicacion_Detalle (Id_Ubicacion,Zona,Direccion)VALUES(@Id_Ubicacion,@Zona,@Direccion);
		END
	IF @TipoOperacion = 'MostrarTodo' 
		BEGIN
			INSERT INTO Ubicacion_Detalle (Id_Ubicacion,Zona,Direccion)VALUES(@Id_Ubicacion,@Zona,@Direccion);
		END
	IF @TipoOperacion = 'Eliminar' 
		BEGIN
			INSERT INTO Ubicacion_Detalle (Id_Ubicacion,Zona,Direccion)VALUES(@Id_Ubicacion,@Zona,@Direccion);
		END
END

GO
/****** Object:  UserDefinedFunction [dbo].[fun_GetIDUbicacion]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fun_GetIDUbicacion]
(
	@provincia VARCHAR(50),
	@zona VARCHAR(50),
	@direccion VARCHAR(100)
	
)
RETURNS VARCHAR(6)
AS
BEGIN	
	DECLARE @id_Ubicacion VARCHAR(6);
	DECLARE @id_Ubicacion_detalle VARCHAR(6)	
		
	SET @id_Ubicacion = (SELECT U.Id FROM Ubicacion as U 
		WHERE U.Provincia = @provincia)
	SET @id_Ubicacion_detalle = (SELECT ud.Id FROM Ubicacion_Detalle as ud 
		WHERE ud.Id_Ubicacion = @id_Ubicacion AND @zona = ud.Zona
		AND ud.Direccion = @direccion)
	RETURN @id_Ubicacion_detalle
END

GO
/****** Object:  UserDefinedFunction [dbo].[nf_Incrementar_Id]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[nf_Incrementar_Id]
(	@lenCad INT,
	@AllCad VARCHAR(6)
)
RETURNS VARCHAR(6)
AS
BEGIN	
	DECLARE @NewCad VARCHAR(6);	
	DECLARE @ValorNumerico INT
	DECLARE @ParteCadena VARCHAR(3)
	
	IF @lenCad = 1
	BEGIN
		SET @ValorNumerico = CAST ( (SUBSTRING ( @AllCad ,3 ,3)) AS INT)
		SET @ParteCadena = SUBSTRING ( @AllCad ,0 ,2)
	END
	ELSE IF @lenCad = 2
	BEGIN
		SET @ValorNumerico = CAST ( (SUBSTRING ( @AllCad ,4 ,3)) AS INT)
		SET @ParteCadena = SUBSTRING ( @AllCad ,0 ,3)
	END
	SET @ValorNumerico = @ValorNumerico + 1

	IF LEN(CAST(@ValorNumerico AS VARCHAR(6))) = 1
		SET @NewCad = @ParteCadena +  '_00'+CAST (@ValorNumerico AS VARCHAR(6))
	ELSE IF LEN(CAST(@ValorNumerico AS VARCHAR)) = 2
		SET @NewCad = @ParteCadena +  '_0'+CAST (@ValorNumerico AS VARCHAR(6))
	ELSE IF LEN(CAST(@ValorNumerico AS VARCHAR)) = 3
		SET @NewCad = @ParteCadena +  '_'+CAST (@ValorNumerico AS VARCHAR(6))

	RETURN @NewCad
END

GO
/****** Object:  Table [dbo].[Agente]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Agente](
	[Id] [varchar](6) NOT NULL,
	[Id_Persona] [varchar](6) NOT NULL,
	[Cargo] [varchar](50) NOT NULL,
	[Fecha_Inicio] [date] NOT NULL,
 CONSTRAINT [PK_Agente] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Alquiler_Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Alquiler_Apartamento](
	[Id] [varchar](6) NOT NULL,
	[Id_EApartamento] [varchar](6) NOT NULL,
	[Id_Cliente] [varchar](6) NOT NULL,
	[Id_Agente] [varchar](6) NOT NULL,
	[Fecha_Entrega] [date] NOT NULL,
	[Fecha_Final] [date] NOT NULL,
 CONSTRAINT [PK_Alquiler_Apartamento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Apartamento](
	[Id] [varchar](6) NOT NULL,
	[Id_Edificio] [varchar](6) NOT NULL,
	[N_Piso] [int] NOT NULL,
	[N_Puerta] [int] NOT NULL,
	[Bloque] [varchar](2) NULL,
 CONSTRAINT [PK_Apartamento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Casa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Casa](
	[Id] [varchar](6) NOT NULL,
	[Id_TipoCasa] [varchar](6) NOT NULL,
	[Mts2] [varchar](20) NOT NULL,
	[Id_Ubi_Detalle] [varchar](6) NOT NULL,
	[Direccion] [varchar](max) NULL,
 CONSTRAINT [PK_Casa] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[Id] [varchar](6) NOT NULL,
	[Id_Persona] [varchar](6) NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Edificio]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Edificio](
	[Id] [varchar](6) NOT NULL,
	[Id_Ubi_Detalle] [varchar](6) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[A_Contruccion] [datetime] NOT NULL,
	[N_Plantas] [int] NULL,
	[Inf_Adicional] [varchar](max) NULL,
	[mainfoto] [varchar](150) NULL,
	[Direccion] [varchar](max) NULL,
 CONSTRAINT [PK_Edificio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Edificio_Detalle]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Edificio_Detalle](
	[Id] [varchar](6) NOT NULL,
	[Id_Edificio] [varchar](6) NOT NULL,
	[Foto] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Edificio_Detalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Especificacion_Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Especificacion_Apartamento](
	[Id] [varchar](6) NOT NULL,
	[Id_Apartamento] [varchar](6) NOT NULL,
	[Tipo_Transaccion] [varchar](50) NOT NULL,
	[Monto_Especificado] [varchar](50) NOT NULL,
	[Disponible] [char](10) NOT NULL,
 CONSTRAINT [PK_Especificacion_Apartamento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Foto_Casa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Foto_Casa](
	[Id] [varchar](6) NOT NULL,
	[Id_Casa] [varchar](6) NOT NULL,
	[Id_Infrac_Detalle] [varchar](6) NOT NULL,
	[Foto] [varchar](100) NOT NULL,
	[Descripcion] [varchar](max) NULL,
 CONSTRAINT [PK_Foto_Casa] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Foto_Edificio]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Foto_Edificio](
	[Id] [varchar](6) NOT NULL,
	[Id_Edificio] [varchar](6) NOT NULL,
	[Foto] [varchar](100) NOT NULL,
	[Descripcion] [varchar](max) NULL,
 CONSTRAINT [PK_Foto_Edificio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Fotos_Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fotos_Apartamento](
	[Id] [varchar](6) NOT NULL,
	[Foto] [varchar](100) NOT NULL,
	[Id_Infra_Detalle] [varchar](6) NOT NULL,
	[Id_Apartamento] [varchar](6) NOT NULL,
	[Descripcion] [varchar](max) NULL,
 CONSTRAINT [PK_Fotos_Apartamento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Infraestructura]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Infraestructura](
	[Id] [varchar](6) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Infraestructura] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Infraestructura_Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Infraestructura_Apartamento](
	[Id] [varchar](6) NOT NULL,
	[Id_Apartamento] [varchar](6) NOT NULL,
	[Id_Infrac_Detalle] [varchar](6) NOT NULL,
	[Cantidad] [int] NULL,
 CONSTRAINT [PK_Infraestructura_Apartamento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Infraestructura_Casa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Infraestructura_Casa](
	[Id] [varchar](6) NOT NULL,
	[Id_casa] [varchar](6) NOT NULL,
	[Id_Infrac_Detalle] [varchar](6) NOT NULL,
	[Cantidad] [varchar](10) NULL,
 CONSTRAINT [PK_Infraestructura_Casa] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Infraestructura_Detalle]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Infraestructura_Detalle](
	[Id] [varchar](6) NOT NULL,
	[Id_Infra] [varchar](6) NOT NULL,
	[Tamano] [varchar](4) NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Infraestructura_Detalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pagos_Alquiler_Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pagos_Alquiler_Apartamento](
	[Id] [varchar](6) NOT NULL,
	[Id_Alquiler_Apartamento] [varchar](6) NOT NULL,
	[Fecha_Pago] [date] NOT NULL,
	[Recargo] [money] NULL,
	[Total_Monto] [money] NOT NULL,
 CONSTRAINT [PK_Pagos_Alquiler_Apartamento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Persona]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Persona](
	[Id] [varchar](6) NOT NULL,
	[CI] [varchar](8) NOT NULL,
	[Id_Ubicacion] [varchar](6) NOT NULL,
	[Genero] [varchar](50) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Apellido_Paterno] [varchar](100) NOT NULL,
	[Apellido_Materno] [varchar](100) NOT NULL,
	[Telefono] [numeric](18, 0) NOT NULL,
	[E_mail] [varchar](100) NOT NULL,
	[Direccion] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Persona] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Servcio_Apartamento]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Servcio_Apartamento](
	[Id] [varchar](6) NOT NULL,
	[Id_Apartemento] [varchar](6) NOT NULL,
	[Id_Servicio] [varchar](6) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Servicio_Casa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Servicio_Casa](
	[Id] [varchar](6) NOT NULL,
	[Id_casa] [varchar](6) NOT NULL,
	[Id_servicio] [varchar](6) NOT NULL,
 CONSTRAINT [PK_Servicio_Casa] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Servicios]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Servicios](
	[Id] [varchar](6) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Tipo] [varchar](50) NOT NULL,
	[Descripcion] [varchar](max) NULL,
 CONSTRAINT [PK_Servicios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tipo_Casa]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tipo_Casa](
	[Id] [varchar](6) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Tipo_Casa] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ubicacion]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ubicacion](
	[Id] [varchar](6) NOT NULL,
	[Provincia] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Ubicacion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ubicacion_Detalle]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ubicacion_Detalle](
	[Id] [varchar](6) NOT NULL,
	[Id_Ubicacion] [varchar](6) NOT NULL,
	[Zona] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Ubicacion_Detalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[VistaDetailEdificio]    Script Date: 04/06/2013 19:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VistaDetailEdificio]
AS
SELECT	e.Id,e.Nombre,e.A_Contruccion,e.N_Plantas,e.mainFoto,u.Provincia,ud.Zona,ud.Direccion 
		,e.Inf_Adicional
FROM edificio e
JOIN Ubicacion_Detalle ud on e.Id_Ubi_Detalle = ud.Id
JOIN Ubicacion u on u.Id = ud.Id_Ubicacion

GO
ALTER TABLE [dbo].[Agente]  WITH CHECK ADD  CONSTRAINT [FK_Agente_Persona] FOREIGN KEY([Id_Persona])
REFERENCES [dbo].[Persona] ([Id])
GO
ALTER TABLE [dbo].[Agente] CHECK CONSTRAINT [FK_Agente_Persona]
GO
ALTER TABLE [dbo].[Alquiler_Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Alquiler_Apartamento_Agente] FOREIGN KEY([Id_Agente])
REFERENCES [dbo].[Agente] ([Id])
GO
ALTER TABLE [dbo].[Alquiler_Apartamento] CHECK CONSTRAINT [FK_Alquiler_Apartamento_Agente]
GO
ALTER TABLE [dbo].[Alquiler_Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Alquiler_Apartamento_Alquiler_Apartamento] FOREIGN KEY([Id_Cliente])
REFERENCES [dbo].[Cliente] ([Id])
GO
ALTER TABLE [dbo].[Alquiler_Apartamento] CHECK CONSTRAINT [FK_Alquiler_Apartamento_Alquiler_Apartamento]
GO
ALTER TABLE [dbo].[Alquiler_Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Alquiler_Apartamento_Especificacion_Apartamento] FOREIGN KEY([Id_EApartamento])
REFERENCES [dbo].[Apartamento] ([Id])
GO
ALTER TABLE [dbo].[Alquiler_Apartamento] CHECK CONSTRAINT [FK_Alquiler_Apartamento_Especificacion_Apartamento]
GO
ALTER TABLE [dbo].[Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Apartamento_Edificio] FOREIGN KEY([Id_Edificio])
REFERENCES [dbo].[Edificio] ([Id])
GO
ALTER TABLE [dbo].[Apartamento] CHECK CONSTRAINT [FK_Apartamento_Edificio]
GO
ALTER TABLE [dbo].[Casa]  WITH CHECK ADD  CONSTRAINT [FK_Casa_Ubicacion_Detalle] FOREIGN KEY([Id_Ubi_Detalle])
REFERENCES [dbo].[Ubicacion_Detalle] ([Id])
GO
ALTER TABLE [dbo].[Casa] CHECK CONSTRAINT [FK_Casa_Ubicacion_Detalle]
GO
ALTER TABLE [dbo].[Edificio]  WITH CHECK ADD  CONSTRAINT [FK_Edificio_Ubicacion_Detalle] FOREIGN KEY([Id_Ubi_Detalle])
REFERENCES [dbo].[Ubicacion_Detalle] ([Id])
GO
ALTER TABLE [dbo].[Edificio] CHECK CONSTRAINT [FK_Edificio_Ubicacion_Detalle]
GO
ALTER TABLE [dbo].[Edificio_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Edificio_Detalle_Edificio] FOREIGN KEY([Id_Edificio])
REFERENCES [dbo].[Edificio] ([Id])
GO
ALTER TABLE [dbo].[Edificio_Detalle] CHECK CONSTRAINT [FK_Edificio_Detalle_Edificio]
GO
ALTER TABLE [dbo].[Foto_Casa]  WITH CHECK ADD  CONSTRAINT [FK_Foto_Casa_Casa] FOREIGN KEY([Id_Casa])
REFERENCES [dbo].[Casa] ([Id])
GO
ALTER TABLE [dbo].[Foto_Casa] CHECK CONSTRAINT [FK_Foto_Casa_Casa]
GO
ALTER TABLE [dbo].[Foto_Casa]  WITH CHECK ADD  CONSTRAINT [FK_Foto_Casa_Ubicacion_Detalle] FOREIGN KEY([Id_Infrac_Detalle])
REFERENCES [dbo].[Ubicacion_Detalle] ([Id])
GO
ALTER TABLE [dbo].[Foto_Casa] CHECK CONSTRAINT [FK_Foto_Casa_Ubicacion_Detalle]
GO
ALTER TABLE [dbo].[Foto_Edificio]  WITH CHECK ADD  CONSTRAINT [FK_Foto_Edificio_Edificio] FOREIGN KEY([Id_Edificio])
REFERENCES [dbo].[Edificio] ([Id])
GO
ALTER TABLE [dbo].[Foto_Edificio] CHECK CONSTRAINT [FK_Foto_Edificio_Edificio]
GO
ALTER TABLE [dbo].[Fotos_Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Fotos_Apartamento_Apartamento] FOREIGN KEY([Id_Apartamento])
REFERENCES [dbo].[Apartamento] ([Id])
GO
ALTER TABLE [dbo].[Fotos_Apartamento] CHECK CONSTRAINT [FK_Fotos_Apartamento_Apartamento]
GO
ALTER TABLE [dbo].[Fotos_Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Fotos_Apartamento_Infraestructura_Detalle] FOREIGN KEY([Id_Infra_Detalle])
REFERENCES [dbo].[Infraestructura_Detalle] ([Id])
GO
ALTER TABLE [dbo].[Fotos_Apartamento] CHECK CONSTRAINT [FK_Fotos_Apartamento_Infraestructura_Detalle]
GO
ALTER TABLE [dbo].[Infraestructura_Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Infraestructura_Apartamento_Apartamento] FOREIGN KEY([Id_Apartamento])
REFERENCES [dbo].[Apartamento] ([Id])
GO
ALTER TABLE [dbo].[Infraestructura_Apartamento] CHECK CONSTRAINT [FK_Infraestructura_Apartamento_Apartamento]
GO
ALTER TABLE [dbo].[Infraestructura_Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Infraestructura_Apartamento_Infraestructura_Detalle] FOREIGN KEY([Id_Infrac_Detalle])
REFERENCES [dbo].[Infraestructura_Detalle] ([Id])
GO
ALTER TABLE [dbo].[Infraestructura_Apartamento] CHECK CONSTRAINT [FK_Infraestructura_Apartamento_Infraestructura_Detalle]
GO
ALTER TABLE [dbo].[Infraestructura_Casa]  WITH CHECK ADD  CONSTRAINT [FK_Infraestructura_Casa_Casa] FOREIGN KEY([Id_casa])
REFERENCES [dbo].[Casa] ([Id])
GO
ALTER TABLE [dbo].[Infraestructura_Casa] CHECK CONSTRAINT [FK_Infraestructura_Casa_Casa]
GO
ALTER TABLE [dbo].[Infraestructura_Casa]  WITH CHECK ADD  CONSTRAINT [FK_Infraestructura_Casa_Infraestructura_Detalle1] FOREIGN KEY([Id_Infrac_Detalle])
REFERENCES [dbo].[Infraestructura_Detalle] ([Id])
GO
ALTER TABLE [dbo].[Infraestructura_Casa] CHECK CONSTRAINT [FK_Infraestructura_Casa_Infraestructura_Detalle1]
GO
ALTER TABLE [dbo].[Infraestructura_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Infraestructura_Detalle_Infraestructura] FOREIGN KEY([Id_Infra])
REFERENCES [dbo].[Infraestructura] ([Id])
GO
ALTER TABLE [dbo].[Infraestructura_Detalle] CHECK CONSTRAINT [FK_Infraestructura_Detalle_Infraestructura]
GO
ALTER TABLE [dbo].[Pagos_Alquiler_Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Pagos_Alquiler_Apartamento_Alquiler_Apartamento] FOREIGN KEY([Id_Alquiler_Apartamento])
REFERENCES [dbo].[Alquiler_Apartamento] ([Id])
GO
ALTER TABLE [dbo].[Pagos_Alquiler_Apartamento] CHECK CONSTRAINT [FK_Pagos_Alquiler_Apartamento_Alquiler_Apartamento]
GO
ALTER TABLE [dbo].[Persona]  WITH CHECK ADD  CONSTRAINT [FK_Persona_Ubicacion_Detalle] FOREIGN KEY([Id_Ubicacion])
REFERENCES [dbo].[Ubicacion_Detalle] ([Id])
GO
ALTER TABLE [dbo].[Persona] CHECK CONSTRAINT [FK_Persona_Ubicacion_Detalle]
GO
ALTER TABLE [dbo].[Servcio_Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Servcio_Apartamento_Apartamento] FOREIGN KEY([Id_Apartemento])
REFERENCES [dbo].[Apartamento] ([Id])
GO
ALTER TABLE [dbo].[Servcio_Apartamento] CHECK CONSTRAINT [FK_Servcio_Apartamento_Apartamento]
GO
ALTER TABLE [dbo].[Servcio_Apartamento]  WITH CHECK ADD  CONSTRAINT [FK_Servcio_Apartamento_Servicios] FOREIGN KEY([Id_Servicio])
REFERENCES [dbo].[Servicios] ([Id])
GO
ALTER TABLE [dbo].[Servcio_Apartamento] CHECK CONSTRAINT [FK_Servcio_Apartamento_Servicios]
GO
ALTER TABLE [dbo].[Servicio_Casa]  WITH CHECK ADD  CONSTRAINT [FK_Servicio_Casa_Casa] FOREIGN KEY([Id_casa])
REFERENCES [dbo].[Casa] ([Id])
GO
ALTER TABLE [dbo].[Servicio_Casa] CHECK CONSTRAINT [FK_Servicio_Casa_Casa]
GO
ALTER TABLE [dbo].[Servicio_Casa]  WITH CHECK ADD  CONSTRAINT [FK_Servicio_Casa_Servicios] FOREIGN KEY([Id_servicio])
REFERENCES [dbo].[Servicios] ([Id])
GO
ALTER TABLE [dbo].[Servicio_Casa] CHECK CONSTRAINT [FK_Servicio_Casa_Servicios]
GO
ALTER TABLE [dbo].[Ubicacion_Detalle]  WITH CHECK ADD  CONSTRAINT [FK_Ubicacion_Detalle_Ubicacion] FOREIGN KEY([Id_Ubicacion])
REFERENCES [dbo].[Ubicacion] ([Id])
GO
ALTER TABLE [dbo].[Ubicacion_Detalle] CHECK CONSTRAINT [FK_Ubicacion_Detalle_Ubicacion]
GO
