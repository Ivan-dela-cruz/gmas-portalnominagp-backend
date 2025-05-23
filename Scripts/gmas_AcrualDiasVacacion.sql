
ALTER PROCEDURE [dbo].[gmas_AcrualDiasVacacion]
AS

SET LANGUAGE us_english; 
CREATE TABLE #TMPFUNCIONARIO(Indice int identity,CodigoFuncionario int)
insert into #TMPFUNCIONARIO
--select CodigoFuncionario from funcionario where  CodigoFuncionario in('7859')

select CodigoFuncionario
from(
select f.CodigoFuncionario,f.NombreCompleto,un.DescripcionUnidades
FROM Funcionario f
join Unidades un on f.CodigoUnidades=un.CodigoUnidades
WHERE EstadoFuncionario=1 AND CodigoRelacion=1 AND f.CodigoFuncionario NOT IN(-99)
and un.CodigoUnidades not in(2,3) --2	ACADÉMICO;3	INVESTIGACIÓN
union
select f.CodigoFuncionario,f.NombreCompleto,un.DescripcionUnidades
FROM Funcionario f
join Unidades un on f.CodigoUnidades=un.CodigoUnidades
join TipoProyectoInvestigacion a on f.CodigoProyectoInvestigacion=a.Codigo
WHERE EstadoFuncionario=1 AND CodigoRelacion=1 AND f.CodigoFuncionario NOT IN(-99)
and un.CodigoUnidades=3 --3	INVESTIGACIÓN
and a.Codigo not in(2) --2	Investigación - Proyectos Fondos Externos
)tmp


