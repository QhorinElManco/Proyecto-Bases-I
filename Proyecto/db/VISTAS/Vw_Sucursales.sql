CREATE VIEW VW_Sucursales_taller as (
SELECT t.idTaller, t.descripcion, s.nombre, s.direccion FROM sucursal s
INNER JOIN taller t ON t.idSucursal = s.idSucursal
)