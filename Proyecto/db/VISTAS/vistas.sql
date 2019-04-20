CREATE VIEW VW_Clientes_Facturas as (
SELECT p.pnombre,p.snombre, p.papellido, p.sapellido, f.idFactura, f.fechaEmision, f.total, fp.descripcion formaPago
FROM cliente c
INNER JOIN persona p ON p.idPersona = c.idPersona
INNER JOIN factura f ON f.idCliente = c.idCliente
INNER JOIN formapago fp ON fp.idFormaPago = f.idFormaPago
)
SELECT * FROM VW_Clientes_Facturas

--Detalle de Vehiculos con la transmision automatica, id=1
CREATE VIEW VW_VEHICULOS_AUTOMATICOS AS (
SELECT v.color, v.precioVenta, tm.descripcion TipoMotor, tv.descripcion TipoVehiculo, m.descripcion Modelo, ma.descripcion Marca, v.idTransmision
FROM vehiculo v
INNER JOIN modelo m ON m.idModelo = v.idModelo
INNER JOIN marca ma ON ma.idMarca = m.idMarca
INNER JOIN tipovehiculo tv ON tv.idTipoVehiculo = v.idTipoVehiculo
INNER JOIN tipomotor tm ON tm.idTipoGasolina = v.idTipoGasolina
WHERE idTransmision IN (SELECT idTransmision
                        FROM transmision
                        WHERE idTransmision =1)
)

--Mantenimientos por taller, de los talleres id 1 al 5
CREATE VIEW VW_Mantenimiento_En_Talleres_1_Al_5 AS (
SELECT m.idMantenimiento, concat_ws(' ', p.pnombre, p.pApellido) Mecanico, m.descripcionReparaciones, m.costo, t.descripcion Taller FROM Mantenimiento m
INNER JOIN taller t ON t.idTaller = m.idTaller
INNER JOIN empleado e ON e.idEmpleado = m.idEmpleado
INNER JOIN persona p ON p.idPersona = e.idPersona
WHERE t.idTaller BETWEEN 1 AND 5
)

--Todos los repuestos de la marca castrol
CREATE VIEW VW_REPUESTOS_CASTROL AS (
SELECT r.descripcion Repuesto, Precio, mr.descripcion Marca FROM repuestos r
INNER JOIN marcarepuesto mr ON mr.idMarcaRepuesto = r.idMarcaRepuesto
WHERE mr.idMarcaRepuesto = 6)

--Inventario de los repuestos y los repuestos
CREATE VW_REPUESTOS_VEHICULOS AS (
SELECT '' placa, '' color, r.descripcion Repuesto FROM Inventario i
INNER JOIN repuestos r ON r.idInventario = i.idInventario
UNION 
SELECT v.placa, v.color, '' Repuesto FROM Inventario i
INNER JOIN vehiculo v ON v.idInventario = i.idInventario
)

--cargos de los Empleados
CREATE VIEW VW_EMPLEADOS_CARGOS AS (
SELECT concat_ws(' ', p.pnombre, p.pApellido)Empelado, c.descripcion cargo FROM empleado e
INNER JOIN persona p ON p.idPersona = e.idPersona
INNER JOIN cargo c ON c.idCargo = e.idCargo
)


--Rentas del mes actual
CREATE VIEW VW_Renta_Mes_Actual AS (
SELECT * FROM renta r
INNER JOIN agenda a ON a.idAgenda = r.idAgenda
WHERE MONTH(a.fechaReserva) = MONTH(now())
)

--Facturas con descuentos d
CREATE VIEW VW_Facturas_Con_Descuento AS (
SELECT * FROM factura f
INNER JOIN factura_descuento fd ON fd.idFactura = f.idFactura
INNER JOIN descuento d ON d.idDescuento = fd.idDescuento
)

--Ventas de Vehiculos 
CREATE VIEW VW_Ventas_Vehiculos AS (
SELECT * FROM ventas v
INNER JOIN vehiculo vh ON vh.idVehiculo = v.idVehiculo
INNER JOIn factura f ON f.idFactura = v.idFactura
)

--Listado de los proveedores
CREATE VIEW VW_Proveedores AS (
SELECT * FROM proveedores pr
INNER JOIn tipoentrada te ON te.idProveedores = pr.idProveedores
INNER JOIn persona p On p.idPersona = pr.idPersona
)

--Listado de las rentas
CREATE VIEW VW_Proveedores AS (
SELECT * FROM solicitudrenta sr
INNER JOIN empleado e ON e.idEmpleado = sr.idEmpleado
INNER JOIN vehiculo v ON v.idVehiculo = sr.idVehiculo
)

--Listado de todos los empleados de la empresa
CREATE VIEW VW_EMPLEADOS AS(
    SELECT e.idEmpleado,p.pnombre, p.papellido, p.noIdentidad, c.descripcion FROM Empleado e
    INNER JOIN Persona p ON p.idPersona = e.idPersona
    INNER JOIN Cargo c ON c.idCargo = e.idCargo
    WHERE e.eliminado <> TRUE
)

--listado de empleado
CREATE VIEW VW_EMPLEADO_VER AS(
    SELECT e.idEmpleado, p.pnombre, p.snombre, p.papellido, p.sapellido, c.idCargo,
    p.correo,  c.descripcion cargo ,p.noIdentidad, p.direccion, e.fechaInicio
    , e.fechaFin, u.nombreUsuario, u.contraseña contrasenia, u.rutaImagen, GROUP_CONCAT(t.telefono) telefonos 
    FROM Empleado e
    INNER JOIN Persona p ON p.idPersona = e.idPersona
    INNER JOIN Cargo c ON c.idCargo = e.idCargo
    INNER JOIN Usuario u ON u.idUsuario = e.idUsuario
    INNER JOIN Telefonos t ON t.idPersona = p.idPersona
    WHERE e.eliminado <> TRUE
    GROUP BY e.idEmpleado, p.pnombre, p.snombre, p.papellido, p.sapellido, 
    p.correo,  c.descripcion ,p.noIdentidad, p.direccion, e.fechaInicio
    , e.fechaFin, u.nombreUsuario, u.contraseña, u.rutaImagen
)
