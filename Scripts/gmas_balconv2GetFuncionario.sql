USE [NominaGP_PRB]
GO
/****** Object:  StoredProcedure [dbo].[gmas_balconv2GetFuncionario]    Script Date: 2/4/2025 09:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---select * from Funcionario

--   [dbo].[gmas_balconv2GetFuncionario] '1715003057'

ALTER PROCEDURE [dbo].[gmas_balconv2GetFuncionario]
--declare
@IdentificacionFuncionario varchar(15)='1712456936'
as

 
   select  fun.CodigoFuncionario
         , fun.CodigoTipoIdentificacion, fun.IdentificacionFuncionario
         , CodigoIESS=isnull(fun.CodigoIESS,'')
		 , fun.NombreCompleto
		 , NombrePreferido=isnull(fun.NombrePreferido,fun.NombreCompleto)
		 , FechaNacimientoFuncionario=isnull(fun.FechaNacimientoFuncionario,getdate())
		 , EstadoCivilFuncionario=convert(varchar(50),isnull(fun.EstadoCivilFuncionario,''))
		 , Sexo=isnull(sexo.DescripcionConfiguracion,'')
		 , Genero=ISNULL(gen.DescripcionGenero,'')
		 , Etnia=isnull(etnia.NombreEtnia,'')
		 , Region=isnull(reg.DescripcionRegion,'')
		 , TipoSangre=isnull(sang.NombreTipoSangre,'')
		 , Nacionalidad=isnull(nac.NombreNacionalidad,'')
		 , Pais=isnull(pa.NombrePais,'')
		 , Provincia=isnull(prov.NombreProvincia,'')
		 , Canton=isnull(can.NombreCanton,'')
		 , Parroquia=isnull(parr.NombreDistrito,'')
		 , CiudadNacimiento=isnull(fun.CiudadNacimiento,'')
		 , CiudadTrabajo=isnull(fun.CiudadTrabajo,'')		 
		 , DireccionExactaFuncionario=isnull(fun.DireccionExactaFuncionario,'')
		 , CorreoElectronicoFuncionario=isnull(fun.CorreoElectronicoFuncionario,'')
		 , CorreoElectronicoFuncionarioPersonal=isnull(fun.CorreoElectronicoFuncionarioPersonal,'')
		 , TelefonoCasa=isnull(fun.TelefonoCasa,'')
		 , TelefonoCelular=isnull(fun.TelefonoCelular,'')
		 , TelefonoOficina=isnull(fun.TelefonoOficina,'')
		 , TelefonoOficinaExtension=isnull(fun.TelefonoOficinaExtension,'')
		 , ContactoEmergenciaNombre=isnull(fun.ContactoEmergenciaNombre,'')
		 , ContactoEmergenciaTelefono=isnull(fun.ContactoEmergenciaTelefono,'')
		 , NumeroOficina=isnull(fun.NumeroOficina,'')
		
		 , fun.fotofuncionario			
		 , RutaFoto1=isnull(fun.RutaFoto1 ,'')
		 ,FechaPrimerIngreso=fun.FechaIngresoFuncionario
		 ,FechaUltimoIngreso=fun.FechaCalculoFuncionario
		 ,AniosAntiguedad=convert(decimal(18,2),[dbo].[FN_gmas_paga_fondo_reserva2](fun.CodigoFuncionario,getdate())/12.00)
		 ,AreaRRHH=isnull(area.DescripcionUnidades,'')
		 ,FechaIngresoLetras= convert(nvarchar,DATEPART(DD,fun.FechaCalculoFuncionario))+' de '+
		    CASE WHEN DATEPART(month,fun.FechaCalculoFuncionario)=1 THEN 'enero'
		     WHEN DATEPART(month,fun.FechaCalculoFuncionario)=2 THEN 'febrero'
			 WHEN DATEPART(month,fun.FechaCalculoFuncionario)=3 THEN 'marzo'
			 WHEN DATEPART(month,fun.FechaCalculoFuncionario)=4 THEN 'abril'
			 WHEN DATEPART(month,fun.FechaCalculoFuncionario)=5 THEN 'mayo'
			 WHEN DATEPART(month,fun.FechaCalculoFuncionario)=6 THEN 'junio'
			 WHEN DATEPART(month,fun.FechaCalculoFuncionario)=7 THEN 'julio'
			 WHEN DATEPART(month,fun.FechaCalculoFuncionario)=8 THEN 'agosto'
			 WHEN DATEPART(month,fun.FechaCalculoFuncionario)=9 THEN 'septiembre'
			 WHEN DATEPART(month,fun.FechaCalculoFuncionario)=10 THEN 'octubre'
			 WHEN DATEPART(month,fun.FechaCalculoFuncionario)=11 THEN 'noviembre'
			 ELSE 'diciembre' END
		+' del '+ convert(nvarchar,DATEPART(year,fun.FechaCalculoFuncionario))
		,NombreSupervisor=isnull(supervisor.NombrePreferido,supervisor.NombreCompleto)
		,EmailSupervisor=isnull(supervisor.CorreoElectronicoFuncionario,'')
		,CodigoSupervisor=isnull(supervisor.CodigoFuncionario,null)
		,IdentificacionSupervisor=isnull(supervisor.IdentificacionFuncionario,null)
	 from Funcionario fun
	 left join Configuraciones ecivil on fun.EstadoCivilFuncionario=ecivil.CodigoConfiguracion and ecivil.DescripcionConfiguracion='EstadoCivil'
	 left join Configuraciones sexo on fun.EstadoCivilFuncionario=sexo.CodigoConfiguracion and sexo.DescripcionConfiguracion='Sexo'
	 left join genero gen on fun.CodigoGenero=gen.CodigoGenero
	 left join GrupoEtnico etnia on fun.CodigoEtnia=etnia.CodigoEtnia
	 left join Regiones reg on fun.CodigoRegion=reg.CodigoRegion
	 left join TipoSangre sang on fun.CodigoTipoSangre=sang.CodigoTipoSangre
	 left join Nacionalidad nac on fun.CodigoNacionalidad=nac.CodigoNacionalidad
	 left join pais pa on fun.CodigoPais=pa.CodigoPais
	 left join Provincia prov on fun.CodigoProvincia=prov.CodigoProvincia
	 left join Canton can on fun.CodigoCanton=can.CodigoCanton
	 left join Distrito parr on fun.CodigoParroquia=parr.CodigoDistrito
	 left join Unidades area on fun.CodigoUnidades=area.CodigoUnidades
	 left join Funcionario supervisor on fun.CodigoJefeFuncionario=supervisor.CodigoFuncionario
	where fun.IdentificacionFuncionario=@IdentificacionFuncionario
	and fun.CodigoRelacion in(1) --Relación de Dependencia
	