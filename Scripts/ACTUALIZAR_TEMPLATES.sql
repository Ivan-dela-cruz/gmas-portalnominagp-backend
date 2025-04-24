update [dbo].[NotificacionesTemplate] set template = N'<!DOCTYPE html>
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
'

where Codigo = 3


