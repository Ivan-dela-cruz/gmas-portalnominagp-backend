


select TOP 5 * from dbo.BoletaVacaciones --where CodigoFuncionario = 18 and EsConfirmadaBoletaVacaciones = 'N' and IdBoletaVacaciones <> 220  

order by 1 desc

select id,  EmailTO, EmailCC, [Subject], Body2 as Template, Enviado 
from EnvioMail_Cabecera 
where Enviado = 0




--- ADMINISTRATIVO [VACACIONES]
--- APOYO ACADÉMICO [VACACIONES]

--- [NO VACACIONES]
--- ACADÉMICO 
--- PROFESOR ADJUNTO 

update Funcionario set EsPrimerIngreso = 1 where CodigoFuncionario = 18

update Funcionario set EsPrimerIngreso = 0 where CodigoFuncionario = 18




select * from SecurityTokens

update SecurityTokens set IsUsed = 0, IsValid = 1

select Constrasena ,CorreoElectronicoFuncionario, CorreoElectronicoFuncionarioPersonal,CodigoRelacion,EsPrimerIngreso,IdentificacionFuncionario,* from Funcionario 
where  CodigoFuncionario = 18

select * from SecurityTokens

update Funcionario set EsPrimerIngreso = 0, Constrasena = 'yl8OnCbqEh4xR4DuxuRFLA==' where CodigoFuncionario = 18
-- yl8OnCbqEh4xR4DuxuRFLA==


delete dbo.BoletaVacaciones where IdBoletaVacaciones > 100
delete EnvioMail_Cabecera 
delete SecurityTokens

select * from SecurityTokens

update Funcionario set CorreoElectronicoFuncionario = 'icruz@grupomas.com', CorreoElectronicoFuncionarioPersonal = 'icruz@grupomas.com' where CodigoFuncionario = 18
 update EnvioMail_Cabecera set EmailCC = 'icruz@grupomas.com'


  [dbo].[gmas_balconv2GetPeriodoVacacionFuncionario] '1713698098'
 [dbo].[gmas_balconv2GetPeriodoVacacionFuncionario] '1714830211'
 [dbo].[gmas_balconv2GetPeriodoVacacionFuncionario] '1725875577'


 [dbo].[gmas_balconv2GetPeriodoVacacionFuncionario] '1724518087'

 -- 1709160400 - 18 
 -- 1724518087 - 143


 SELECT * FROM Funcionario where CodigoFuncionario = -99


