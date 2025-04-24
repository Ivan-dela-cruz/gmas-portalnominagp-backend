--------------  1 CREAR TABLAS NUEVA ------------ 


-- ----------------------------
-- Table structure for NotificacionesTemplate
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[NotificacionesTemplate]') AND type IN ('U'))
	DROP TABLE [dbo].[NotificacionesTemplate]
GO

CREATE TABLE [dbo].[NotificacionesTemplate] (
  [Codigo] int  IDENTITY(1,1) NOT NULL,
  [Titulo] varchar(180) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [Asunto] varchar(180) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Descripcion] varchar(180) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Template] varchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [Estado] bit  NOT NULL,
  [Code] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL
)
GO

ALTER TABLE [dbo].[NotificacionesTemplate] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of NotificacionesTemplate
-- ----------------------------
SET IDENTITY_INSERT [dbo].[NotificacionesTemplate] ON
GO

INSERT INTO [dbo].[NotificacionesTemplate] ([Codigo], [Titulo], [Asunto], [Descripcion], [Template], [Estado], [Code]) VALUES (N'1', N'Solcitud Vaciones', N'MV -  Solcitud Vaciones', N'Solcitud Vaciones 2025', N'<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Correo de Ingreso de Solicitud</title>
  </head>
  <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 50px; margin: 0">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background-color: #fff; padding: 20px; border-radius: 10px">
      <tr>
        <td align="center">
          <table
            role="presentation"
            width="600"
            cellspacing="0"
            cellpadding="0"
            border="0"
            style="background-color: #ffffff; padding: 20px; border-collapse: collapse"
          >
            <!-- Encabezado -->
            <tr>
              <td
                style="
                  background-color: #c00;
                  color: white;
                  font-size: 18px;
                  font-weight: bold;
                  text-align: center;
                  padding: 20px;
                  border-top-right-radius: 20px;
                  border-top-left-radius: 20px;
                "
              >
                Correo de ingreso de solicitud
              </td>
            </tr>

            <!-- Contenido -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px; font-size: 14px; color: #333">
                <p>Hola <strong>@Model.EmployeeName</strong>,</p>
                <p>
                  Tu solicitud de vacaciones ha sido enviada a <strong>@Model.ApprovalName</strong> para su aprobaci�n. Ten en cuenta que el simple env�o de
                  esta solicitud no garantiza que los d�as de vacaci�n solicitados ser�n aprobados.
                </p>
                <p>Te llegar� un correo despu�s de la revisi�n realizada.</p>
              </td>
            </tr>

            <!-- Total d�as disponibles -->
            <tr>
              <td align="center">
                <table
                  role="presentation"
                  cellspacing="0"
                  cellpadding="10"
                  border="0"
                  style="background-color: #c00; color: white; font-weight: bold; border-radius: 10px"
                >
                  <tr>
                    <td style="font-size: 14px">Total d�as disponibles: @Model.AvailableDays</td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- Fechas y d�as de vacaciones -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px">
                <table role="presentation" width="100%" cellspacing="0" cellpadding="5" border="1" style="border-collapse: collapse; text-align: center">
                  <tr>
                    <th style="background-color: #f4f4f4; padding: 10px">Desde</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Hasta</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Total d�as a tomar</th>
                  </tr>
                  <tr>
                    <td style="padding: 10px">@Model.StartDateFormat</td>
                    <td style="padding: 10px">@Model.EndDateFormat</td>
                    <td style="padding: 10px">@Model.RequestDays</td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- Aprobador -->
            <tr>
              <td style="padding: 0px; text-align: center; text-align: center; width: 100%">
                <p style="text-align: center">
                  <strong>Aprobador:</strong>
                  <span style="padding: 5px; min-width: 300px; background-color: #f4f4f4; padding: 10px; border-radius: 5px">
                    &nbsp; @Model.ApprovalName &nbsp;
                  </span>
                </p>
              </td>
            </tr>

            <!-- Informaci�n de contacto -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px; font-size: 14px; color: #333">
                <p>En caso de alguna duda, por favor cont�ctate con Recursos Humanos.</p>
                <p>Saludos,<br />Departamento de Recursos Humanos</p>
              </td>
            </tr>

           
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
', N'1', N'CREACION_SOLICITUD')
GO

INSERT INTO [dbo].[NotificacionesTemplate] ([Codigo], [Titulo], [Asunto], [Descripcion], [Template], [Estado], [Code]) VALUES (N'2', N'Correo de Notificaci�n a Solicitante', N'MV - Respuesta solicitud vacaciones', N'Correo de Notificaci�n a Solicitante', N'<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Respuesta solicitud vacaciones</title>
  </head>
  <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 50px; margin: 0">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background-color: #fff; padding: 20px; border-radius: 10px">
      <tr>
        <td align="center">
          <table
            role="presentation"
            width="600"
            cellspacing="0"
            cellpadding="0"
            border="0"
            style="background-color: #ffffff; padding: 20px; border-collapse: collapse"
          >
            <!-- Encabezado -->

            <tr>
              <td
                style="
                  background-color: #c00;
                  color: #fff;
                  font-size: 18px;
                  font-weight: bold;
                  text-align: center;
                  padding: 20px;
                  border-top-right-radius: 20px;
                  border-top-left-radius: 20px;
                "
              >
              Respuesta solicitud vacaciones
              </td>
            </tr>
            <!-- Contenido -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px; color: #333">
                <p>Hola <strong>@Model.EmployeeName</strong>,</p>
                <p>Tu solicitud de vacaciones realizada por <strong>@Model.ApprovalName</strong>, ha sido <strong>@Model.ApprovalResponse</strong> .</p>
              </td>
            </tr>

            <!-- Fechas y d�as de vacaciones -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px">
                @if (Model.IsApprove) {
                <p>Los d�as de vacaciones aprobados son los siguientes:</p>
                } else {
                <p>Se ha rechazado tu solicitud de vacaciones:</p>
                }
                <table role="presentation" width="100%" cellspacing="0" cellpadding="5" border="1" style="border-collapse: collapse; text-align: center">
                  <tr>
                    <th style="background-color: #f4f4f4; padding: 10px">Desde</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Hasta</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Total d�as a tomar</th>
                  </tr>
                  <tr>
                    <td style="padding: 10px">@Model.StartDateFormat</td>
                    <td style="padding: 10px">@Model.EndDateFormat</td>
                    <td style="padding: 10px">@Model.RequestDays</td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- Historial de vacaciones -->
            <tr>
              <td style="padding: 20px">
                @if (Model.IsApprove) {
                <p>
                  Los d�as han sido registrados en el sistema. Por favor, coordina con tu jefe directo los d�as que estar�s ausente con el objetivo de no
                  afectar el servicio de tu �rea.
                </p>
                <p>Esperamos que disfrutes tu per�odo de vacaciones.</p>
                } else {
                <p>La observaci�n ingresada por tu jefe inmediato es: <strong style="color: #c00">@Model.Observation</strong></p>
                <p>
                  Estos d�as no han sido registrados en el sistema. Recuerda que puedes volver a solicitar el registro de vacaciones en una nueva solicitud.
                </p>
                }
              </td>
            </tr>

            <!-- Informaci�n de contacto -->
            <tr>
              <td style="padding-left: 20px">
                <p>Saludos,<br />Departamento de Recursos Humanos</p>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
', N'1', N'RESPUESTA_SOLICITUD')
GO

INSERT INTO [dbo].[NotificacionesTemplate] ([Codigo], [Titulo], [Asunto], [Descripcion], [Template], [Estado], [Code]) VALUES (N'3', N'Correo de Revisi�n a Jefe Directo', N'MV - Revisi�n a Jefe Directo', N'Correo de Revisi�n a Jefe Directo', N'<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Correo de Revisi�n a Jefe Directo</title>
  </head>
  <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 50px; margin: 0">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background-color: #fff; padding: 20px; border-radius: 10px">
      <tr>
        <td align="center">
          <table
            role="presentation"
            width="600"
            cellspacing="0"
            cellpadding="0"
            border="0"
            style="background-color: #ffffff; padding: 20px; border-collapse: collapse"
          >
            <!-- Encabezado -->

            <tr>
              <td
                style="
                  background-color: #c00;
                  color: #fff;
                  font-size: 18px;
                  font-weight: bold;
                  text-align: center;
                  padding: 20px;
                  border-top-right-radius: 20px;
                  border-top-left-radius: 20px;
                "
              >
                Correo de revisi�n a jefe directo
              </td>
            </tr>
            <!-- Contenido -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px; font-size: 14px; color: #333">
                <p>Hola <strong>@Model.ApprovalName</strong>,</p>
                <p>Te informamos que ha ingresado una solicitud de vacaciones de <strong>@Model.EmployeeName</strong>, con los siguientes datos:</p>
              </td>
            </tr>

            <!-- Fechas y d�as de vacaciones -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px">
                <table role="presentation" width="100%" cellspacing="0" cellpadding="5" border="1" style="border-collapse: collapse; text-align: center">
                  <tr>
                    <th style="background-color: #f4f4f4; padding: 10px">Desde</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Hasta</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Total d�as a tomar</th>
                  </tr>
                  <tr>
                    <td style="padding: 10px">@Model.StartDateFormat</td>
                    <td style="padding: 10px">@Model.EndDateFormat</td>
                    <td style="padding: 10px">@Model.RequestDays</td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- Total d�as disponibles -->
            <tr>
              <td align="center" style="padding: 15px">
                <table
                  role="presentation"
                  cellspacing="0"
                  cellpadding="10"
                  border="0"
                  style="background-color: #c00; color: white; font-weight: bold; border-radius: 10px"
                >
                  <tr>
                    <td style="font-size: 14px">D�as disponibles (sin descontar los d�as solicitados): @Model.AvailableDays</td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- Historial de vacaciones -->
            <tr>
              <td style="padding: 20px">
                <p>Historial de vacaciones de los �ltimos per�odos:</p>
                <table
                  role="presentation"
                  width="100%"
                  cellspacing="0"
                  cellpadding="5"
                  border="1"
                  style="border-collapse: collapse; text-align: center; font-size: 12px"
                >
                  <thead>
                    <tr>
                      <th style="width: 80px">Desde</th>
                      <th style="width: 80px">Hasta</th>
                      <th>D�as ganados</th>
                      <th>D�as ganados por antig�edad</th>
                      <th>Total d�as de vacaci�n</th>
                      <th>D�as tomados</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach (var item in Model.detail) {
                    <tr>
                      <td style="width: 80px">@item.StartDateFormat</td>
                      <td style="width: 80px">@item.EndDateFormat</td>
                      <td>@item.DaysEarned</td>
                      <td>@item.DaysEarnedBySeniority</td>
                      <td>@item.TotalVacationDays</td>
                      <td>@item.UsedDays</td>
                    </tr>
                    }
                  </tbody>
                </table>
              </td>
            </tr>

            <!-- Aprobaci�n -->
            <tr>
              <td style="padding: 15px; text-align: center">
                <p>
                  Por favor selecciona
                  <a href="@Model.UrlApproval" style="color: rgb(11, 170, 190); font-weight: bold; text-decoration: underline">APROBAR</a>
                  para confirmar los d�as solicitados o
                  <a href="@Model.UrlReject" style="color: rgb(219, 51, 51); font-weight: bold; text-decoration: underline">RECHAZAR</a>
                  para denegar los d�as solicitados..
                </p>
              </td>
            </tr>

            <!-- Informaci�n de contacto -->
            <tr>
              <td style="padding: 20px; font-size: 14px; color: #333">
                <p style="font-style: italic">
                  Te recordamos que: El per�odo de vacaciones para el personal de apoyo acad�mico y administrativo, est� programado en diciembre-enero de cada
                  a�o. Aquellos colaboradores que deseen tomar vacaciones en otro per�odo, pueden hacerlo con aprobaci�n de su jefe directo mediante esta
                  solicitud. Los d�as de vacaci�n por antig�edad deber�n ser tomados en los recesos acad�micos de cada per�odo acad�mico, salvo excepciones
                  autorizadas por tu jefe directo.
                </p>
                <p>En caso de alguna duda, por favor cont�ctate con Recursos Humanos.</p>
                <p>Saludos,<br />Departamento de Recursos Humanos</p>
              </td>
            </tr>

         
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
', N'1', N'APROBACION_SOLCITUD')
GO

INSERT INTO [dbo].[NotificacionesTemplate] ([Codigo], [Titulo], [Asunto], [Descripcion], [Template], [Estado], [Code]) VALUES (N'4', N'Restablecer Contrase�a', N'MV - Solicitud Restablecer Contrase�a', N'Modulo Vacaciones - Solicitud Restablecer Contrase�a', N'<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Resatablecer Contrase�a</title>
  </head>
  <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 50px; margin: 0">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background-color: #fff; padding: 20px; border-radius: 10px">
      <tr>
        <td align="center">
          <table
            role="presentation"
            width="600"
            cellspacing="0"
            cellpadding="0"
            border="0"
            style="background-color: #ffffff; padding: 20px; border-collapse: collapse"
          >
            <!-- Encabezado -->

            <tr>
              <td
                style="
                  background-color: #c00;
                  color: #fff;
                  font-size: 18px;
                  font-weight: bold;
                  text-align: center;
                  padding: 20px;
                  border-top-right-radius: 20px;
                  border-top-left-radius: 20px;
                "
              >
                Resatablecer Contrase�a - Modulo de Vacaciones
              </td>
            </tr>
            <!-- Contenido -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px; font-size: 14px; color: #333">
                <p>Hola <strong>@Model.Names</strong>,</p>
                <p>
                  Le informamos que se ha recibido una solicitud para restablecer la contrase�a de su cuenta del <strong>m�dulo de vacaciones</strong>.
                  Para proceder, haga clic en el bot�n <strong>"Restablecer contrase�a"</strong>.
                </p>
              </td>
            </tr>

             <!-- Bot�n de Restabler -->
             <tr>
              <td align="center" style="padding-bottom: 20px">
                <table role="presentation" cellspacing="0" cellpadding="0" border="0">
                  <tr>
                    <td style="background-color: #c00;padding: 15px; text-align: center; border-radius: 30px; width: 300px; color: #fff">
                      <a href="@Model.UrlRedirect" style="color: #fff; font-size: 16px; text-decoration: none; font-weight: bold">Restabler Contrase�a</a>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- Informaci�n de contacto -->
            <tr>
              <td style="padding: 20px; font-size: 14px; color: #333">
                <p style="font-style: italic">
                  Si no ha solicitado el restablecimiento de su contrase�a, le solicitamos que desestime este mensaje. Para cualquier consulta o si necesita reportar este correo, por favor, p�ngase en contacto con el Administrador.
                </p>
       
              </td>
            </tr>

            <tr>
              <td style="padding: 20px; font-size: 14px; color: #333">
                <p>Saludos,<br />Departamento de Recursos Humanos</p>
              </td>
            </tr>

           
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>


', N'1', N'RESET_PASSWORD')
GO

SET IDENTITY_INSERT [dbo].[NotificacionesTemplate] OFF
GO


-- ----------------------------
-- Auto increment value for NotificacionesTemplate
-- ----------------------------
DBCC CHECKIDENT ('[dbo].[NotificacionesTemplate]', RESEED, 4)
GO


-- ----------------------------
-- Primary Key structure for table NotificacionesTemplate
-- ----------------------------
ALTER TABLE [dbo].[NotificacionesTemplate] ADD CONSTRAINT [PK__Notifica__06370DAD5D702395] PRIMARY KEY CLUSTERED ([Codigo])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO






	CREATE TABLE SecurityTokens (
		Token VARCHAR(512) PRIMARY KEY,  
		Origin varchar(100),
		ModelId int null,
		ModelKey varchar(255) null,
		ExpirationDateTime DATETIME,
		IsValid bit,
		IsUsed bit,
		AdditionalInformation varchar(max) null,
		UserCreated  varchar(255) null,
	);

--------------  1 CREAR TABLAS NUEVA ------------ 


-------------- 2 ACTUALIZAR FUNCIONARIO PARA ENVIO DE SOLICITUDES MASIVAS --------------------

select Constrasena, EstadoFuncionario, CodigoRelacion from Funcionario where CodigoFuncionario = -99
update  Funcionario set CodigoRelacion=1, IdentificacionFuncionario = '123456789', Constrasena = (select Constrasena from Funcionario where CodigoFuncionario = 143 ) where CodigoFuncionario = -99

-------------- 2 ACTUALIZAR FUNCIONARIO PARA ENVIO DE SOLICITUDES MASIVAS --------------------