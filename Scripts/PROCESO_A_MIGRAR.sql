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
                  Tu solicitud de vacaciones ha sido enviada a <strong>@Model.ApprovalName</strong> para su aprobación. Ten en cuenta que el simple envío de
                  esta solicitud no garantiza que los días de vacación solicitados serán aprobados.
                </p>
                <p>Te llegará un correo después de la revisión realizada.</p>
              </td>
            </tr>

            <!-- Total días disponibles -->
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
                    <td style="font-size: 14px">Total días disponibles: @Model.AvailableDays</td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- Fechas y días de vacaciones -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px">
                <table role="presentation" width="100%" cellspacing="0" cellpadding="5" border="1" style="border-collapse: collapse; text-align: center">
                  <tr>
                    <th style="background-color: #f4f4f4; padding: 10px">Desde</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Hasta</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Total días a tomar</th>
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

            <!-- Información de contacto -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px; font-size: 14px; color: #333">
                <p>En caso de alguna duda, por favor contáctate con Recursos Humanos.</p>
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

INSERT INTO [dbo].[NotificacionesTemplate] ([Codigo], [Titulo], [Asunto], [Descripcion], [Template], [Estado], [Code]) VALUES (N'2', N'Correo de Notificación a Solicitante', N'MV - Respuesta solicitud vacaciones', N'Correo de Notificación a Solicitante', N'<!DOCTYPE html>
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

            <!-- Fechas y días de vacaciones -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px">
                @if (Model.IsApprove) {
                <p>Los días de vacaciones aprobados son los siguientes:</p>
                } else {
                <p>Se ha rechazado tu solicitud de vacaciones:</p>
                }
                <table role="presentation" width="100%" cellspacing="0" cellpadding="5" border="1" style="border-collapse: collapse; text-align: center">
                  <tr>
                    <th style="background-color: #f4f4f4; padding: 10px">Desde</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Hasta</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Total días a tomar</th>
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
                  Los días han sido registrados en el sistema. Por favor, coordina con tu jefe directo los días que estarás ausente con el objetivo de no
                  afectar el servicio de tu área.
                </p>
                <p>Esperamos que disfrutes tu período de vacaciones.</p>
                } else {
                <p>La observación ingresada por tu jefe inmediato es: <strong style="color: #c00">@Model.Observation</strong></p>
                <p>
                  Estos días no han sido registrados en el sistema. Recuerda que puedes volver a solicitar el registro de vacaciones en una nueva solicitud.
                </p>
                }
              </td>
            </tr>

            <!-- Información de contacto -->
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

INSERT INTO [dbo].[NotificacionesTemplate] ([Codigo], [Titulo], [Asunto], [Descripcion], [Template], [Estado], [Code]) VALUES (N'3', N'Correo de Revisión a Jefe Directo', N'MV - Revisión a Jefe Directo', N'Correo de Revisión a Jefe Directo', N'<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Correo de Revisión a Jefe Directo</title>
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
                Correo de revisión a jefe directo
              </td>
            </tr>
            <!-- Contenido -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px; font-size: 14px; color: #333">
                <p>Hola <strong>@Model.ApprovalName</strong>,</p>
                <p>Te informamos que ha ingresado una solicitud de vacaciones de <strong>@Model.EmployeeName</strong>, con los siguientes datos:</p>
              </td>
            </tr>

            <!-- Fechas y días de vacaciones -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px">
                <table role="presentation" width="100%" cellspacing="0" cellpadding="5" border="1" style="border-collapse: collapse; text-align: center">
                  <tr>
                    <th style="background-color: #f4f4f4; padding: 10px">Desde</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Hasta</th>
                    <th style="background-color: #f4f4f4; padding: 10px">Total días a tomar</th>
                  </tr>
                  <tr>
                    <td style="padding: 10px">@Model.StartDateFormat</td>
                    <td style="padding: 10px">@Model.EndDateFormat</td>
                    <td style="padding: 10px">@Model.RequestDays</td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- Total días disponibles -->
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
                    <td style="font-size: 14px">Días disponibles (sin descontar los días solicitados): @Model.AvailableDays</td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- Historial de vacaciones -->
            <tr>
              <td style="padding: 20px">
                <p>Historial de vacaciones de los últimos períodos:</p>
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
                      <th>Días ganados</th>
                      <th>Días ganados por antigüedad</th>
                      <th>Total días de vacación</th>
                      <th>Días tomados</th>
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

            <!-- Aprobación -->
            <tr>
              <td style="padding: 15px; text-align: center">
                <p>
                  Por favor selecciona
                  <a href="@Model.UrlApproval" style="color: rgb(11, 170, 190); font-weight: bold; text-decoration: underline">APROBAR</a>
                  para confirmar los días solicitados o
                  <a href="@Model.UrlReject" style="color: rgb(219, 51, 51); font-weight: bold; text-decoration: underline">RECHAZAR</a>
                  para denegar los días solicitados..
                </p>
              </td>
            </tr>

            <!-- Información de contacto -->
            <tr>
              <td style="padding: 20px; font-size: 14px; color: #333">
                <p style="font-style: italic">
                  Te recordamos que: El período de vacaciones para el personal de apoyo académico y administrativo, está programado en diciembre-enero de cada
                  año. Aquellos colaboradores que deseen tomar vacaciones en otro período, pueden hacerlo con aprobación de su jefe directo mediante esta
                  solicitud. Los días de vacación por antigüedad deberán ser tomados en los recesos académicos de cada período académico, salvo excepciones
                  autorizadas por tu jefe directo.
                </p>
                <p>En caso de alguna duda, por favor contáctate con Recursos Humanos.</p>
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

INSERT INTO [dbo].[NotificacionesTemplate] ([Codigo], [Titulo], [Asunto], [Descripcion], [Template], [Estado], [Code]) VALUES (N'4', N'Restablecer Contraseña', N'MV - Solicitud Restablecer Contraseña', N'Modulo Vacaciones - Solicitud Restablecer Contraseña', N'<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Resatablecer Contraseña</title>
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
                Resatablecer Contraseña - Modulo de Vacaciones
              </td>
            </tr>
            <!-- Contenido -->
            <tr>
              <td style="padding-left: 20px; padding-top: 10px; font-size: 14px; color: #333">
                <p>Hola <strong>@Model.Names</strong>,</p>
                <p>
                  Le informamos que se ha recibido una solicitud para restablecer la contraseña de su cuenta del <strong>módulo de vacaciones</strong>.
                  Para proceder, haga clic en el botón <strong>"Restablecer contraseña"</strong>.
                </p>
              </td>
            </tr>

             <!-- Botón de Restabler -->
             <tr>
              <td align="center" style="padding-bottom: 20px">
                <table role="presentation" cellspacing="0" cellpadding="0" border="0">
                  <tr>
                    <td style="background-color: #c00;padding: 15px; text-align: center; border-radius: 30px; width: 300px; color: #fff">
                      <a href="@Model.UrlRedirect" style="color: #fff; font-size: 16px; text-decoration: none; font-weight: bold">Restabler Contraseña</a>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- Información de contacto -->
            <tr>
              <td style="padding: 20px; font-size: 14px; color: #333">
                <p style="font-style: italic">
                  Si no ha solicitado el restablecimiento de su contraseña, le solicitamos que desestime este mensaje. Para cualquier consulta o si necesita reportar este correo, por favor, póngase en contacto con el Administrador.
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