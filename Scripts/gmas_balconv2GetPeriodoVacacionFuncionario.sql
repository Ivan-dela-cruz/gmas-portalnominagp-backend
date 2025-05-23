

--  [dbo].[gmas_balconv2GetPeriodoVacacionFuncionario] '1725278392'
ALTER PROCEDURE [dbo].[gmas_balconv2GetPeriodoVacacionFuncionario]
--DECLARE
@IdentificacionFuncionario varchar(15)='1803394871'
AS
		
		SELECT 
		f.CodigoFuncionario
		,f.IdentificacionFuncionario
		,f.NombreCompleto
		,Desde=convert(varchar(10),p.FechaInicialPeriodoVacacionesFuncionario,120)
		,Hasta=case when p.FechaFinalPeriodoVacacionesFuncionario> getdate() then 'Fecha actual' else convert(varchar(10),p.FechaFinalPeriodoVacacionesFuncionario,120)end
		,DiasGanados=round(p.DiasBasePeriodoVacacionesFuncionario,0)
		,DiasGanadosAntiguedad=round(DiasAdicionalPeriodoVacacionesFuncionario,0)
		,TotalDiasVacacion=round(DiasTotalesPeriodoVacacionesFuncionario,0)
		,DiasTomados=--DiasUsadosPeriodoVacacionesFuncionario 
					convert(int,round([dbo].[FN_gmas_DevuelveDiasVacacacionXPeriodo](p.CodigoFuncionario,p.CodigoPeriodoVacacionesFuncionario),0))
		,DiasDisponibles=round(DiasTotalesPeriodoVacacionesFuncionario,0)-convert(decimal(18,2),round([dbo].[FN_gmas_DevuelveDiasVacacacionXPeriodo](p.CodigoFuncionario,p.CodigoPeriodoVacacionesFuncionario),0))
						--DiasLibresPeriodoVacacionesFuncionario
		,PeriodoVacacion=p.Periodo
		,p.CodigoPeriodoVacacionesFuncionario
		,Anios=dbo.FN_gmas_ObtenerAniosAntiguedadPeriodoVacacion (P.CodigoFuncionario,P.FechaFinalPeriodoVacacionesFuncionario)
		,TotalDiasEfectivos=15+[dbo].[FN_gmas_ObtenerDiasAntiguedadPeriodoVacacion] (P.CodigoFuncionario,P.FechaFinalPeriodoVacacionesFuncionario)
		,TieneFinSemana=[dbo].[FN_gmas_ExisteFinSemanaPeriodoVacacion] (P.CodigoFuncionario,P.CodigoPeriodoVacacionesFuncionario)
		,DiasAnticipados=isnull(pvef.DiasUsados,0)
		FROM PeriodoVacacionesFuncionario p 
		join Funcionario f on f.CodigoFuncionario=p.CodigoFuncionario
		
		left join (
			select a.CodigoFuncionario,CodigoPeriodoVacacionesFuncionario=0,DiasUsados=sum(a.CantidadDiasVacacion)
			from BoletaVacaciones a
			--join PeriodoVacacionesFuncionario p on a.codigofuncionario=p.CodigoFuncionario and a.CodigoPeriodoVacacionesFuncionario=p.CodigoPeriodoVacacionesFuncionario
			where a.EsConfirmadaBoletaVacaciones='N' and a.EsAutorizadaBoletaVacacion='N'
			group by a.CodigoFuncionario--,a.CodigoPeriodoVacacionesFuncionario,p.Periodo
		) pvef on f.CodigoFuncionario=pvef.CodigoFuncionario --AND pvef.CodigoPeriodoVacacionesFuncionario=P.CodigoPeriodoVacacionesFuncionario
		WHERE (F.IdentificacionFuncionario=@IdentificacionFuncionario)
		and p.EstadoPeriodoVacacionesFuncionario=1
		and f.codigorelacion=1
		AND F.EstadoFuncionario=1
		and p.EstadoPeriodoVacacionesFuncionario=1
		