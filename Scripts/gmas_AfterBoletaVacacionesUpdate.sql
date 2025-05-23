

ALTER TRIGGER [dbo].[gmas_AfterBoletaVacacionesUpdate] ON [dbo].[BoletaVacaciones]
AFTER UPDATE
AS  
begin    
		
		DECLARE @CodigoBoleta int=0
		DECLARE @CodigoPeriodoVacacionesFuncionario INT=0
		DECLARE @EsConfirmado char(1)=''
		
		SELECT @CodigoBoleta = ins.IdBoletaVacaciones FROM INSERTED ins;
		SELECT @EsConfirmado = ins.EsAutorizadaBoletaVacacion FROM INSERTED ins;

		IF UPDATE(EsConfirmadaBoletaVacaciones) AND UPDATE(EsAutorizadaBoletaVacacion)
		BEGIN
			    if(@EsConfirmado='S')
				begin
			        EXEC gmas_InsertBoletaAnticipoVacaciones @CodigoBoleta
			    end
		END
END


