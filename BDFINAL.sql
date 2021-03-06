USE [master]
GO
/****** Object:  Database [INMOBILIARIA]    Script Date: 05/06/2013 14:35:55 ******/
CREATE DATABASE [INMOBILIARIA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'INMOBILIARIA', FILENAME = N'F:\AppMerlo\INMOBILIARIA.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'INMOBILIARIA_log', FILENAME = N'F:\AppMerlo\INMOBILIARIA.ldf' , SIZE = 4672KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [INMOBILIARIA] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [INMOBILIARIA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [INMOBILIARIA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET ARITHABORT OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [INMOBILIARIA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [INMOBILIARIA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [INMOBILIARIA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [INMOBILIARIA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [INMOBILIARIA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET RECOVERY FULL 
GO
ALTER DATABASE [INMOBILIARIA] SET  MULTI_USER 
GO
ALTER DATABASE [INMOBILIARIA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [INMOBILIARIA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [INMOBILIARIA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [INMOBILIARIA] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [INMOBILIARIA]
GO
/****** Object:  User [Vmerlo]    Script Date: 05/06/2013 14:35:55 ******/
CREATE USER [Vmerlo] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [UMerlo]    Script Date: 05/06/2013 14:35:55 ******/
CREATE USER [UMerlo] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[sys]
GO
/****** Object:  User [MerloV]    Script Date: 05/06/2013 14:35:55 ******/
CREATE USER [MerloV] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Mer]    Script Date: 05/06/2013 14:35:55 ******/
CREATE USER [Mer] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [UMerlo]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [UMerlo]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [UMerlo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Mer]
GO
/****** Object:  StoredProcedure [dbo].[InsertApartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertCasa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertDetalleUbicacion]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertEdificio]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertFotoCasa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertFotoEdificio]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertFotosApartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertInfra_Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertInfraCasa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertInfraDetalle]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertInfrastructura]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertServicio]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertServicioApartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertServicioCasa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertUbicacion]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[msp_getAllEdificio]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[msp_ModificarEdificio]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Casa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Edificio]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Edificio_Detalle]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_EliminarEdificio]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Infraestructura]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Infraestructura_Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Infraestructura_Casa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Infraestructura_Detalle]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Servcio_Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Servicio_Casa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Servicios]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Ubicacion]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Ubicacion_Detalle]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fun_GetIDUbicacion]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  UserDefinedFunction [dbo].[nf_Incrementar_Id]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Agente]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Alquiler_Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Casa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Edificio]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Edificio_Detalle]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Especificacion_Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Foto_Casa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Foto_Edificio]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Fotos_Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Infraestructura]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Infraestructura_Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Infraestructura_Casa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Infraestructura_Detalle]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Pagos_Alquiler_Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Persona]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Servcio_Apartamento]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Servicio_Casa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Servicios]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Tipo_Casa]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Ubicacion]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  Table [dbo].[Ubicacion_Detalle]    Script Date: 05/06/2013 14:35:55 ******/
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
/****** Object:  View [dbo].[VistaDetailEdificio]    Script Date: 05/06/2013 14:35:55 ******/
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
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_001', N'E_001', 3, 1, N'A')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_002', N'E_001', 4, 2, N'B')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_003', N'E_001', 5, 4, N'B')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_004', N'E_002', 4, 2, N'A')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_005', N'E_002', 5, 1, N'B')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_006', N'E_004', 3, 2, N'A')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_007', N'E_003', 6, 3, N'B')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_008', N'E_001', 4, 3, N'B')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_009', N'E_004', 5, 4, N'D')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_010', N'E_001', 3, 12, N'B')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_011', N'E_006', 12, 2, N'A')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_012', N'E_006', 44, 3, N'B')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_013', N'E_005', 12, 3, N'B')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_014', N'E_005', 4, 3, N'A')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_015', N'E_006', 15, 15, N'B')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_016', N'E_005', 33, 44, N'A')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_017', N'E_001', 112, 45, N'A')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_018', N'E_001', 4, 6, N'B')
INSERT [dbo].[Apartamento] ([Id], [Id_Edificio], [N_Piso], [N_Puerta], [Bloque]) VALUES (N'A_019', N'E_002', 4, 43, N'A')
INSERT [dbo].[Casa] ([Id], [Id_TipoCasa], [Mts2], [Id_Ubi_Detalle], [Direccion]) VALUES (N'C_001', N'Chalet', N'250', N'UD_001', NULL)
INSERT [dbo].[Casa] ([Id], [Id_TipoCasa], [Mts2], [Id_Ubi_Detalle], [Direccion]) VALUES (N'C_002', N'Chalet', N'Metros Cuadrados:', N'UD_002', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_001', N'UD_001', N'Las Lomas', CAST(0x0000972800000000 AS DateTime), 3, N'Ninguno', N'http://localhost:2360/Images/e1.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_002', N'UD_001', N'Radison sxxx', CAST(0x0000900400000000 AS DateTime), 13, N'Ninguno', N'http://localhost::2360/Images/e3.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_003', N'UD_002', N'San Jorge', CAST(0x0000954D00000000 AS DateTime), 15, N'Ninguno', N'http://localhost:2360/Images/e1.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_004', N'UD_004', N'Bolivar', CAST(0x00009D1200000000 AS DateTime), 10, N'Ninguno', N'http://localhost:2360/Images/e3.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_005', N'UD_011', N'Las Lomas', CAST(0x0000A06800000000 AS DateTime), 7, N'Ninguna
', N'http://localhost:2360/Images/e2.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_006', N'UD_001', N'super edificio', CAST(0x0000A1F200000000 AS DateTime), 40, N'insdertads fo a new ejs ademas tiene 2 acesores una escalera mecanica pisina sauna ', N'http://localhost:1835/Images/ Lighthouse.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_007', N'UD_001', N'hh', CAST(0x0000A13D00000000 AS DateTime), 4, N'ssfsf', N'http://localhost:1835/Images/ Personal 4.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_008', N'UD_001', N'fff', CAST(0x0000A14900000000 AS DateTime), 3, N'ewrewr', N'http://localhost:1835/Images/ Chrysanthemum.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_009', N'UD_013', N'rewr', CAST(0x00009D2000000000 AS DateTime), 3, N'rrr', N'http://localhost:2360/Images/e4.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_010', N'UD_004', N'dasd', CAST(0x0000A1BF00000000 AS DateTime), 3, N'wsdsadas', N'http://localhost:2360/Images/Adidas.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_011', N'UD_002', N'Radison II', CAST(0x00009C0500000000 AS DateTime), 30, N'contruccion nueva', N'http://localhost:2360/Images/Personal 4.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_012', N'UD_001', N'eee', CAST(0x0000A1B700000000 AS DateTime), 333, N'rerer', N'http://localhost:2360/Images/Inmuebles 1.jpg', NULL)
INSERT [dbo].[Edificio] ([Id], [Id_Ubi_Detalle], [Nombre], [A_Contruccion], [N_Plantas], [Inf_Adicional], [mainfoto], [Direccion]) VALUES (N'E_013', N'UD_002', N'dede', CAST(0x0000A1D400000000 AS DateTime), 12, N'dasd', N'http://localhost:2360/Images/Inmuebles 1.jpg', N'calle fatima')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_001', N'E_002', N'D:\Presentation\Presentation\bin\Debug\image\Lighthouse.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_002', N'E_002', N'D:\Presentation\Presentation\bin\Debug\image\Koala.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_003', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Chrysanthemum.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_006', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Hydrangeas.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_007', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Tulips.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_008', N'E_002', N'D:\Presentation\Presentation\bin\Debug\image\Sacaca%20Groups.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_009', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Jellyfish.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_010', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Jellyfish.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_011', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Jellyfish.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_012', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Penguins.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_013', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Penguins.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_014', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Penguins.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_015', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Penguins.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_016', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_017', N'E_001', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_018', N'E_002', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_019', N'E_002', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_020', N'E_002', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_021', N'E_002', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_022', N'E_002', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_023', N'E_002', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_024', N'E_005', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_025', N'E_005', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_026', N'E_005', N'D:\Presentation\Presentation\bin\Debug\image\Desert.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_027', N'E_003', N'D:\Presentation\Presentation\bin\Debug\image\Chrysanthemum.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_028', N'E_003', N'D:\Presentation\Presentation\bin\Debug\image\Penguins.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_029', N'E_003', N'D:\Presentation\Presentation\bin\Debug\image\Tulips.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_030', N'E_003', N'D:\Presentation\Presentation\bin\Debug\image\Jellyfish.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_031', N'E_003', N'D:\Presentation\Presentation\bin\Debug\image\Koala.jpg')
INSERT [dbo].[Edificio_Detalle] ([Id], [Id_Edificio], [Foto]) VALUES (N'ED_032', N'E_003', N'D:\Presentation\Presentation\bin\Debug\image\Hydrangeas.jpg')
INSERT [dbo].[Foto_Edificio] ([Id], [Id_Edificio], [Foto], [Descripcion]) VALUES (N'FE_001', N'E_001', N'http://localhost:2360/Images/Imagenes Casas y Departamentos en Venta/Apartamento 3.jpg', N'Super Hot')
INSERT [dbo].[Foto_Edificio] ([Id], [Id_Edificio], [Foto], [Descripcion]) VALUES (N'FE_002', N'E_001', N'http://localhost:2360/Images/Imagenes Casas y Departamentos en Venta/Inmuebles 4.jpg', N'JAJA')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_001', N'http://localhost:2360/Images/Apartamento 2.jpg', N'ID_001', N'A_001', N'ADSA')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_002', N'http://localhost:2360/Images/Inmuebles 1.jpg', N'ID_004', N'A_001', N'dsedsad')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_003', N'http://localhost:2360/Images/e4.jpg', N'ID_004', N'A_001', N'efsdfsd')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_004', N'http://localhost:2360/Images/Adidas.jpg', N'ID_003', N'A_001', N'dfsdfsd')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_005', N'http://localhost:2360/Images/e4.jpg', N'ID_001', N'A_001', N'dfgdfgd')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_006', N'http://localhost:2360/Images/e3.jpg', N'ID_004', N'A_001', N'dfghdfgh')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_007', N'http://localhost:2360/Images/Inmuebles 1.jpg', N'ID_003', N'A_001', N'fdghdfh')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_008', N'http://localhost:2360/Images/Personal 5.jpg', N'ID_011', N'A_001', N'tfghh')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_009', N'http://localhost:2360/Images/e2.jpg', N'ID_003', N'A_001', N'dfhdfh')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_010', N'http://localhost:2360/Images/Imagenes Casas y Departamentos en Venta/Apartamento 1.jpg', N'ID_001', N'A_001', N'bvc')
INSERT [dbo].[Fotos_Apartamento] ([Id], [Foto], [Id_Infra_Detalle], [Id_Apartamento], [Descripcion]) VALUES (N'FA_011', N'http://localhost:2360/Images/Imagenes Casas y Departamentos en Venta/Apartamento 3.jpg', N'ID_004', N'A_001', N'ewre')
INSERT [dbo].[Infraestructura] ([Id], [Nombre]) VALUES (N'I_001', N'Baño')
INSERT [dbo].[Infraestructura] ([Id], [Nombre]) VALUES (N'I_002', N'Cocina')
INSERT [dbo].[Infraestructura] ([Id], [Nombre]) VALUES (N'I_003', N'Habitacion')
INSERT [dbo].[Infraestructura] ([Id], [Nombre]) VALUES (N'I_004', N'Living')
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_001', N'A_001', N'ID_002', 1)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_002', N'A_001', N'ID_003', 2)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_004', N'A_001', N'ID_005', NULL)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_005', N'A_001', N'ID_003', 2)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_006', N'A_001', N'ID_004', 4)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_007', N'A_002', N'ID_003', 4)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_008', N'A_002', N'ID_004', 1)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_009', N'A_008', N'ID_001', 2)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_010', N'A_008', N'ID_004', 1)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_011', N'A_001', N'ID_011', 1)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_012', N'A_003', N'ID_003', 4)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_013', N'A_003', N'ID_001', 1)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_014', N'A_001', N'ID_001', 2)
INSERT [dbo].[Infraestructura_Apartamento] ([Id], [Id_Apartamento], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IA_015', N'A_010', N'ID_013', 3)
INSERT [dbo].[Infraestructura_Casa] ([Id], [Id_casa], [Id_Infrac_Detalle], [Cantidad]) VALUES (N'IC_001', N'C_001', N'ID_002', NULL)
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_001', N'I_001', N'3x4', N'Pose tina con Idromasaje')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_002', N'I_001', N'5x5', N'Pose tina con Idromasaje y sauna')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_003', N'I_001', N'2x2', N'Baño Normal')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_004', N'I_002', N'5x6', N'Amoblado Con campana')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_005', N'I_003', N'5x5', N'Habitacion doble con ropero empotrado')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_006', N'I_002', N'4x5', N'Amplia y Acogedor')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_007', N'I_003', N'5X4', N'Cuenta con Tv Satelital ASBOX')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_008', N'I_003', N'5X3', N'Cuenta con ropero empotrado y armarios amplios')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_009', N'I_004', N'3X4', N'Cuenta con aire acondicionado, bar privado
')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_010', N'I_004', N'5x6', N'Cuenta bar privado y un salon de estudio
')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_011', N'I_002', N'4x8', N'cuenta con churrazquero y horno 
')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_012', N'I_004', N'6x8', N'Cuenta sala de estudio y comedor
,
')
INSERT [dbo].[Infraestructura_Detalle] ([Id], [Id_Infra], [Tamano], [Descripcion]) VALUES (N'ID_013', N'I_001', N'4x5', N'super baño
')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_001', N'A_001', N'S_001')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_002', N'A_001', N'S_002')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_003', N'A_001', N'S_004')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_004', N'A_002', N'S_001')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_071', N'A_006', N'S_001')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_006', N'A_002', N'S_001')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_007', N'A_018', N'S_001')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_008', N'A_018', N'S_002')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_009', N'A_018', N'S_003')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_010', N'A_018', N'S_004')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_011', N'A_018', N'S_005')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_012', N'A_018', N'S_006')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_013', N'A_018', N'S_007')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_014', N'A_018', N'S_008')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_015', N'A_018', N'S_009')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_016', N'A_018', N'S_010')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_017', N'A_018', N'S_011')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_018', N'A_018', N'S_012')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_019', N'A_018', N'S_013')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_020', N'A_018', N'S_014')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_021', N'A_018', N'S_015')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_072', N'A_006', N'S_002')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_023', N'A_018', N'S_002')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_025', N'A_018', N'S_004')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_026', N'A_018', N'S_005')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_027', N'A_018', N'S_006')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_028', N'A_018', N'S_007')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_029', N'A_018', N'S_008')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_030', N'A_018', N'S_009')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_031', N'A_018', N'S_010')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_032', N'A_018', N'S_011')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_033', N'A_018', N'S_012')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_034', N'A_018', N'S_013')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_035', N'A_018', N'S_014')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_036', N'A_018', N'S_015')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_037', N'A_003', N'S_001')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_038', N'A_003', N'S_002')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_039', N'A_003', N'S_003')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_040', N'A_003', N'S_004')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_041', N'A_003', N'S_005')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_042', N'A_003', N'S_018')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_043', N'A_008', N'S_001')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_044', N'A_008', N'S_002')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_045', N'A_008', N'S_003')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_046', N'A_008', N'S_004')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_047', N'A_008', N'S_005')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_048', N'A_008', N'S_006')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_049', N'A_008', N'S_007')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_050', N'A_008', N'S_008')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_051', N'A_008', N'S_009')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_052', N'A_008', N'S_010')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_053', N'A_008', N'S_011')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_054', N'A_008', N'S_012')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_055', N'A_008', N'S_013')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_056', N'A_008', N'S_014')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_057', N'A_008', N'S_015')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_058', N'A_008', N'S_016')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_059', N'A_004', N'S_002')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_060', N'A_005', N'S_003')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_061', N'A_004', N'S_003')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_062', N'A_004', N'S_004')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_063', N'A_005', N'S_001')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_064', N'A_005', N'S_002')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_065', N'A_019', N'S_001')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_066', N'A_019', N'S_002')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_067', N'A_019', N'S_005')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_068', N'A_007', N'S_001')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_069', N'A_007', N'S_002')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_070', N'A_007', N'S_004')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_073', N'A_006', N'S_003')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_074', N'A_006', N'S_004')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_075', N'A_006', N'S_005')
INSERT [dbo].[Servcio_Apartamento] ([Id], [Id_Apartemento], [Id_Servicio]) VALUES (N'SA_076', N'A_006', N'S_006')
INSERT [dbo].[Servicio_Casa] ([Id], [Id_casa], [Id_servicio]) VALUES (N'SC_001', N'C_001', N'S_001')
INSERT [dbo].[Servicio_Casa] ([Id], [Id_casa], [Id_servicio]) VALUES (N'SC_002', N'C_001', N'S_002')
INSERT [dbo].[Servicio_Casa] ([Id], [Id_casa], [Id_servicio]) VALUES (N'SC_003', N'C_001', N'S_004')
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_001', N'Agua', N'Basico', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_002', N'Luz', N'Basico', N'All day')
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_003', N'Asensor', N'Adicional', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_004', N'ADSL', N'Adicional', N'100 mb reales')
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_005', N'Internet', N'Adicional', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_006', N'A6', N'a', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_007', N'a7', N'a', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_008', N'a8', N'asa', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_009', N'a9', N'aaaa', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_010', N'a10', N'wee', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_011', N'a11', N'wee', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_012', N'a12', N'frf', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_013', N'a13', N'frf', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_014', N'a14', N'frf', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_015', N'a15', N'frf', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_016', N'a', N'frf', NULL)
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_017', N'a16', N'Basico', N'weeee
')
INSERT [dbo].[Servicios] ([Id], [Nombre], [Tipo], [Descripcion]) VALUES (N'S_018', N'Aire Acondicionado', N'Adicional', N'
')
INSERT [dbo].[Ubicacion] ([Id], [Provincia]) VALUES (N'U_001', N'Quillacollo')
INSERT [dbo].[Ubicacion] ([Id], [Provincia]) VALUES (N'U_002', N'Sacaba')
INSERT [dbo].[Ubicacion] ([Id], [Provincia]) VALUES (N'U_003', N'Chapare')
INSERT [dbo].[Ubicacion] ([Id], [Provincia]) VALUES (N'U_004', N'Cercado')
INSERT [dbo].[Ubicacion] ([Id], [Provincia]) VALUES (N'U_005', N'CAPINOTA')
INSERT [dbo].[Ubicacion] ([Id], [Provincia]) VALUES (N'U_006', N'Bolivar')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_001', N'U_001', N'Colcapirua')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_002', N'U_001', N'Vinto')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_003', N'U_001', N'San Jorge')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_004', N'U_002', N'Chimboco')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_005', N'U_005', N'VALLE BAJO')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_006', N'U_001', N'Sarco')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_007', N'U_001', N'Paso')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_008', N'U_004', N'Norte')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_009', N'U_002', N'TuTi Mayu')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_010', N'U_004', N'Sud')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_011', N'U_003', N'Shinaota')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_012', N'U_001', N'Calvario')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_013', N'U_006', N'Ballivian')
INSERT [dbo].[Ubicacion_Detalle] ([Id], [Id_Ubicacion], [Zona]) VALUES (N'UD_014', N'U_006', N'Los Alamos')
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
USE [master]
GO
ALTER DATABASE [INMOBILIARIA] SET  READ_WRITE 
GO
