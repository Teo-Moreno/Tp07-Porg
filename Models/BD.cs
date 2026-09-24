using Dapper;
using Microsoft.Data.SqlClient;

namespace Tp07.Models;

public static class BD
{
    private static string ConnectionString =
        @"Server=localhost;Database=DBRedSocial;User Id=alumno;Password=alumno;TrustServerCertificate=True;";


    private static SqlConnection Conectar() => new SqlConnection(ConnectionString);


    public static Usuario? Login(string nombreUsuario, string contrasena)
    {
        const string sql = @"
            SELECT Id, NombreUsuario, Nombre, Apellido
            FROM Usuarios
            WHERE NombreUsuario = @NombreUsuario
              AND [Contraseña] = @Contrasena COLLATE Latin1_General_CS_AS";

        using var db = Conectar();
        return db.QueryFirstOrDefault<Usuario>(sql, new { NombreUsuario = nombreUsuario, Contrasena = contrasena });
    }

    public static bool ExisteNombreUsuario(string nombreUsuario)
    {
        const string sql = "SELECT COUNT(1) FROM Usuarios WHERE NombreUsuario = @NombreUsuario";

        using var db = Conectar();
        return db.ExecuteScalar<int>(sql, new { NombreUsuario = nombreUsuario }) > 0;
    }

    public static int Registrar(Usuario usuario, string contrasena)
    {
        const string sql = @"
            INSERT INTO Usuarios (NombreUsuario, [Contraseña], Nombre, Apellido)
            VALUES (@NombreUsuario, @Contrasena, @Nombre, @Apellido);
            SELECT CAST(SCOPE_IDENTITY() AS int);";

        using var db = Conectar();
        return db.ExecuteScalar<int>(sql, new
        {
            usuario.NombreUsuario,
            Contrasena = contrasena,
            usuario.Nombre,
            usuario.Apellido
        });
    }

    public static List<Publicacion> ObtenerPublicaciones(int desde, int cantidad, int idUsuarioActual)
    {
        const string sqlPublicaciones = @"
            SELECT p.Id, p.IdUsuario,
                   ISNULL(p.Titulo, '') AS Titulo,
                   ISNULL(CAST(p.Descripcion AS varchar(max)), '') AS Descripcion,
                   ISNULL(p.Imagen, '') AS Imagen,
                   p.FechaPublicacion,
                   u.NombreUsuario,
                   (SELECT COUNT(*) FROM PublicacionesMeGusta mg
                     WHERE mg.[IdPublicación] = p.Id) AS CantidadMeGusta,
                   CAST(CASE WHEN EXISTS (SELECT 1 FROM PublicacionesMeGusta mg
                                           WHERE mg.[IdPublicación] = p.Id
                                             AND mg.IdUsuario = @IdUsuarioActual)
                             THEN 1 ELSE 0 END AS bit) AS UsuarioDioMeGusta
            FROM Publicaciones p
            INNER JOIN Usuarios u ON u.Id = p.IdUsuario
            ORDER BY p.FechaPublicacion DESC, p.Id DESC
            OFFSET @Desde ROWS FETCH NEXT @Cantidad ROWS ONLY";

        const string sqlComentarios = @"
            SELECT c.Id, c.IdPublicacion, c.IdUsuarioComenta,
                   CAST(c.Texto AS varchar(max)) AS Texto,
                   c.FechaComentario, u.NombreUsuario
            FROM Comentarios c
            INNER JOIN Usuarios u ON u.Id = c.IdUsuarioComenta
            WHERE c.IdPublicacion IN @Ids
            ORDER BY c.FechaComentario, c.Id";

        using var db = Conectar();
        var publicaciones = db.Query<Publicacion>(sqlPublicaciones, new
        {
            Desde = desde,
            Cantidad = cantidad,
            IdUsuarioActual = idUsuarioActual
        }).ToList();

        if (publicaciones.Count == 0) return publicaciones;

        var comentarios = db.Query<Comentario>(sqlComentarios, new { Ids = publicaciones.Select(p => p.Id) });
        var comentariosPorPublicacion = comentarios.ToLookup(c => c.IdPublicacion);

        foreach (var p in publicaciones)
            p.Comentarios = comentariosPorPublicacion[p.Id].ToList();

        return publicaciones;
    }

    public static int ContarPublicaciones()
    {
        using var db = Conectar();
        return db.ExecuteScalar<int>("SELECT COUNT(*) FROM Publicaciones");
    }

    public static bool ExistePublicacion(int idPublicacion)
    {
        using var db = Conectar();
        return db.ExecuteScalar<int>("SELECT COUNT(1) FROM Publicaciones WHERE Id = @Id", new { Id = idPublicacion }) > 0;
    }

    public static void CrearPublicacion(Publicacion publicacion)
    {
        const string sql = @"
            INSERT INTO Publicaciones (IdUsuario, Titulo, Descripcion, Imagen, FechaPublicacion)
            VALUES (@IdUsuario, @Titulo, @Descripcion, @Imagen, @FechaPublicacion)";

        using var db = Conectar();
        db.Execute(sql, publicacion);
    }

    
    public static (bool leGusta, int cantidad) AlternarMeGusta(int idPublicacion, int idUsuario)
    {
        const string sqlAlternar = @"
            IF EXISTS (SELECT 1 FROM PublicacionesMeGusta
                        WHERE [IdPublicación] = @IdPublicacion AND IdUsuario = @IdUsuario)
            BEGIN
                DELETE FROM PublicacionesMeGusta
                 WHERE [IdPublicación] = @IdPublicacion AND IdUsuario = @IdUsuario;
                SELECT CAST(0 AS bit);
            END
            ELSE
            BEGIN
                INSERT INTO PublicacionesMeGusta ([IdPublicación], IdUsuario)
                VALUES (@IdPublicacion, @IdUsuario);
                SELECT CAST(1 AS bit);
            END";

        const string sqlContar = "SELECT COUNT(*) FROM PublicacionesMeGusta WHERE [IdPublicación] = @IdPublicacion";

        var parametros = new { IdPublicacion = idPublicacion, IdUsuario = idUsuario };

        using var db = Conectar();
        bool leGusta = db.ExecuteScalar<bool>(sqlAlternar, parametros);
        int cantidad = db.ExecuteScalar<int>(sqlContar, parametros);
        return (leGusta, cantidad);
    }


    public static Comentario AgregarComentario(int idPublicacion, int idUsuario, string texto)
    {
        const string sql = @"
            DECLARE @Id int;

            INSERT INTO Comentarios (IdPublicacion, IdUsuarioComenta, Texto, FechaComentario)
            VALUES (@IdPublicacion, @IdUsuario, @Texto, @Fecha);

            SET @Id = SCOPE_IDENTITY();

            SELECT c.Id, c.IdPublicacion, c.IdUsuarioComenta,
                   CAST(c.Texto AS varchar(max)) AS Texto,
                   c.FechaComentario, u.NombreUsuario
            FROM Comentarios c
            INNER JOIN Usuarios u ON u.Id = c.IdUsuarioComenta
            WHERE c.Id = @Id;";

        using var db = Conectar();
        return db.QuerySingle<Comentario>(sql, new
        {
            IdPublicacion = idPublicacion,
            IdUsuario = idUsuario,
            Texto = texto,
            Fecha = DateTime.Now
        });
    }
}
