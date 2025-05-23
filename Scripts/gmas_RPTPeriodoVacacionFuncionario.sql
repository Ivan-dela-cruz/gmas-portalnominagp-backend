


--[dbo].[gmas_RPTPeriodoVacacionFuncionario] 8161,2,0,1
ALTER PROCEDURE [dbo].[gmas_RPTPeriodoVacacionFuncionarioV2]
--DECLARE
@CodigoFuncionario int =5
,@CodigoEmpresa int=2
,@CodigoSucursal int=0
,@EstadoEmpleado INT=1
AS
		
		SELECT 
		f.CodigoFuncionario
		,f.IdentificacionFuncionario
		,f.NombreCompleto
		,fechadesde=convert(varchar(10),p.FechaInicialPeriodoVacacionesFuncionario,120)
		,fechahasta=convert(varchar(10),p.FechaFinalPeriodoVacacionesFuncionario,120)
		,EstadoPV=case when p.EstadoPeriodoVacacionesFuncionario=1 then 'Abierto' else 'Cerrado' end
		,DiasBase=round(p.DiasBasePeriodoVacacionesFuncionario,0)
		,DiasAdicional=round(DiasAdicionalPeriodoVacacionesFuncionario,0)
		,TomadosVAC=convert(decimal(18,2),round([dbo].[FN_gmas_DevuelveDiasVacacacionXPeriodo](p.CodigoFuncionario,p.CodigoPeriodoVacacionesFuncionario),0))
		,LibresVAC=convert(decimal(18,2),round(p.DiasTotalesPeriodoVacacionesFuncionario-[dbo].[FN_gmas_DevuelveDiasVacacacionXPeriodo](p.CodigoFuncionario,p.CodigoPeriodoVacacionesFuncionario),0))
		,TomadosANT=0.00
		,LibresANT=0.00
		,e.NombreEmpresa
		,e.LogoEmpresa
		,FechaCalculoFuncionario=case when fsalida.FechaSalida is null and f.FechaCalculoFuncionario>fe.FechaIngreso then isnull(fe.FechaIngreso,f.FechaCalculoFuncionario) else ( case when fsalida.FechaSalida<f.FechaCalculoFuncionario then f.FechaCalculoFuncionario else isnull(fe.FechaIngreso,f.FechaCalculoFuncionario) end) end
		,Observacion=''--case when sum(tmp.CantidadDiasPermiso) is null then '' else 'Dias anticipados a vacaciones: '+convert(nvarchar,sum(tmp.CantidadDiasPermiso)) end
		FROM PeriodoVacacionesFuncionario p 
		join Funcionario f on f.CodigoFuncionario=p.CodigoFuncionario
		join Empresa e on e.codigoempresa=f.codigoempresa
		left join (
		select FechaIngreso=Min(fe.FechaIngreso),fe.CodigoFuncionario 
		from FechaEntradaSalidaEfectiva fe where fe.CodigoMotivoSalida=15 group by fe.CodigoFuncionario
		) fe  on fe.codigofuncionario=f.CodigoFuncionario 

		left join (
		     select FechaSalida=max(FechaSalida),CodigoFuncionario
			 from FechaEntradaSalidaEfectiva 
			 where CodigoMotivoSalida is not null and CodigoMotivoSalida !=15
			 group by CodigoFuncionario
		)fsalida on fsalida.CodigoFuncionario=f.CodigoFuncionario
		

		WHERE (@CodigoFuncionario =0 or F.CODIGOFUNCIONARIO=@CodigoFuncionario)
		and ((@EstadoEmpleado=-99 or @EstadoEmpleado=0)or(f.EstadoFuncionario=@EstadoEmpleado))
		and (@CodigoEmpresa=0 or f.CodigoEmpresa=@CodigoEmpresa)
		and ((@CodigoSucursal=0)or(f.CodigoSucursalFuncionario=@CodigoSucursal))
		and f.codigorelacion=1
		--AND F.EstadoFuncionario=1
		and p.EstadoPeriodoVacacionesFuncionario=1
		
		--group by p. FechaInicialPeriodoVacacionesFuncionario , p.FechaFinalPeriodoVacacionesFuncionario,p.DiasUsadosPeriodoVacacionesFuncionario
		--,p.DiasLibresPeriodoVacacionesFuncionario,f.CodigoFuncionario
		--,f.IdentificacionFuncionario
		--,f.NombreCompleto
		--,e.NombreEmpresa
		--,e.LogoEmpresa
		--,p.EstadoPeriodoVacacionesFuncionario
		--,p.DiasBasePeriodoVacacionesFuncionario
		--,p.DiasAdicionalPeriodoVacacionesFuncionario
		--,f.FechaCalculoFuncionario
		--,fe.FechaIngreso
		--,fsalida.FechaSalida
		--,p.CodigoPeriodoVacacionesFuncionario
		
