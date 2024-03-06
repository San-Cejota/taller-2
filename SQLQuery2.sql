CREATE PROCEDURE InsertarFacturaa
    @IdFact INT,
    @ClienteId INT,
    @Descrip varchar(150),
    @cant int,
    @precio decimal(10,2),
    @fecha datetime,
    @codeFact int,
    @EmpleId int
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Facturas (Id, Cliente, Descripcion, Cantidad, precio, Fecha, Fact_Code, EmpleId)
    VALUES (@IdFact, @ClienteID, @Descrip, @cant, @precio, GETDATE(),@codeFact,@EmpleId);
END;
EXEC InsertarFacturaa
    @IdFact = 10,
    @ClienteID = 1,
    @Descrip = 'Jugo hit',
    @cant = 3,
    @precio = 2500.00,
    @codeFact = 5,
    @EmpleId = 10;

select * from FACTURAS