
GO
/****** Object:  StoredProcedure [dbo].[gmas_ConsultarDiasFinSemanaAnticipoVacacion]    Script Date: 7/22/2024 3:13:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[dbo].[gmas_ConsultarDiasFinSemanaBoletaVacacion]'2024-08-05','2024-08-05',4261,3708
create PROCEDURE [dbo].[gmas_ConsultarDiasFinSemanaBoletaVacacion]
--DECLARE
@FechaInicioVacacion date='2024-08-12'
,@FechaFinal date='2024-08-13'
,@CodigoFuncionario int=3538
,@CodigoPeriodo int=6096
AS
		SET LANGUAGE US_ENGLISH
		DECLARE @NuevaDiasLaborables int=0
		DECLARE @NuevaDiasTotal int=0
		DECLARE @NuevaFinSemana int=0
		DECLARE @DiasLaborables int=0
		DECLARE @DiasTotal int=0
		DECLARE @FinSemana int=0
		DECLARE @TotalDiasAnual INT=0
		DECLARE @TotalAnios INT=0

		SELECT 
		@TotalAnios=round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0)
		,@TotalDiasAnual=isnull((  case 
                      when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))<6 then   convert(decimal(18,2),(15* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=6 then   convert(decimal(18,2),(16* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
                      when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=7 then   convert(decimal(18,2),(17* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=8 then   convert(decimal(18,2),(18* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=9 then   convert(decimal(18,2),(19* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=10 then  convert(decimal(18,2),(20* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=11 then  convert(decimal(18,2),(21* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=12 then  convert(decimal(18,2),(22* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=13 then  convert(decimal(18,2),(23* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=14 then  convert(decimal(18,2),(24* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=15 then  convert(decimal(18,2),(25* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=16 then  convert(decimal(18,2),(26* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=17 then  convert(decimal(18,2),(27* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=18 then  convert(decimal(18,2),(28* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))=19 then  convert(decimal(18,2),(29* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  when (round(DATEDIFF(DAY,FechaIngresoFuncionario,p.FechaFinalPeriodoVacacionesFuncionario)/360,0))>=20 then convert(decimal(18,2),(30* ((DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,FechaFinalPeriodoVacacionesFuncionario)/360))))
					  end
					  ),0)
		FROM PeriodoVacacionesFuncionario p 
		JOIN Funcionario f on p.CodigoFuncionario=f.CodigoFuncionario
		WHERE P.CodigoPeriodoVacacionesFuncionario=@CodigoPeriodo



		select 
		 @NuevaDiasLaborables=[dbo].[DiasLaborables](@FechaInicioVacacion,@FechaFinal)
		,@NuevaDiasTotal=datediff(day,@FechaInicioVacacion,@FechaFinal)+1
		,@NuevaFinSemana=(datediff(day,@FechaInicioVacacion,@FechaFinal)+1)-([dbo].[DiasLaborables](@FechaInicioVacacion,@FechaFinal))

		select @DiasLaborables=sum(ISNULL(DiasLaborables,0)),@DiasTotal=sum(ISNULL(DiasTotal,0)),@FinSemana=sum(ISNULL(FinSemana,0))
		from(
		select 
		 DiasLaborables=[dbo].[DiasLaborables](FechaInicioVacacion,FechaFinVacacion)
		,DiasTotal=datediff(day,FechaInicioVacacion,FechaFinVacacion)+1
		,FinSemana=(datediff(day,FechaInicioVacacion,FechaFinVacacion)+1)-([dbo].[DiasLaborables](FechaInicioVacacion,FechaFinVacacion))
		,CodigoPeriodoVacacionesFuncionario
		--,EsVacacion,EsAntiguedad
		from BoletaVacaciones
		where CODIGOFUNCIONARIO=@CodigoFuncionario
		AND CODIGOPERIODOVACACIONESFUNCIONARIO=@CodigoPeriodo
		--AND EsAutorizadaBoletaVacacion='S'
		--AND EsConfirmadaBoletaVacaciones='S'
		)tmp
		PRINT '@DiasLaborables' PRINT @DiasLaborables
		PRINT '@DiasTotal' PRINT @DiasTotal
		PRINT '@FinSemana' PRINT @FinSemana
		
		
		--select @NuevaDiasLaborables NuevaDiasLaborables,@NuevaDiasTotal NuevaDiasTotal,@NuevaFinSemana NuevaFinSemana,@DiasLaborables DiasLaborables,@DiasTotal DiasTotal,@FinSemana FinSemana, @TotalDiasAnual TotalDiasAnual,@TotalAnios TotalAnios

		--if((@NuevaDiasTotal+ISNULL(@DiasTotal,0)>=5 ) AND (@NuevaFinSemana+ISNULL(@FinSemana,0)=0))
		--BEGIN
		--		select @NuevaDiasLaborables+ISNULL(@DiasLaborables,0) DiasLaborables,@NuevaDiasTotal+ISNULL(@DiasTotal,0) DiasTotal,FinSemana=0
		--END
		--ELSE IF((@NuevaDiasTotal+ISNULL(@DiasTotal,0)>=13 ) AND (@NuevaFinSemana+ISNULL(@FinSemana,0)=2))
		--BEGIN
		--		select @NuevaDiasLaborables+ISNULL(@DiasLaborables,0) DiasLaborables,@NuevaDiasTotal+ISNULL(@DiasTotal,0) DiasTotal,FinSemana=0
		--END
		--ELSE IF((@NuevaDiasTotal+ISNULL(@DiasTotal,0)>=20 ) AND (@NuevaFinSemana+ISNULL(@FinSemana,0)=4))
		--BEGIN
		--		select @NuevaDiasLaborables+ISNULL(@DiasLaborables,0) DiasLaborables,@NuevaDiasTotal+ISNULL(@DiasTotal,0) DiasTotal,FinSemana=0
		--END
		--ELSE IF((@NuevaDiasTotal+ISNULL(@DiasTotal,0)>=27 ) AND (@NuevaFinSemana+ISNULL(@FinSemana,0)=6))
		--BEGIN
		--		select @NuevaDiasLaborables+ISNULL(@DiasLaborables,0) DiasLaborables,@NuevaDiasTotal+ISNULL(@DiasTotal,0) DiasTotal,FinSemana=0
		--END
		--ELSE
		--BEGIN
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
									 WHEN @TotalAnios>=20 THEN @TotalDiasAnual - 4
									 END) - @DiasLaborables
				,DiasSolicitados=@NuevaDiasLaborables
		--END
		--SELECT @NuevaFinSemana FinSemana

		--CASO 1. FinSemana = 0 solo puede solicitar TOTALDIASPERMITIDOS y el sistema debe registrar 1 boleta de 4 dias
		--CASO 2. FinSemana =0 y DiasLaborables = 11 and Disponible > 0, el sistema debe registrar 1 boleta de 4 dias
		

