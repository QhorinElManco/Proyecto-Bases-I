CREATE VIEW VW_SOLICITUDES_MANTENIMIENTO as (
SELECT sm.idSolicitudMantenimiento, m.descripcion, CONCAT_WS(' ',pe.pnombre, pe.papellido, pe.sapellido) AS empleado,
    tm.descripcion AS tipomantenimiento, sm.fechaSolicitud, 
    sm.fechaFin, sm.idCliente, sm.estado FROM solicitudMantenimiento sm
    INNER JOIN vehiculo v ON v.idVehiculo=sm.idVehiculo
    INNER JOIN modelo m ON m.idModelo=v.idModelo
    INNER JOIN empleado e ON e.idEmpleado=sm.idEmpleado
    INNER JOIN persona pe ON pe.idPersona=e.idPersona
    INNER JOIN tipomantenimiento tm ON tm.idTipoMantenimiento=sm.idTipoMantenimiento
)