
ALTER FUNCTION [dbo].[FN_gmas_ObtenerDiasAntiguedadPeriodoVacacion] 
(
--declare
 @CodigoFuncionario int=8161
,@FechaFinPago date='2024-07-07'
)
RETURNS int
AS
BEGIN


    DECLARE @Resultado int=0,@Anios int=0,@resultado2 DECIMAL(18,2)=0,@Antiguedad DECIMAL(18,2)=0,@FechaFinPagoVac date='2025-01-30'


    SELECT @Antiguedad=round(sum(ROUND(ROUND(( DATEDIFF(MM,FechaIngreso,ISNULL(FechaSalida,DATEADD(YEAR,1,EOMONTH(@FechaFinPago))))/12.00),2),2)),2)
	FROM FechaEntradaSalidaEfectiva
	WHERE CodigoFuncionario=@CodigoFuncionario
	and FechaSalida is not null
	

	--select @Antiguedad ant

	SELECT 
	@resultado2=
	(case when  round(datediff(mm, FechaIngreso, @FechaFinPago) / 12, 0, 1)>=6 then  
	--(ROUND(ROUND(( DATEDIFF(MM,FechaIngreso,ISNULL(FechaSalida,DATEADD(YEAR,1,EOMONTH(@FechaFinPago))))/12.00),2),0))
	(ROUND(ROUND(( DATEDIFF(MM,FechaIngreso,EOMONTH(@FechaFinPago))/12.00),2),2,1))
	else 
	0--(ROUND(ROUND(( DATEDIFF(MM,FechaIngreso,ISNULL(FechaSalida,EOMONTH(@FechaFinPago)))/12.00),2),0))
	end)

	FROM FechaEntradaSalidaEfectiva
	WHERE CodigoFuncionario=@CodigoFuncionario
	and FechaSalida is null
	and Estado=1

	set @Resultado=ISNULL(@Antiguedad,0)+ISNULL(@resultado2,0)
	
	SELECT @Anios=CASE 
   WHEN isnull(@Resultado,0)<6 THEN 0
	WHEN isnull(@Resultado,0)=6 THEN 1
	WHEN isnull(@Resultado,0)=7 THEN 2
	WHEN isnull(@Resultado,0)=8 THEN 3
	WHEN isnull(@Resultado,0)=9 THEN 4
	WHEN isnull(@Resultado,0)=10 THEN 5
	WHEN isnull(@Resultado,0)=11 THEN 6
	WHEN isnull(@Resultado,0)=12 THEN 7
	WHEN isnull(@Resultado,0)=13 THEN 8
	WHEN isnull(@Resultado,0)=14 THEN 9
	WHEN isnull(@Resultado,0)=15 THEN 10
	WHEN isnull(@Resultado,0)=16 THEN 11
	WHEN isnull(@Resultado,0)=17 THEN 12
	WHEN isnull(@Resultado,0)=18 THEN 13
	WHEN isnull(@Resultado,0)=19 THEN 14
	WHEN isnull(@Resultado,0)>=20 THEN 15
	ELSE 0 END
	
	RETURN  isnull(@Anios,0)

END
