GO
/****** Object:  StoredProcedure [dbo].[Portal_Login]    Script Date: 12/3/2025 16:38:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---update Funcionario set Constrasena = 'c/E/IA5njW3iG74ssk8N4g==' where CodigoFuncionario = 49
---select IdentificacionFuncionario, Constrasena from Funcionario
--   Portal_Login '1759277526','654terertdfddfdf'
--Portal_Login '0801505371', 'qJ05SbQIoRo7EiSn1Ama3A=='
--Portal_Login '', ''

ALTER PROCEDURE [dbo].[Portal_Login]
@username varchar(20),
@password varchar(50)
as
	declare @resp varchar(50) = '';
	declare @CodigoFuncionario int;
	declare @EsPrimerIngreso int=0;
	select @EsPrimerIngreso=isnull(EsPrimerIngreso,0) 
	,@CodigoFuncionario=CodigoFuncionario
	from Funcionario where --EstadoFuncionario=1 and 
	IdentificacionFuncionario = @username and CodigoRelacion=1
	print @EsPrimerIngreso


		DECLARE @CantidadPersonasACargo int=0
		select @CantidadPersonasACargo=count(*) from Funcionario where CodigoJefeFuncionario=@CodigoFuncionario and EstadoFuncionario=1
		PRINT 'DATOS:'
		PRINT @CodigoFuncionario
		PRINT @CantidadPersonasACargo

	if(@EsPrimerIngreso=1) 
	begin
		SET @resp = '1';
		select @resp AS resp, CodigoFuncionario, IdentificacionFuncionario,NombreCompleto=case when isnull(@CantidadPersonasACargo,0)=0 then 'TECNICO' else 'DELEGADO' END  from Funcionario where IdentificacionFuncionario = @username
	end
	else begin
	    declare @EstadoFuncionario int=0
		set @CodigoFuncionario=0
		select @EstadoFuncionario=EstadoFuncionario,@CodigoFuncionario=CodigoFuncionario from  Funcionario where CodigoRelacion=1 and IdentificacionFuncionario = @username and Constrasena = @password
	    if(@EstadoFuncionario=1)begin
			IF exists((select 1 from Funcionario where CodigoRelacion=1 and EstadoFuncionario=1 and IdentificacionFuncionario = @username and Constrasena = @password)) BEGIN
				SET @resp = '1';
				select @resp AS resp, CodigoFuncionario, IdentificacionFuncionario,NombreCompleto=case when isnull(@CantidadPersonasACargo,0)=0 then 'TECNICO' else 'DELEGADO' END 
				from Funcionario where IdentificacionFuncionario = @username and Constrasena = @password

			END
			ELSE BEGIN
				SET @resp = 'Tus credenciales son incorrectas'
				select @resp AS resp, 0 CodigoFuncionario, '0' IdentificacionFuncionario,'' NombreCompleto
			END
		END
		ELSE
		BEGIN
			print  @CodigoFuncionario
		   IF(@CodigoFuncionario=2485)BEGIN
		        IF exists((select 1 from Funcionario where CodigoRelacion=1 and IdentificacionFuncionario = @username and Constrasena = @password)) BEGIN
					SET @resp = '1';
					select @resp AS resp, CodigoFuncionario, IdentificacionFuncionario,NombreCompleto=case when isnull(@CantidadPersonasACargo,0)=0 then 'TECNICO' else 'DELEGADO' END  
					from Funcionario where IdentificacionFuncionario = @username and Constrasena = @password

				END
				ELSE BEGIN
					SET @resp = 'Tus credenciales son incorrectas'
					select @resp AS resp, 0 CodigoFuncionario, '0' IdentificacionFuncionario,'' NombreCompleto
				END
		   END
		   ELSE BEGIN
		       SET @resp = 'Tus credenciales son incorrectas.'--'Usuario inactivo, no puede ingresar.'
					select @resp AS resp, 0 CodigoFuncionario, '0' IdentificacionFuncionario,'' NombreCompleto
		   END
		  
		END
	end