declare @Aux int=1,@Cantidad int=(select COUNT(*) from #TMPFUNCIONARIO)
while(@Aux<=@Cantidad)
begin
		declare @CodigoFuncionario int=0

		select @CodigoFuncionario=CodigoFuncionario from #TMPFUNCIONARIO where Indice=@Aux
		exec PACrearPeriodoVacacionFuncionario  @CodigoFuncionario
		set @Aux=@Aux+1
end
drop table #TMPFUNCIONARIO

update p set 
DiasAdicionalPeriodoVacacionesFuncionario=
         case when round(((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)))* 15)/360.00,2)>=15 then     
		 isnull((case when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=6 then   convert(decimal(18,2),(1* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
                      when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=7 then   convert(decimal(18,2),(2* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=8 then   convert(decimal(18,2),(3* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=9 then   convert(decimal(18,2),(4* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=10 then  convert(decimal(18,2),(5* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=11 then  convert(decimal(18,2),(6* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=12 then  convert(decimal(18,2),(7* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=13 then  convert(decimal(18,2),(8* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=14 then  convert(decimal(18,2),(9* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=15 then  convert(decimal(18,2),(10*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=16 then  convert(decimal(18,2),(11*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=17 then  convert(decimal(18,2),(12*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=18 then  convert(decimal(18,2),(13*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=19 then  convert(decimal(18,2),(14*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)>=20 then convert(decimal(18,2),(15*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360))))
					  end
		),0)
		else
		isnull((case when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=6 then   convert(decimal(18,2),(1* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
                      when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=7 then   convert(decimal(18,2),(2* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=8 then   convert(decimal(18,2),(3* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=9 then   convert(decimal(18,2),(4* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=10 then  convert(decimal(18,2),(5* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=11 then  convert(decimal(18,2),(6* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=12 then  convert(decimal(18,2),(7* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=13 then  convert(decimal(18,2),(8* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=14 then  convert(decimal(18,2),(9* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=15 then  convert(decimal(18,2),(10*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=16 then  convert(decimal(18,2),(11*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=17 then  convert(decimal(18,2),(12*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=18 then  convert(decimal(18,2),(13*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=19 then  convert(decimal(18,2),(14*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)>=20 then convert(decimal(18,2),(15*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END)) /360.00))))
					  end
		),0)
		END
,DiasBasePeriodoVacacionesFuncionario= round(((case when (DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END))+1)>360 then 360 else (DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < getdate() THEN FechaFinalPeriodoVacacionesFuncionario ELSE getdate() END))+1) end)* 15)/360.00,2)

from PeriodoVacacionesFuncionario p
join Funcionario f on p.codigofuncionario=f.codigofuncionario
WHERE f.EstadoFuncionario=1 and p.EstadoPeriodoVacacionesFuncionario=1
--and F.CodigoFuncionario=87--300


update p set 
DiasAdicionalPeriodoVacacionesFuncionario=
         case when round(((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)))* 15)/360.00,2)>=15 then     
		 isnull((case when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=6 then   convert(decimal(18,2),(1* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
                      when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=7 then   convert(decimal(18,2),(2* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=8 then   convert(decimal(18,2),(3* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=9 then   convert(decimal(18,2),(4* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=10 then  convert(decimal(18,2),(5* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=11 then  convert(decimal(18,2),(6* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=12 then  convert(decimal(18,2),(7* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=13 then  convert(decimal(18,2),(8* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=14 then  convert(decimal(18,2),(9* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=15 then  convert(decimal(18,2),(10*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=16 then  convert(decimal(18,2),(11*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=17 then  convert(decimal(18,2),(12*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=18 then  convert(decimal(18,2),(13*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=19 then  convert(decimal(18,2),(14*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)>=20 then convert(decimal(18,2),(15*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360))))
					  end
		),0)
		else
		isnull((case when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=6 then   convert(decimal(18,2),(1* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
                      when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=7 then   convert(decimal(18,2),(2* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=8 then   convert(decimal(18,2),(3* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=9 then   convert(decimal(18,2),(4* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=10 then  convert(decimal(18,2),(5* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=11 then  convert(decimal(18,2),(6* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=12 then  convert(decimal(18,2),(7* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=13 then  convert(decimal(18,2),(8* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=14 then  convert(decimal(18,2),(9* ((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=15 then  convert(decimal(18,2),(10*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=16 then  convert(decimal(18,2),(11*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=17 then  convert(decimal(18,2),(12*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=18 then  convert(decimal(18,2),(13*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)=19 then  convert(decimal(18,2),(14*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  when round(DATEDIFF(YEAR,[dbo].[fnObtenerFechaAntiguedad](f.CodigoFuncionario),FechaFinalPeriodoVacacionesFuncionario),0)>=20 then convert(decimal(18,2),(15*((dbo.f_getDias360(FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END)) /360.00))))
					  end
		),0)
		END
,DiasBasePeriodoVacacionesFuncionario= round(((case when (DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END))+1)>360 then 360 else (DATEDIFF(DAY,FechaInicialPeriodoVacacionesFuncionario,(CASE WHEN FechaFinalPeriodoVacacionesFuncionario < FechaFinVigencia THEN FechaFinalPeriodoVacacionesFuncionario ELSE FechaFinVigencia END))+1) end)* 15)/360.00,2)
from PeriodoVacacionesFuncionario p
join Funcionario f on p.codigofuncionario=f.codigofuncionario
WHERE  p.EstadoPeriodoVacacionesFuncionario=1 and f.EstadoFuncionario=0



update p set 
p.DiasUsadosPeriodoVacacionesFuncionario=[dbo].[FN_gmas_DevuelveDiasVacacacionXPeriodo](p.CodigoFuncionario,p.CodigoPeriodoVacacionesFuncionario)
--[dbo].[FN_gmas_DevuelveDiasVacacacionExtra](f.CodigoFuncionario,'V',p.CodigoPeriodoVacacionesFuncionario)+[dbo].[FN_gmas_DevuelveDiasVacacacionExtra](f.CodigoFuncionario,'A',p.CodigoPeriodoVacacionesFuncionario)
,DiasLibresPeriodoVacacionesFuncionario=DiasTotalesPeriodoVacacionesFuncionario - [dbo].[FN_gmas_DevuelveDiasVacacacionXPeriodo](p.CodigoFuncionario,p.CodigoPeriodoVacacionesFuncionario)
,p.EstadoPeriodoVacacionesFuncionario=case when (p.DiasTotalesPeriodoVacacionesFuncionario = 15+[dbo].[FN_gmas_ObtenerDiasAntiguedadPeriodoVacacion] (P.CodigoFuncionario,P.FechaFinalPeriodoVacacionesFuncionario))
										and [dbo].[FN_gmas_DevuelveDiasVacacacionXPeriodo](p.CodigoFuncionario,p.CodigoPeriodoVacacionesFuncionario)=15+[dbo].[FN_gmas_ObtenerDiasAntiguedadPeriodoVacacion] (P.CodigoFuncionario,P.FechaFinalPeriodoVacacionesFuncionario)
									then 0 else 1 end

FROM PeriodoVacacionesFuncionario P
JOIN Funcionario F ON P.CodigoFuncionario=F.CodigoFuncionario
where p.EstadoPeriodoVacacionesFuncionario=1

DELETE from PeriodoVacacionesFuncionario where DiasBasePeriodoVacacionesFuncionario<0 AND EstadoPeriodoVacacionesFuncionario=1

--ELIMINAR PERIODOS DEL PERSONAL INVESTIGACION --Investigación - Proyectos Fondos Externos
delete pv
FROM Funcionario f
join PeriodoVacacionesFuncionario pv on pv.CodigoFuncionario=f.CodigoFuncionario
join Unidades un on f.CodigoUnidades=un.CodigoUnidades
join TipoProyectoInvestigacion a on f.CodigoProyectoInvestigacion=a.Codigo
WHERE EstadoFuncionario=1 AND CodigoRelacion=1 AND f.CodigoFuncionario NOT IN(-99)
and un.CodigoUnidades  in(3) AND A.Codigo IN(2)

--ELIMINAR PERIODOS DEL PERSONAL ACEDEMICOS
delete pv
FROM Funcionario f
join PeriodoVacacionesFuncionario pv on pv.CodigoFuncionario=f.CodigoFuncionario
join Unidades un on f.CodigoUnidades=un.CodigoUnidades
WHERE EstadoFuncionario=1 AND CodigoRelacion=1 AND f.CodigoFuncionario NOT IN(-99)
and un.CodigoUnidades  in(2) 