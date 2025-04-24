

ALTER PROCEDURE [dbo].[gmas_InsertBoletaAnticipoVacaciones]
--declare 
@IdBoletaVacaciones int=2337
as
   SET LANGUAGE US_ENGLISH
   
     DECLARE
    
    
     @TotalDias decimal(18,2)=0
    ,@DiasLibres decimal(18,2)=0
	,@DiasUsados decimal(18,2)=0
	,@SaldoDias decimal(18,2)=0
	,@TotalDiasSolicitados decimal(18,2)=0
    
    ,@CodigoFuncionario int=0
    ,@FechaBoletaVacaciones datetime=''
    ,@EsPagadaBoletaVacaciones bit=0
    ,@ObservacionesBoletaVacaciones varchar(850)=''
    ,@CodigoFuncionarioResponsable int=0
    ,@EstadoBoletaVacaciones bit=0
    ,@EsVacacionMasiva bit=0
    ,@EsConfirmadaBoletaVacaciones char(1)=''
    ,@EsAutorizadaBoletaVacacion char(1)=''
    ,@FechaInicioVacacion date=''
    ,@FechaFinVacacion date=''
    ,@CantidadDiasVacacion int=0
    ,@CodigoPeriodoVacacionesFuncionario int=0
    ,@EsExtra bit=0
    ,@EsEnviadoMail bit=0
    ,@EsVacacion bit=0
    ,@EsAntiguedad bit=0
    ,@ObservacionConfirmacion nvarchar(max)=''
    ,@EsEnviadoMailConfirmacion bit=0
    ,@CodigoPeriodoExtra int=0
    ,@Periodo varchar(50)=''
    ,@MontoProvision decimal(18,2)=0
    ,@Secuencial varchar(50)=''
    ,@DiasPagados int=0
    ,@DiasGozados int=0
    ,@UsuarioAuditoria nvarchar(150)=''
    ,@FechaAuditoria datetime=''
    ,@CodigoPeriodoPago int=0
    ,@CodigoPeriodoFiscal int=0
    ,@FechaAutorizacion datetime=''
    ,@FechaConfirmacion datetime=''
    ,@UsuarioConfirmacion nvarchar(150)=''
	--,@AuxFechaInicio date=''
	--,@AuxFechaFin date=''
	,@FechaAux date=''
	,@Eliminar int=1

    select 
	 --@todoEsAnticipo=ISNULL(bv.EsExtra,0)
	 @CodigoFuncionario=[CodigoFuncionario]
    ,@FechaBoletaVacaciones=[FechaBoletaVacaciones]
    ,@EsPagadaBoletaVacaciones=0--[EsPagadaBoletaVacaciones]
    ,@ObservacionesBoletaVacaciones=[ObservacionesBoletaVacaciones]
    ,@CodigoFuncionarioResponsable=[CodigoFuncionarioResponsable]
    ,@EstadoBoletaVacaciones=1--[EstadoBoletaVacaciones]
    ,@EsVacacionMasiva=0--[EsVacacionMasiva]
    ,@EsConfirmadaBoletaVacaciones='S'--[EsConfirmadaBoletaVacaciones]
    ,@EsAutorizadaBoletaVacacion='S'--[EsAutorizadaBoletaVacacion]
    ,@FechaInicioVacacion=[FechaInicioVacacion]
    ,@FechaFinVacacion=[FechaFinVacacion]
    ,@CantidadDiasVacacion=[CantidadDiasVacacion]
	,@TotalDiasSolicitados=[CantidadDiasVacacion]
    --,@CodigoPeriodoVacacionesFuncionario=[CodigoPeriodoVacacionesFuncionario]
    ,@EsExtra=[EsExtra]
    ,@EsEnviadoMail=[EsEnviadoMail]
    ,@EsVacacion=[EsVacacion]
    ,@EsAntiguedad=[EsAntiguedad]
    ,@ObservacionConfirmacion=[ObservacionConfirmacion]
    ,@EsEnviadoMailConfirmacion=[EsEnviadoMailConfirmacion]
    ,@CodigoPeriodoExtra=[CodigoPeriodoExtra]
    ,@Periodo=[Periodo]
    ,@MontoProvision=[MontoProvision]
    ,@Secuencial=[Secuencial]
    ,@DiasPagados=[DiasPagados]
    ,@DiasGozados=[DiasGozados]
    ,@UsuarioAuditoria=[UsuarioAuditoria]
    ,@FechaAuditoria=[FechaAuditoria]
    ,@CodigoPeriodoPago=[CodigoPeriodoPago]
    ,@CodigoPeriodoFiscal=[CodigoPeriodoFiscal]
    ,@FechaAutorizacion=[FechaAutorizacion]
    ,@FechaConfirmacion=[FechaConfirmacion]
    ,@UsuarioConfirmacion=[UsuarioConfirmacion]
	from BoletaVacaciones bv where IdBoletaVacaciones=@IdBoletaVacaciones


	
	CREATE TABLE #Periodos(Indice int identity,CodigoPeriodoVacacion int,TotalDias int,DiasLibres int,DiasUsados int)
	insert into #Periodos
	select 
		pvf.CodigoPeriodoVacacionesFuncionario,
		pvf.DiasTotalesPeriodoVacacionesFuncionario,
		pvf.DiasLibresPeriodoVacacionesFuncionario,
		pvf.DiasUsadosPeriodoVacacionesFuncionario
	from PeriodoVacacionesFuncionario pvf 
	where pvf.CodigoFuncionario=@CodigoFuncionario 
	and EstadoPeriodoVacacionesFuncionario=1
	order by Periodo 

	DECLARE @AUXP INT=1,@cantidadP int=0,@AuxCantidadDias int=0
	set @SaldoDias=0
	select @cantidadP=count(*) from #Periodos
	while(@AUXP<=@cantidadP)
	BEGIN
			
			SELECT @CodigoPeriodoVacacionesFuncionario=CodigoPeriodoVacacion,@TotalDias=TotalDias,@DiasLibres=DiasLibres,@DiasUsados=DiasUsados FROM #Periodos WHERE Indice=@AUXP
			--select @CodigoPeriodoVacacionesFuncionario PERIODOVACACION,@AUXP Indice
			
			--CASO 6
			--SELECT @CantidadDiasVacacion SALDO_DIAS
			if(isnull(@CantidadDiasVacacion,0)>0 )
			BEGIN
					PRINT  'CASO 6'
					--SELECT @DiasLey+@DiasAntiguedad,@DiasLey,@DiasAntiguedad,@CantidadDiasVacacion
					IF(@CantidadDiasVacacion<=@DiasLibres and @AUXP=1) --LIQUIDO TODOS LOS DIAS
					BEGIN
						 print '1. NO HACEMOS NADA'
						 set @Eliminar=0
						 --set @AuxCantidadDias=@CantidadDiasVacacion
						 --set @CantidadDiasVacacion=0
						 set @AUXP=@cantidadP+1
					END
					--LIQUIDO PARCIALMENTE
					ELSE BEGIN
						set @Eliminar=1
						DECLARE  @TomadosVAC INT=0,@LibresVAC INT=0--,@TomadosANT INT=0,@LibresANT INT=0
						,@TotalEfectivo int=0
						
						select 
						@TotalEfectivo=CONVERT(DECIMAL(18,2),[dbo].[FN_gmas_DiasTotalPeriodoVacacion] (CodigoFuncionario,CodigoPeriodoVacacionesFuncionario))
						from PeriodoVacacionesFuncionario pv
						where pv.CodigoPeriodoVacacionesFuncionario=@CodigoPeriodoVacacionesFuncionario

						
						--SELECT 'PARCIAL', @CantidadDiasVacacion DiasSolicitados,@TotalEfectivo TotalEfectivo,@DiasLibres Libres,@CodigoPeriodoVacacionesFuncionario Periodo
					
							
								 IF(@DiasLibres>0 and (@CantidadDiasVacacion>@DiasLibres))
								 BEGIn
									 print '3.1 INGRESA A REGISTRAR' 
									 set @Eliminar=1
									 --DECLARE @CantidadDiasSolicitados int=0
									 
									 set @CantidadDiasVacacion=@DiasLibres
									 
									 --1: LEY
									set @FechaAux=DATEADD(day,@DiasLibres-1,@FechaInicioVacacion)
									set @FechaFinVacacion=@FechaAux
									set @DiasGozados=@DiasLibres
									set @EsPagadaBoletaVacaciones=0
									set @EsVacacion=1
									set @EsAntiguedad=0
									
									--select '001:', @CantidadDiasVacacion diasVacacion
									INSERT INTO [dbo].[BoletaVacaciones]
									([CodigoFuncionario],[FechaBoletaVacaciones],[EsPagadaBoletaVacaciones],[ObservacionesBoletaVacaciones],[CodigoFuncionarioResponsable],[EstadoBoletaVacaciones]
									,[EsVacacionMasiva],[EsConfirmadaBoletaVacaciones],[EsAutorizadaBoletaVacacion],[FechaInicioVacacion],[FechaFinVacacion],[CantidadDiasVacacion],[CodigoPeriodoVacacionesFuncionario]
									,[EsExtra],[EsEnviadoMail],[EsVacacion],[EsAntiguedad],[ObservacionConfirmacion],[EsEnviadoMailConfirmacion],[CodigoPeriodoExtra],[Periodo],[MontoProvision]
									,[Secuencial],[DiasPagados],[DiasGozados],[UsuarioAuditoria],[FechaAuditoria],[CodigoPeriodoPago],[CodigoPeriodoFiscal],[FechaAutorizacion],[FechaConfirmacion]
									,[UsuarioConfirmacion])
									VALUES
									(@CodigoFuncionario,@FechaBoletaVacaciones,@EsPagadaBoletaVacaciones,@ObservacionesBoletaVacaciones,@CodigoFuncionarioResponsable,@EstadoBoletaVacaciones
									,@EsVacacionMasiva,@EsConfirmadaBoletaVacaciones,@EsAutorizadaBoletaVacacion,@FechaInicioVacacion,@FechaFinVacacion,@CantidadDiasVacacion,@CodigoPeriodoVacacionesFuncionario
									,@EsExtra,@EsEnviadoMail,@EsVacacion,@EsAntiguedad,@ObservacionConfirmacion,@EsEnviadoMailConfirmacion,@CodigoPeriodoExtra,@Periodo,@MontoProvision
									,@Secuencial,@DiasPagados,@DiasGozados,@UsuarioAuditoria,@FechaAuditoria,@CodigoPeriodoPago,@CodigoPeriodoFiscal,@FechaAutorizacion,@FechaConfirmacion
									,@UsuarioConfirmacion)
									set @FechaInicioVacacion=dateadd(day,1,@FechaFinVacacion)
								 END	
								 else IF(@DiasLibres>0 and (@CantidadDiasVacacion<=@DiasLibres or @CantidadDiasVacacion<=@TotalEfectivo))
								 BEGIn
									 print '3.2 INGRESA A REGISTRAR' 
									 set @Eliminar=1
									 
									 --select @AuxCantidadDias ANtesDE,@CantidadDiasVacacion CantidadDiasVacacion
									 
									 --1: LEY
									set @FechaAux=DATEADD(day,@CantidadDiasVacacion-1,@FechaInicioVacacion)
									set @FechaFinVacacion=@FechaAux
									set @DiasGozados=@CantidadDiasVacacion
									set @EsPagadaBoletaVacaciones=0
									set @EsVacacion=1
									set @EsAntiguedad=0
									--set @CantidadDiasVacacion=0
							
						
									INSERT INTO [dbo].[BoletaVacaciones]
									([CodigoFuncionario],[FechaBoletaVacaciones],[EsPagadaBoletaVacaciones],[ObservacionesBoletaVacaciones],[CodigoFuncionarioResponsable],[EstadoBoletaVacaciones]
									,[EsVacacionMasiva],[EsConfirmadaBoletaVacaciones],[EsAutorizadaBoletaVacacion],[FechaInicioVacacion],[FechaFinVacacion],[CantidadDiasVacacion],[CodigoPeriodoVacacionesFuncionario]
									,[EsExtra],[EsEnviadoMail],[EsVacacion],[EsAntiguedad],[ObservacionConfirmacion],[EsEnviadoMailConfirmacion],[CodigoPeriodoExtra],[Periodo],[MontoProvision]
									,[Secuencial],[DiasPagados],[DiasGozados],[UsuarioAuditoria],[FechaAuditoria],[CodigoPeriodoPago],[CodigoPeriodoFiscal],[FechaAutorizacion],[FechaConfirmacion]
									,[UsuarioConfirmacion])
									VALUES
									(@CodigoFuncionario,@FechaBoletaVacaciones,@EsPagadaBoletaVacaciones,@ObservacionesBoletaVacaciones,@CodigoFuncionarioResponsable,@EstadoBoletaVacaciones
									,@EsVacacionMasiva,@EsConfirmadaBoletaVacaciones,@EsAutorizadaBoletaVacacion,@FechaInicioVacacion,@FechaFinVacacion,@CantidadDiasVacacion,@CodigoPeriodoVacacionesFuncionario
									,@EsExtra,@EsEnviadoMail,@EsVacacion,@EsAntiguedad,@ObservacionConfirmacion,@EsEnviadoMailConfirmacion,@CodigoPeriodoExtra,@Periodo,@MontoProvision
									,@Secuencial,@DiasPagados,@DiasGozados,@UsuarioAuditoria,@FechaAuditoria,@CodigoPeriodoPago,@CodigoPeriodoFiscal,@FechaAutorizacion,@FechaConfirmacion
									,@UsuarioConfirmacion)
									set @FechaInicioVacacion=dateadd(day,1,@FechaFinVacacion)
									
								 END
					END
			END

			--CASO 7
			
			--SELECT @Eliminar ELIMINAR
			if(@Eliminar=1)
			BEGIN
			     IF(@AUXP>1)BEGIN
				    DELETE FROM BoletaVacaciones WHERE IdBoletaVacaciones=@IdBoletaVacaciones
					--SELECT 'Ingresa a eliminar la boleta',@IdBoletaVacaciones
					PRINT 'ELIMINA'
				END
			END
			ELSE BEGIN
				PRINT  'SE MANTIENE LA BOLETA ORIGINAL' 
				--SELECT 'SE MANTIENE LA BOLETA ORIGINAL'
				UPDATE BoletaVacaciones SET CodigoPeriodoVacacionesFuncionario=@CodigoPeriodoVacacionesFuncionario,EsVacacion=1,EsAutorizadaBoletaVacacion='S',EsConfirmadaBoletaVacaciones='S',EstadoBoletaVacaciones=1 WHERE IdBoletaVacaciones=@IdBoletaVacaciones
			END
	
	
			update p set 
			--select
			 DiasUsadosPeriodoVacacionesFuncionario=DiasUsadosPeriodoVacacionesFuncionario+@CantidadDiasVacacion
			,DiasLibresPeriodoVacacionesFuncionario=DiasLibresPeriodoVacacionesFuncionario-@CantidadDiasVacacion
			,EstadoPeriodoVacacionesFuncionario=case when DiasUsadosPeriodoVacacionesFuncionario+@CantidadDiasVacacion=CONVERT(DECIMAL(18,2),[dbo].[FN_gmas_DiasTotalPeriodoVacacion] (CodigoFuncionario,CodigoPeriodoVacacionesFuncionario))
								then 0 else 1 end
			--,@AUXP Vueltas
			--,@CantidadDiasVacacion CantidadDiasVacacion
			--,DiasLibresPeriodoVacacionesFuncionario LibresActual
			--,DiasUsadosPeriodoVacacionesFuncionario UsadosActual
			--,DiasUsadosPeriodoVacacionesFuncionario+@CantidadDiasVacacion,
			--CONVERT(DECIMAL(18,2),[dbo].[FN_gmas_DiasTotalPeriodoVacacion] (CodigoFuncionario,CodigoPeriodoVacacionesFuncionario))
			FROM PeriodoVacacionesFuncionario P
			where p.CodigoPeriodoVacacionesFuncionario=@CodigoPeriodoVacacionesFuncionario
			
			set @AuxCantidadDias=@AuxCantidadDias+@CantidadDiasVacacion
			set @SaldoDias=(@TotalDiasSolicitados-@AuxCantidadDias)
			set @CantidadDiasVacacion=@SaldoDias
			set @CodigoPeriodoVacacionesFuncionario=0
			SET @AUXP=@AUXP+1
			--SELECT  'CONTINUA..',@CantidadDiasVacacion DiasVacacionSaldo,@AUXP Siguiente
      END
	  DROP TABLE #Periodos