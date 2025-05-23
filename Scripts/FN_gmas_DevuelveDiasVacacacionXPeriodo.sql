
CREATE function [dbo].[FN_gmas_DevuelveDiasVacacacionXPeriodo]
(
@Codigofuncionario int
,@CodigoPeriodoVacacion int=0
)
returns DECIMAL(18,2)
as
BEGIN
    declare @CantidadDias int=0

	select @CantidadDias=CONVERT(DECIMAL(18,2),isnull(sum(CantidadDiasVacacion),0))
	from BoletaVacaciones bv
	join PeriodoVacacionesFuncionario pv on bv.CodigoPeriodoVacacionesFuncionario=pv.CodigoPeriodoVacacionesFuncionario
	where bv.codigofuncionario=@Codigofuncionario
	and bv.EsAutorizadaBoletaVacacion='S'
	and bv.EsConfirmadaBoletaVacaciones='S'
	and pv.CodigoPeriodoVacacionesFuncionario=@CodigoPeriodoVacacion
			
	return @CantidadDias
end