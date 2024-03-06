CREATE VIEW promedioclientee AS
SELECT c.*
FROM CLIENTES c
INNER JOIN (
    SELECT Id, AVG(Precio) AS Promedio_Compras
    FROM PRODUCTOS
    GROUP BY Id
) promedio
ON c.Id = promedio.Id
INNER JOIN PRODUCTOS P
ON c.Id = P.Id
WHERE P.Precio  > promedio.Promedio_Compras;


CREATE FUNCTION FelicitarMejorCliente()
RETURNS VARCHAR(150)
AS
BEGIN
    DECLARE @mensaje VARCHAR(150);
    SELECT TOP 1 @mensaje = '¡Felicitaciones, ' + Nombre + '! Tu promedio de compras es ' + CAST(Promedio_Compras AS VARCHAR(20)) + '.'
    FROM 
    (
    SELECT c.Nombre, AVG(f.Cantidad * f.precio) as Promedio_Compras,
    ROW_NUMBER()over (ORDER BY AVG(f.Cantidad * f.precio) DESC) AS RowNumber
    from CLIENTES c 
    join FACTURAS f on c.Id = f.Cliente
    group by c.Nombre)
    as subquery
    where RowNumber= 1;
    return @mensaje 
END;

DECLARE @Resultado NVARCHAR(MAX);
SET @Resultado = dbo.FelicitarMejorCliente();
PRINT @Resultado;