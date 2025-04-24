GO


alter FUNCTION [dbo].[FN_gmas_ExisteFinSemanaPeriodoVacacion] 
(
--declare
 @CodigoFuncionario int=24
 ,@CodigoPeriodoVacacion int=54
)
RETURNS int
AS
BEGIN
 
--AS
		--SET LANGUAGE US_ENGLISH
		DECLARE @DiasLaborables int=0
		DECLARE @DiasTotal int=0
		DECLARE @FinSemana int=0
		DECLARE @TotalDiasAnual INT=0
		DECLARE @TotalAnios INT=0

		SELECT 
		 @TotalAnios=dbo.FN_gmas_ObtenerAniosAntiguedadPeriodoVacacion (P.CodigoFuncionario,P.FechaFinalPeriodoVacacionesFuncionario)
		,@TotalDiasAnual=15+[dbo].[FN_gmas_ObtenerDiasAntiguedadPeriodoVacacion] (P.CodigoFuncionario,P.FechaFinalPeriodoVacacionesFuncionario)
		FROM PeriodoVacacionesFuncionario p 
		JOIN Funcionario f on p.CodigoFuncionario=f.CodigoFuncionario
		WHERE p.EstadoPeriodoVacacionesFuncionario=1
		and p.CodigoFuncionario=@CodigoFuncionario
		and p.CodigoPeriodoVacacionesFuncionario=@CodigoPeriodoVacacion



	
		select @DiasLaborables=sum(ISNULL(DiasLaborables,0)),@DiasTotal=sum(ISNULL(DiasTotal,0)),@FinSemana=sum(ISNULL(FinSemana,0))
		from(
		select 
		 DiasLaborables=[dbo].[DiasLaborables](FechaInicioVacacion,FechaFinVacacion)
		,DiasTotal=datediff(day,FechaInicioVacacion,FechaFinVacacion)+1
		,FinSemana=(datediff(day,FechaInicioVacacion,FechaFinVacacion)+1)-([dbo].[DiasLaborables](FechaInicioVacacion,FechaFinVacacion))
		,CodigoPeriodoVacacionesFuncionario
		
		from BoletaVacaciones
		where CODIGOFUNCIONARIO=@CodigoFuncionario
		and CodigoPeriodoVacacionesFuncionario=@CodigoPeriodoVacacion
		AND EsAutorizadaBoletaVacacion='S'
		AND EsConfirmadaBoletaVacaciones='S'
		)tmp
		--PRINT '@DiasLaborables' PRINT @DiasLaborables
		--PRINT '@DiasTotal' PRINT @DiasTotal
		--PRINT '@FinSemana' PRINT @FinSemana
		
		RETURN ISNULL(@FinSemana,0)
		/*
		   select @NuevaDiasLaborables+ISNULL(@DiasLaborables,0) DiasLaborables,@NuevaDiasTotal+ISNULL(@DiasTotal,0) DiasTotal,FinSemana=@NuevaFinSemana+ISNULL(@FinSemana,0)
		   ,@TotalDiasAnual TotalDiasAnual,@TotalAnios TotalAnios
		   ,TotalDiasPermitidos=CASE WHEN @TotalAnios<6 THEN 11
		                             WHEN @TotalAnios=6 THEN 12
									 WHEN @TotalAnios=7 THEN 13
									 WHEN @TotalAnios=8 THEN 14
									 WHEN @TotalAnios=9 THEN 15
									 WHEN @TotalAnios=10 THEN 16
									 WHEN @TotalAnios=11 THEN 17
									 WHEN @TotalAnios=12 THEN 18
									 WHEN @TotalAnios=13 THEN 19
									 WHEN @TotalAnios=14 THEN 20
									 WHEN @TotalAnios=15 THEN 21
									 WHEN @TotalAnios=16 THEN 22
									 WHEN @TotalAnios=17 THEN 23
									 WHEN @TotalAnios=18 THEN 24
									 WHEN @TotalAnios=19 THEN 25
									 WHEN @TotalAnios>=20 THEN @TotalDiasAnual - 4
									 END
			,ExistenBoletas=case when @DiasLaborables is null then 0 else 1 end
			,Disponible=(CASE WHEN @TotalAnios<6 THEN 11
		                             WHEN @TotalAnios=6 THEN 12
									 WHEN @TotalAnios=7 THEN 13
									 WHEN @TotalAnios=8 THEN 14
									 WHEN @TotalAnios=9 THEN 15
									 WHEN @TotalAnios=10 THEN 16
									 WHEN @TotalAnios=11 THEN 17
									 WHEN @TotalAnios=12 THEN 18
									 WHEN @TotalAnios=13 THEN 19
									 WHEN @TotalAnios=14 THEN 20
									 WHEN @TotalAnios=15 THEN 21
									 WHEN @TotalAnios=16 THEN 22
									 WHEN @TotalAnios=17 THEN 23
									 WHEN @TotalAnios=18 THEN 24
									 WHEN @TotalAnios=19 THEN 25
									 WHEN @TotalAnios>=20 THEN @TotalDiasAnual - 4
									 END) - (@NuevaDiasLaborables+ISNULL(@DiasLaborables,0))
			,DiasPermitidosPendientes=(CASE WHEN @TotalAnios<6 THEN 11
		                             WHEN @TotalAnios=6 THEN 12
									 WHEN @TotalAnios=7 THEN 13
									 WHEN @TotalAnios=8 THEN 14
									 WHEN @TotalAnios=9 THEN 15
									 WHEN @TotalAnios=10 THEN 16
									 WHEN @TotalAnios=11 THEN 17
									 WHEN @TotalAnios=12 THEN 18
									 WHEN @TotalAnios=13 THEN 19
									 WHEN @TotalAnios=14 THEN 20
									 WHEN @TotalAnios=15 THEN 21
									 WHEN @TotalAnios=16 THEN 22
									 WHEN @TotalAnios=17 THEN 23
									 WHEN @TotalAnios=18 THEN 24
									 WHEN @TotalAnios=19 THEN 25
									 WHEN @TotalAnios>=20 THEN isnull(@TotalDiasAnual,0) - 4
									 END) - isnull(@DiasLaborables,0)
				,DiasSolicitados=@NuevaDiasLaborables
		*/

		--CASO 1. FinSemana = 0 solo puede solicitar TOTALDIASPERMITIDOS y el sistema debe registrar 1 boleta de 4 dias
		--CASO 2. FinSemana =0 y DiasLaborables = 11 and Disponible > 0, el sistema debe registrar 1 boleta de 4 dias
		
END